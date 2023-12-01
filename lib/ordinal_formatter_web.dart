// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore_for_file: avoid_dynamic_calls

import 'package:ordinal_formatter/ordinal_formatter_platform_interface.dart';
import 'package:ordinal_formatter/web/web_ordinal_rules_io.dart'
    if (dart.library.js) 'package:ordinal_formatter/web/web_ordinal_rules_web.dart';

/// A web implementation of the OrdinalFormatterPlatform of the
/// OrdinalFormatter plugin.
class OrdinalFormatterWeb extends OrdinalFormatterPlatform {
  final defaultLocale = 'en';

  static void registerWith(_) {
    OrdinalFormatterPlatform.instance = OrdinalFormatterWeb();
  }

  @override
  Future<String?> format(int number, [String? localeCode]) async {
    //https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Intl/PluralRules
    var locale = localeCode?.replaceAll('_', '-');
    var ordinalRules = getOrdinalRules(number, locale);
    if (ordinalRules == null && (locale?.contains('-') ?? false)) {
      locale = locale?.split('-')[0];
      ordinalRules = getOrdinalRules(number, locale);
    }
    if (ordinalRules == null) {
      locale = defaultLocale;
      ordinalRules ??= getOrdinalRules(number, locale);
    }
    final suffix = ordinalSuffixes[locale]?[ordinalRules];
    if (suffix == null) {
      return null;
    }
    return '$number$suffix';
  }

  // Localized ordinal documentation can be found at-
  // https://www.unicode.org/cldr/charts/43/supplemental/language_plural_rules.html
  final Map<String, Map<String, String>> ordinalSuffixes = {
    //English
    'en': {
      'one': 'st',
      'two': 'nd',
      'few': 'rd',
      'other': 'th',
    },
    //Afrikaans
    'af': {
      'other': 'e',
    },
    //Danish
    'da': {
      'other': '.',
    },
    //Dutch
    'nl': {
      'other': 'e',
    },
    //French
    'fr': {
      'one': 're',
      'other': 'e',
    },
    //German
    'de': {
      'other': '.',
    },
    //Spanish
    'es': {
      'other': '.ª',
    },
    //Swedish
    'sv': {
      'one': ':a',
      'other': ':e',
    },
    // Add more languages and suffixes as needed
  };
}
