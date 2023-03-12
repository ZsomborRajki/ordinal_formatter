# ordinal_formatter

A simple flutter plugin to convert numbers into ordinal string using the built in native iOS and android libraries.

## Usage
```dart
import 'package:ordinal_formatter/ordinal_formatter.dart';

String ordinalNumber;
try {
    ordinalNumber = await OrdinalFormatter().format(2, 'en_US') ?? 'Unknown number';
} on PlatformException catch (e) {
    ordinalNumber = 'Formatting failed: $e';
}
```

## Features
- [X] iOS Support
- [X] Android Support

## TODO
- [] web support