import 'package:assignment/models/transaction.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Transaction Model', () {
    test(
        'Check transaction model contain withdrawal value, it should return true',
        () {
      Transaction model = new Transaction(
          date: '2021-07-05T00:34:29.993Z',
          amount: '209.78',
          type: 'withdrawal',
          currencyCode: 'XBD',
          iban: 'IE53624A00844716683079',
          description:
              'payment transaction at Hilpert, Emard and Denesik using card ending with ***9524 for JPY 324.08 in account ***83781284',
          bic: 'JBFEMWP1745',
          id: '1');

      bool result = model.contain('withdrawal');

      expect(result, true);
    });

    test(
        'Check transaction model contain currencyCode USD value, it should return false',
        () {
      Transaction model = new Transaction(
          date: '2021-07-05T00:34:29.993Z',
          amount: '209.78',
          type: 'withdrawal',
          currencyCode: 'XBD',
          iban: 'IE53624A00844716683079',
          description:
              'payment transaction at Hilpert, Emard and Denesik using card ending with ***9524 for JPY 324.08 in account ***83781284',
          bic: 'JBFEMWP1745',
          id: '1');

      bool result = model.contain('USD');

      expect(result, false);
    });
  });
}
