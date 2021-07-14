import 'dart:convert';
import 'package:get/state_manager.dart';

import 'package:assignment/models/transaction.dart';
import 'package:http/http.dart' as http;

class TransactionController extends GetxController {
  var isLoading = true.obs;
  var transactionsList = <Transaction>[].obs;

  @override
  void onInit() async {
    transactionsList.value = await getTransactions();
    super.onInit();
  }

  Future<List<Transaction>> getTransactions() async {
    try {
      isLoading(true);
      var response = await http.get(Uri.https(
          '60e29b749103bd0017b4743f.mockapi.io', 'api/v1/transactions'));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        List<Transaction> list = jsonResponse
            .map<Transaction>((data) => new Transaction.fromJson(data))
            .toList();
        // sorting according to date
        list.sort((o1, o2) => o1.getDateTime().compareTo(o2.getDateTime()));
        return list;
      } else {
        throw Exception('Unexpected error occurred!');
      }
    } finally {
      isLoading(false);
    }
  }
}
