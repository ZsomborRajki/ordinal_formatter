import 'package:flutter_test/flutter_test.dart';
import 'package:ordinal_formatter/ordinal_formatter.dart';
import 'package:ordinal_formatter/ordinal_formatter_method_channel.dart';
import 'package:ordinal_formatter/ordinal_formatter_platform_interface.dart';

class MockOrdinalFormatterPlatform
    extends OrdinalFormatterPlatform {
  @override
  Future<String?> format(int number, [String? localeCode]) async => '42nd';
}

void main() {
  final initialPlatform = OrdinalFormatterPlatform.instance;

  test('$MethodChannelOrdinalFormatter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelOrdinalFormatter>());
  });

  test('format', () async {
    final ordinalFormatterPlugin = OrdinalFormatter();
    final fakePlatform = MockOrdinalFormatterPlatform();
    OrdinalFormatterPlatform.instance = fakePlatform;

    expect(await ordinalFormatterPlugin.format(2), '42nd');
  });
}
