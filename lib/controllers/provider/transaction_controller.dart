import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:assignment/models/transaction.dart';
import 'package:http/http.dart' as http;

enum DataState {
  Initial,
  Loading,
  Loaded,
  Error,
}

class TransactionController extends ChangeNotifier {
  DataState _state = DataState.Initial;
  List<Transaction> transactionsList = [];
  String message = '';

  TransactionController() {
    getTransactions();
  }

  DataState get state => _state;

  Future<void> getTransactions() async {
    try {
      _state = DataState.Loading;
      var response = await http.get(Uri.https(
          '60e29b749103bd0017b4743f.mockapi.io', 'api/v1/transactions'));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        List<Transaction> list = jsonResponse
            .map<Transaction>((data) => new Transaction.fromJson(data))
            .toList();
        // sorting according to date
        list.sort((o1, o2) => o1.getDateTime().compareTo(o2.getDateTime()));
        transactionsList = list;
        _state = DataState.Loaded;
      } else {
        message = 'Unexpected error occurred!';
        _state = DataState.Error;
      }
    } catch (e) {
      message = '$e';
      _state = DataState.Error;
    }

    notifyListeners();
  }
}
