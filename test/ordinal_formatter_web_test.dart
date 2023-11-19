
import 'package:flutter_test/flutter_test.dart';
import 'package:ordinal_formatter/ordinal_formatter_web.dart';

void main() {

  late OrdinalFormatterWeb ordinalFormatterWeb;

  setUp(() => ordinalFormatterWeb = OrdinalFormatterWeb());
  test('format', () async {
    final result = await ordinalFormatterWeb.format(2);
    expect(result, '2th');
  });

  test('format with dash "-"', () async {
    final result = await ordinalFormatterWeb.format(5, 'en-US');
    expect(result, '5th');
  });

  test('format with underscore "_"', () async {
    final result = await ordinalFormatterWeb.format(8, 'en_US');
    expect(result, '8th');
  });

  test('format with unsupported locale', () async {
    final result = await ordinalFormatterWeb.format(155, 'cardin');
    expect(result, '155th');
  });
}
