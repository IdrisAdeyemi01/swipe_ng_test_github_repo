# swipe_test_github_repos

This is the repository that contains the source code for the SwipeNG mobile assessment app created with Flutter.

### Usage 

To use the app, firstly, clone the repo on your local device.

In Android Studio or VSCode (or other IDEs)) which Flutter SDK has been installed in earlier, go to open project folder (or open Flutter project as the case may be) and select the folder that cloned repos go to. After it has been fully analyzed, go to the command prompt (with the current directory of the folder), then run `flutter run`. Or click Ctrl + F5 (or simply F5) as the case may be for different IDEs. Make sure the mobile phone or Emulator is connected appropriately too.

After successful run, a simple counter app should be displayed.

[How to install Flutter](https://docs.flutter.dev/get-started/install)

### Libraries Used

All dependencies used can be found on [pub.dev](https://pub.dev)

### Implementation 

The project was implemented using a particular custom architecture similar to the MVVM

- ViewModels are named `notifiers`
- Class dependency injection and state management are managed using Riverpod
- The project uses the repository approach
- Services for performing network requests, navigation, amongst others are grouped

### Limitation

The project depends on the Github API. This means that whenever Github is having a downtime, the project throws an error.