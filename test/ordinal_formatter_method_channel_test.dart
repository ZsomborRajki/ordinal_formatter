import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ordinal_formatter/ordinal_formatter_method_channel.dart';

void main() {
  final platform = MethodChannelOrdinalFormatter();
  const channel = MethodChannel('ordinal_formatter');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (message) async => '42nd');
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('format', () async {
    expect(await platform.format(2), '42nd');
  });
}
