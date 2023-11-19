// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
// ignore_for_file: avoid_dynamic_calls

import 'dart:js' as js;

String? getOrdinalRules(int number, String? localeCode) {
  if (localeCode == null) {
    return null;
  }
  final ordinalFormatter = js.JsObject(
    js.context['Intl']['PluralRules'],
    [
      localeCode,
      js.JsObject.jsify({'type': 'ordinal'}),
    ],
  );

  final ordinalRules = ordinalFormatter.callMethod('select', [number]);

  return ordinalRules;
}
