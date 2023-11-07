// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'ordinal_formatter_platform_interface.dart';

/// A web implementation of the OrdinalFormatterPlatform of the OrdinalFormatter plugin.
class OrdinalFormatterWeb extends OrdinalFormatterPlatform {
  final js.JsObject _ordinalFormatter;

  /// Constructs a OrdinalFormatterWeb
  OrdinalFormatterWeb(String locale)
      : _ordinalFormatter = js.JsObject(js.context['Intl']['PluralRules'], [
          locale,
          {'type': 'ordinal'}
        ]);

  static void registerWith(Registrar registrar) {
    OrdinalFormatterPlatform.instance = OrdinalFormatterWeb('en');
  }

  @override
  Future<String?> format(int number, [String? localeCode]) async {
    return _ordinalFormatter.callMethod('select', [number]);
  }
}
