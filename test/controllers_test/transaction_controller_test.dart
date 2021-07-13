import 'package:assignment/controllers/transaction_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:assignment/models/transaction.dart';

import 'transaction_controller_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('Fetch transactions', () {
    test('returns transactions if the http call completes successfully',
        () async {
      final client = MockClient();

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.get(Uri.parse(
              'https://60e29b749103bd0017b4743f.mockapi.io/api/v1/transactions')))
          .thenAnswer((_) async => http.Response(
              '[{"date":"2021-07-05T00:34:29.993Z", "amount":"209.78", "type":"withdrawal", "currencyCode":"XBD", "iban":"IE53624A00844716683079", "description":"payment transaction at Hilpert, Emard and Denesik using card ending with ***9524 for JPY 324.08 in account ***83781284", "bic":"JBFEMWP1745", "id":"1"}]',
              200));

      expect(await new TransactionController().fetchTransactions(client),
          isA<List<Transaction>>());
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();

      // Use Mockito to return an unsuccessful response when it calls the
      // provided http.Client.
      when(client.get(Uri.parse(
              'https://60e29b749103bd0017b4743f.mockapi.io/api/v1/transactions')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(new TransactionController().fetchTransactions(client),
          throwsException);
    });

    test('returns transactions list if any object contains in list',
            () async {
          final client = MockClient();

          // Use Mockito to return a successful response when it calls the
          // provided http.Client.
          when(client.get(Uri.parse(
              'https://60e29b749103bd0017b4743f.mockapi.io/api/v1/transactions')))
              .thenAnswer((_) async => http.Response(
              '[{"date":"2021-07-05T00:34:29.993Z", "amount":"209.78", "type":"withdrawal", "currencyCode":"XBD", "iban":"IE53624A00844716683079", "description":"payment transaction at Hilpert, Emard and Denesik using card ending with ***9524 for JPY 324.08 in account ***83781284", "bic":"JBFEMWP1745", "id":"1"}]',
              200));

          List<Transaction> list = await new TransactionController().fetchTransactions(client);

          List<Transaction> result = new TransactionController().filterByQuery(list, "withdrawal");

          expect(result, list);
        });

    test('returns list length 0 if any object not contains in list',
            () async {
          final client = MockClient();

          // Use Mockito to return a successful response when it calls the
          // provided http.Client.
          when(client.get(Uri.parse(
              'https://60e29b749103bd0017b4743f.mockapi.io/api/v1/transactions')))
              .thenAnswer((_) async => http.Response(
              '[{"date":"2021-07-05T00:34:29.993Z", "amount":"209.78", "type":"withdrawal", "currencyCode":"XBD", "iban":"IE53624A00844716683079", "description":"payment transaction at Hilpert, Emard and Denesik using card ending with ***9524 for JPY 324.08 in account ***83781284", "bic":"JBFEMWP1745", "id":"1"}]',
              200));

          List<Transaction> list = await new TransactionController().fetchTransactions(client);

          List<Transaction> result = new TransactionController().filterByQuery(list, "deposit");

          expect(result.length, 0);
        });

    test('returns list if any transaction date is between 2 dates',
            () async {
          final client = MockClient();

          // Use Mockito to return a successful response when it calls the
          // provided http.Client.
          when(client.get(Uri.parse(
              'https://60e29b749103bd0017b4743f.mockapi.io/api/v1/transactions')))
              .thenAnswer((_) async => http.Response(
              '[{"date":"2021-07-05T00:34:29.993Z", "amount":"209.78", "type":"withdrawal", "currencyCode":"XBD", "iban":"IE53624A00844716683079", "description":"payment transaction at Hilpert, Emard and Denesik using card ending with ***9524 for JPY 324.08 in account ***83781284", "bic":"JBFEMWP1745", "id":"1"}]',
              200));

          List<Transaction> list = await new TransactionController().fetchTransactions(client);

          List<Transaction> result = new TransactionController().filterByDates(list, DateTime.parse("2021-07-04T00:34:29.993Z"), DateTime.parse("2021-07-06T00:34:29.993Z"));

          expect(result, list);
        });

    test('returns list length 0 if any transaction date is not between 2 dates',
            () async {
          final client = MockClient();

          // Use Mockito to return a successful response when it calls the
          // provided http.Client.
          when(client.get(Uri.parse(
              'https://60e29b749103bd0017b4743f.mockapi.io/api/v1/transactions')))
              .thenAnswer((_) async => http.Response(
              '[{"date":"2021-07-05T00:34:29.993Z", "amount":"209.78", "type":"withdrawal", "currencyCode":"XBD", "iban":"IE53624A00844716683079", "description":"payment transaction at Hilpert, Emard and Denesik using card ending with ***9524 for JPY 324.08 in account ***83781284", "bic":"JBFEMWP1745", "id":"1"}]',
              200));

          List<Transaction> list = await new TransactionController().fetchTransactions(client);

          List<Transaction> result = new TransactionController().filterByDates(list, DateTime.parse("2021-07-06T00:34:29.993Z"), DateTime.parse("2021-07-07T00:34:29.993Z"));

          expect(result.length, 0);
        });

  });
}