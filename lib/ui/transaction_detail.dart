import 'package:assignment/models/transaction.dart';
import 'package:assignment/theme/style.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TransactionDetailPage extends StatelessWidget {
  late Transaction _transaction;

  TransactionDetailPage(Transaction _transaction) {
    this._transaction = _transaction;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Transaction Detail',
      theme: Style.buildLightTheme(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Transaction Detail'),
        ),
        body: Container(
          margin: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //type
              Row(
                children: [
                  Text(
                    'Transaction type',
                    style: Style.textStyle1,
                  ),
                  Expanded(
                    child: Text(
                      _transaction.type.toUpperCase(),
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.right,
                      style: Style.textStyle2,
                    ),
                  ),
                ],
              ),
              Divider(),
              //iban
              Row(
                children: [
                  Text(
                    'IBAN',
                    style: Style.textStyle1,
                  ),
                  Expanded(
                    child: Text(
                      _transaction.iban.toUpperCase(),
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.right,
                      style: Style.textStyle2,
                    ),
                  ),
                ],
              ),
              Divider(),
              //bic
              Row(
                children: [
                  Text(
                    'BIC',
                    style: Style.textStyle1,
                  ),
                  Expanded(
                    child: Text(
                      _transaction.bic.toUpperCase(),
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.right,
                      style: Style.textStyle2,
                    ),
                  ),
                ],
              ),
              Divider(),
              //datetime
              Row(
                children: [
                  Text(
                    'Date Time',
                    style: Style.textStyle1,
                  ),
                  Expanded(
                    child: Text(
                      _transaction.getCustomDate("dd MMM yyyy, hh:mm:ss a"),
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.right,
                      style: Style.textStyle2,
                    ),
                  ),
                ],
              ),
              Divider(),
              //amount
              Row(
                children: [
                  Text(
                    'Amount',
                    style: Style.textStyle1,
                  ),
                  Expanded(
                    child: Text(
                      _transaction.amount,
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.right,
                      style: Style.textStyle2,
                    ),
                  ),
                ],
              ),
              Divider(),
              //currency
              Row(
                children: [
                  Text(
                    'Currency Code',
                    style: Style.textStyle1,
                  ),
                  Expanded(
                    child: Text(
                      _transaction.currencyCode,
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.right,
                      style: Style.textStyle2,
                    ),
                  ),
                ],
              ),
              Divider(),
              //description
              Text(
                'Description',
                style: Style.textStyle1,
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                child: Text(
                  _transaction.description,
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
