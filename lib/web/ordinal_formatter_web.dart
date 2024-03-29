import 'package:ordinal_formatter/ordinal_formatter_platform_interface.dart';
//Conditional import to assist with testing functionality in this class
import 'package:ordinal_formatter/web/web_ordinal_rules_web.dart'
    if (dart.library.io) 'package:ordinal_formatter/web/web_ordinal_rules_io.dart';

/// A web implementation of the OrdinalFormatterPlatform of the
/// OrdinalFormatter plugin.
class OrdinalFormatterWeb extends OrdinalFormatterPlatform {
  final defaultLocale = 'en';

  static void registerWith(_) {
    OrdinalFormatterPlatform.instance = OrdinalFormatterWeb();
  }

  @override
  Future<String?> format(int number, [String? localeCode]) async {
    // https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Intl/PluralRules
    const dashSymbol = '-';
    var locale = localeCode?.replaceAll('_', dashSymbol);

    var ordinalRules = getOrdinalRules(number, locale);

    if (ordinalRules == null && (locale?.contains(dashSymbol) ?? false)) {
      locale = locale?.split('-')[0];
      ordinalRules = getOrdinalRules(number, locale);
    }

    if (ordinalRules == null) {
      locale ??= defaultLocale;
      ordinalRules = getOrdinalRules(number, locale);
    }

    final suffix = ordinalSuffixes[locale]?[ordinalRules];

    return suffix != null ? '$number$suffix' : null;
  }

  // Localized ordinal documentation can be found at-
  // https://www.unicode.org/cldr/charts/43/supplemental/language_plural_rules.html
  final Map<String, Map<String, String>> ordinalSuffixes = {
    'en': {
      'one': 'st',
      'two': 'nd',
      'few': 'rd',
      'other': 'th',
    },
    // Add more languages and suffixes as needed
  };
}
