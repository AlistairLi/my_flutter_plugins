# ime_language_detector

A Flutter plugin to detect the current input method editor (IME) language on Android and iOS
devices.

Note: This feature is not yet available on the iOS platform. We welcome your support.

## Installation

Add the dependency in `pubspec.yaml`:

```yaml 
dependencies:
  ime_language_detector: ^<latest_version>
```

Then run:

``` bash
flutter pub get
```

## Usage

```dart
import 'package:ime_language_detector/ime_language_detector.dart';

void main() async {
  var imeLanguages = await ImeLanguageDetector().getImeLanguages();
  var result = imeLanguages?.join(',') ?? '';
}
```

## Example

See the example directory for a complete sample app.

## License

The project is under the MIT license.