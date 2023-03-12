import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'ordinal_formatter_platform_interface.dart';

/// An implementation of [OrdinalFormatterPlatform] that uses method channels.
class MethodChannelOrdinalFormatter extends OrdinalFormatterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('ordinal_formatter');

  @override
  Future<String?> format(int number, [String? localeCode]) async {
    final formattedNumber =
        await methodChannel.invokeMethod<String>('format', <String, dynamic>{
      'number': number,
      'locale_code': localeCode,
    });
    return formattedNumber;
  }
}
