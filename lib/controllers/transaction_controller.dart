import 'dart:convert';

import 'package:assignment/models/transaction.dart';
import 'package:http/http.dart' as http;

class TransactionController {

  Future<List<Transaction>> getTransactions() async {
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
      // return jsonResponse.map<Transaction>((data) => new Transaction.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occurred!');
    }
  }


  Future<List<Transaction>> fetchTransactions(http.Client client) async {
    var response = await client.get(Uri.https(
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
  }

  List<Transaction> filterByDates(
      List<Transaction> list, DateTime start, DateTime end) {
    List<Transaction> _list = [];
    list.forEach((element) => {
          if (element.getDateTime().isAfter(start) &&
              element.getDateTime().isBefore(end))
            {_list.add(element)}
        });
    return _list;
  }

  List<Transaction> filterByQuery(List<Transaction> list, String query) {
    List<Transaction> _list = [];
    list.forEach((element) => {
          if (element.contain(query.toLowerCase())) {_list.add(element)}
        });
    return _list;
  }
}
