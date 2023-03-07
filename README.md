# This project is archived

While I had a usecase for this app years ago, I don't anymore and as you can see, it's way outdated after 2 years without attention. For some it might still serve as inspiration but at this point, this is so outdated that I'd have to rebuild it from the ground up which I don't have the time for.

# Random Alarm

An alarm app that lets you configure a list of sounds or music to wake you up with a random one each morning!

The app is built roughly following a design concept by [Alex on Dribble](https://dribbble.com/shots/5068840-Alarm-App):

![Alarm App concept by Alex on Dribble](https://cdn.dribbble.com/users/1269204/screenshots/5068840/alarm_app_4x.png)

# Running for yourself

1. Clone the repository
```
git clone https://github.com/geisterfurz007/random-alarm.git
```

2. Switch directory and install dependencies
```
cd random-alarm
flutter pub get
```

3. Adapt alarm manager package to work on the homescreen. The required changes are described in https://github.com/flutter/flutter/issues/30555#issuecomment-501597824 (path may vary due to a different version being installed; you are also not looking for the `android_alarm_manager-version` directory but `android_alarm_manager_plus-version` directory).

4. Run the build runner
```
flutter packages pub run build_runner build
```

5. Launch on a phone or emulator of your choice using `flutter run` or your favourite IDE / editor


# Different screens

Main screen:

![Main screen](https://user-images.githubusercontent.com/26303198/78984346-48e28580-7b26-11ea-932f-23d8f3f18ce8.png)

Edit screen:

![Edit screen](https://user-images.githubusercontent.com/26303198/78984373-5c8dec00-7b26-11ea-8120-d07890608036.png)

Alarm screen:

![Alarm screen](https://user-images.githubusercontent.com/26303198/78984586-ea69d700-7b26-11ea-8e27-6edb27bc971f.png)


## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
