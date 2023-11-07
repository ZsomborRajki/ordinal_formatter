// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'ordinal_formatter_platform_interface.dart';

/// A web implementation of the OrdinalFormatterPlatform of the OrdinalFormatter plugin.
class OrdinalFormatterWeb extends OrdinalFormatterPlatform {
  final defaultLocale = 'en';

  static void registerWith(Registrar registrar) {
    OrdinalFormatterPlatform.instance = OrdinalFormatterWeb();
  }

  @override
  Future<String?> format(int number, [String? localeCode]) async {
    //https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Intl/PluralRules
    final ordinalFormatter = js.JsObject(js.context['Intl']['PluralRules'], [
      localeCode ?? defaultLocale,
      {'type': 'ordinal'}
    ]);
    
    final ordinalRules = ordinalFormatter.callMethod('select', [number]);
    //
    final suffix = ordinalSuffixes[localeCode ?? defaultLocale]?[ordinalRules];
    return '$number$suffix';
  }

  // Localized ordinal documentation can be found at-
  // https://www.unicode.org/cldr/charts/43/supplemental/language_plural_rules.html
  final Map<String, Map<String, String>> ordinalSuffixes = {
    "en": {
      "one": "st",
      "two": "nd",
      "few": "rd",
      "other": "th",
    }
    // Add more languages and suffixes as needed
  };
}
