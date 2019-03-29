import 'package:flutter_test/flutter_test.dart';
import 'package:F4Lab/util/date_util.dart';

void main() {
  group("Date util", () {
    test("string2Datetime", () {
      final strDate = "2019-03-28T13:46:44.208";
      final date = string2Datetime(strDate);
      expect(date, DateTime(2019, 03, 28, 13, 46, 44, 208));
    });

    test("datetime2String", () {
      final dateTime = DateTime(2019, 03, 28, 13, 46, 44);
      final strDate = "2019/3/28 13:46:44";
      expect(datetime2String(dateTime), strDate);
    });
  });
}
