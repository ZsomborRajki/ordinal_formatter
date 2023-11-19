
import 'package:flutter_test/flutter_test.dart';
import 'package:ordinal_formatter/web/ordinal_formatter_web.dart';

void main() {
  test('format', () async {
    final result = await OrdinalFormatterWeb().format(2);
    expect(result, '2th');
  });
}
