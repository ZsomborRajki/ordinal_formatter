import 'package:ordinal_formatter/ordinal_formatter_platform_interface.dart';

/// Base class for ordinal formatters.
class OrdinalFormatter {
  /// Formats the given integer value into localized ordinal string form.
  ///
  /// [number] the integer value to be converted into ordial form must not
  ///  be null.
  /// For example: 1, 111
  ///
  /// [localeCode] optinal locale code to be used for formatting
  /// if no locale code is provided, the default device locale will be used.
  ///
  /// ISO-639-1 language code and ISO-3166-1 country code separated by
  /// an underscore character.
  ///
  /// For example, en_US, en_GB, fr_FR, fr_CA, de_DE, de_AT, pt_BR, pt_PT,
  ///  es_ES, es_MX, it_IT, ja_JP, zh_CN, zh_TW.
  ///
  /// BCP 47 standard is also supported.
  /// For example, en-US, en-GB, fr-FR, fr-CA, de-DE, de-AT, pt-BR, pt-PT,
  ///  es-ES, es-MX, it-IT, ja-JP, zh-CN, zh-TW.
  ///
  ///  Example:
  /// ```dart
  ///  String ordinalNumber;
  ///  try {
  ///     ordinalNumber = await OrdinalFormatter().format(91, 'en_US')
  ///            ?? 'Unknown number';
  ///  } on PlatformException catch (e) {
  ///     ordinalNumber = 'Formatting failed: $e';
  ///  }
  ///
  ///
  /// ```
  Future<String?> format(int number, [String? localeCode]) =>
      OrdinalFormatterPlatform.instance.format(number, localeCode);
}
