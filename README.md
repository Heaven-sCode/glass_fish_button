# glass_fish_button
<img src="https://theheavenscode.com/assets/images/Technologies/glassfish.gif" alt="A screenshot of the project" width="500">

A Flutter package that recreates the glassmorphism download button pictured in the prompt. Choose between light and dark variants at the call-site via the `brightness` parameter.

## Getting started

Add the package to your `pubspec.yaml` (set it up for local development or publish to pub). Then import the library and drop the widget in your tree:

```dart
import 'package:glass_fish_button/glass_fish_button.dart';

GlassFishButton(
  label: 'Download for Mac',
  brightness: GlassFishButtonBrightness.light,
  onPressed: () {},
);
```

Flip the look to the darker treatment by setting `brightness` to `GlassFishButtonBrightness.dark`.

An example app that toggles between both themes lives under `example/lib/main.dart`.
