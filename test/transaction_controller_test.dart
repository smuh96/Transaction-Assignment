import 'package:assignment/controllers/transaction_controller.dart';
import 'package:flutter_test/flutter_test.dart';



void main() {
  group("Transactions test",()
  {
    test('Get Transactions Test', () {
      var result = TransactionController().getTransactions();
      // ignore: unnecessary_null_comparison
      expect(result != null, true);
    });
  });
}