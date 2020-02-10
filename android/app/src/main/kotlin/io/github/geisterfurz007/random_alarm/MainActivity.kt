package io.github.geisterfurz007.random_alarm

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.plugins.shim.ShimPluginRegistry
import io.flutter.plugins.androidalarmmanager.AndroidAlarmManagerPlugin
import io.flutter.plugins.pathprovider.PathProviderPlugin
import boaventura.com.devel.br.flutteraudioquery.FlutterAudioQueryPlugin

class MainActivity: FlutterActivity() {

  override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
    println("Hallo? Ist da irgendjemand?")
    val shimPluginRegistry = ShimPluginRegistry(flutterEngine)
    flutterEngine.plugins.add(AndroidAlarmManagerPlugin())
    PathProviderPlugin.registerWith(shimPluginRegistry.registrarFor("io.flutter.plugins.pathprovider.PathProviderPlugin"))
    FlutterAudioQueryPlugin.registerWith(shimPluginRegistry.registrarFor("boaventura.com.devel.br.flutteraudioquery.FlutterAudioQueryPlugin"))
  }

}
