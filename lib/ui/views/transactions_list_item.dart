import 'package:assignment/models/transaction.dart';
import 'package:assignment/theme/style.dart';
import 'package:assignment/ui/pages/transaction_detail.dart';
import 'package:flutter/material.dart';

class TransactionsListItem extends StatelessWidget {
  final Transaction transaction;

  TransactionsListItem(this.transaction);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(left: 8, top: 4, right: 8),
        child: Card(
          elevation: 3,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Stack(
              alignment: AlignmentDirectional.centerStart,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  child: Image.asset(transaction.getImage()),
                ),
                Positioned(
                  left: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(transaction.getFormattedDate(),
                          style: Style.textStyle1),
                      Text(transaction.type.toUpperCase(),
                          style: Style.headingStyle1),
                    ],
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        transaction.amount,
                        style: transaction.getAmountTextStyle(),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5, right: 5),
                        child: Text(transaction.currencyCode,
                            style: Style.textStyle1),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        Navigator.push(
          context,
          new MaterialPageRoute(
            builder: (context) => TransactionDetailPage(
              transaction,
            ),
          ),
        );
      },
    );
  }
}
