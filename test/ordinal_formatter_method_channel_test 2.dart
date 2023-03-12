import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ordinal_formatter/ordinal_formatter_method_channel.dart';

void main() {
  MethodChannelOrdinalFormatter platform = MethodChannelOrdinalFormatter();
  const MethodChannel channel = MethodChannel('ordinal_formatter');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42nd';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('format', () async {
    expect(await platform.format(2), '42nd');
  });
}
