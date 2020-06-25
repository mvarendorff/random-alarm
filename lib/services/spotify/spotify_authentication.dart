import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:spotify/spotify.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

/// Service to handle things like sending the user to the authentication page,
/// processing their credentials, redoing the authentication flow in case
/// the token runs out, storing and loading the token, etc

class SpotifyAuthentication {

  Future<SpotifyApi> loadSpotifyApi() async {
    await DotEnv().load('assets/.env');
    final id = DotEnv().env['SPOTIFY_CLIENT_ID'];
    final secret = DotEnv().env['SPOTIFY_CLIENT_SECRET'];

    final credentials = SpotifyApiCredentials(id, secret);
    final grant = SpotifyApi.authorizationCodeGrant(credentials);

    final redirectUri = 'gf007ra://spotify.redirect';
    final scopes = ['user-read-private', 'user-read-email', 'user-read-currently-playing'];
    final authUri = grant.getAuthorizationUrl(Uri.parse(redirectUri), scopes: scopes);

    if (await canLaunch(authUri.toString())) {
      await launch(authUri.toString());
    }

    final linkback = await getLinksStream().first;
    if (!linkback.startsWith(redirectUri)) {
      throw "Didn't get redirect from correct link! Link was $linkback";
    }

    print("Linkback: $linkback");

    return SpotifyApi.fromAuthCodeGrant(grant, linkback);
  }

}
