import 'package:flutter_test/flutter_test.dart';
import 'package:ordinal_formatter/ordinal_formatter.dart';
import 'package:ordinal_formatter/ordinal_formatter_method_channel.dart';
import 'package:ordinal_formatter/ordinal_formatter_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockOrdinalFormatterPlatform
    with MockPlatformInterfaceMixin
    implements OrdinalFormatterPlatform {
  @override
  Future<String?> format(int number, [String? localeCode]) async {
    return '42nd';
  }
}

void main() {
  final OrdinalFormatterPlatform initialPlatform =
      OrdinalFormatterPlatform.instance;

  test('$MethodChannelOrdinalFormatter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelOrdinalFormatter>());
  });

  test('format', () async {
    OrdinalFormatter ordinalFormatterPlugin = OrdinalFormatter();
    MockOrdinalFormatterPlatform fakePlatform = MockOrdinalFormatterPlatform();
    OrdinalFormatterPlatform.instance = fakePlatform;

    expect(await ordinalFormatterPlugin.format(2), '42nd');
  });
}
