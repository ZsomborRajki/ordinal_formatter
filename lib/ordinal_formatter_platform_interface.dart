import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'ordinal_formatter_method_channel.dart';

abstract class OrdinalFormatterPlatform extends PlatformInterface {
  /// Constructs a OrdinalFormatterPlatform.
  OrdinalFormatterPlatform() : super(token: _token);

  static final Object _token = Object();

  static OrdinalFormatterPlatform _instance = MethodChannelOrdinalFormatter();

  /// The default instance of [OrdinalFormatterPlatform] to use.
  ///
  /// Defaults to [MethodChannelOrdinalFormatter].
  static OrdinalFormatterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [OrdinalFormatterPlatform] when
  /// they register themselves.
  static set instance(OrdinalFormatterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> format(int number, [String? localeCode]) {
    throw UnimplementedError('format() has not been implemented.');
  }
}
