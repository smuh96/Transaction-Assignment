import 'package:assignment/controllers/transaction_controller.dart';
import 'package:assignment/models/transaction.dart';
import 'package:assignment/ui/transaction_detail.dart';
import 'package:assignment/theme/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'calendar_popup_view.dart';

class TransactionsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TransactionsHistory();
}

class TransactionsHistory extends State<TransactionsPage> {
  late Future<List<Transaction>> transactions;
  late List<Transaction> _transactions = [];
  late List<Transaction> finalTransactions = [];

  late Icon appBarIcon;
  late Widget appBarWidget;

  DateTime startDate = DateTime.now().subtract(const Duration(days: 7));
  DateTime endDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    transactions = new TransactionController().getTransactions();
    transactions.then((value) {
      value.forEach(
          (item) => {finalTransactions.add(item), _transactions.add(item)});
    });

    appBarIcon = Icon(Icons.search);
    appBarWidget = Text('Transactions');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Transactions',
      theme: Style.buildLightTheme(),
      home: Scaffold(
          appBar: getAppBar(),
          body: Builder(
            builder: (BuildContext context) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  getFilterBarUI(),
                  Expanded(
                    child: Center(
                      child: FutureBuilder(
                        future: transactions,
                        builder: (context,
                            AsyncSnapshot<List<Transaction>> snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                              return Text('Check Your Internet Connection');
                            case ConnectionState.done:
                              if (snapshot.hasError || !snapshot.hasData) {
                                return Text(
                                  'No Transactions',
                                  style: Style.textStyle1,
                                );
                              } else {
                                return getList();
                              }
                            // case ConnectionState.active:
                            // case ConnectionState.waiting:
                            default:
                              return CircularProgressIndicator(
                                color: Style.pPrimaryColor,
                              );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          )),
    );
  }

  AppBar getAppBar() {
    return AppBar(
      title: appBarWidget,
      actions: [
        IconButton(
          icon: appBarIcon,
          onPressed: () {
            setState(() {
              if (appBarIcon.icon == Icons.search) {
                appBarIcon = Icon(Icons.close);
                appBarWidget = TextField(
                    onChanged: (value) {
                      setState(() {
                        _transactions = new TransactionController()
                            .filterByQuery(finalTransactions, value);
                      });
                    },
                    style: Style.captionWhite,
                    cursorColor: Style.pWhiteColor,
                    decoration: InputDecoration(
                        fillColor: Style.pSecondaryColor.withOpacity(0.1),
                        filled: true,
                        hintText: 'Search Transaction',
                        hintStyle: Style.captionWhite,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide.none),
                        contentPadding: EdgeInsets.only(left: 15, right: 15)));
              } else {
                setState(() {
                  _transactions = finalTransactions;
                });
                appBarIcon = Icon(Icons.search);
                appBarWidget = Text('Transactions');
              }
            });
          },
        )
      ],
    );
  }

  Widget getList() {
    return ListView.builder(
      itemCount: _transactions.length,
      itemBuilder: (context, index) {
        return getListItem(index);
      },
    );
  }

  Widget getListItem(int index) {
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
                  child: Image.asset(_transactions[index].getImage()),
                ),
                Positioned(
                  left: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_transactions[index].getFormattedDate(),
                          style: Style.textStyle1),
                      Text(_transactions[index].type.toUpperCase(),
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
                        _transactions[index].amount,
                        style: _transactions[index].getAmountTextStyle(),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5, right: 5),
                        child: Text(_transactions[index].currencyCode,
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
              _transactions[index],
            ),
          ),
        );
      },
    );
  }

  Widget getFilterBarUI() {
    return Stack(
      children: <Widget>[
        Container(
          color: Style.pWhiteColor,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 4),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${_transactions.length} Transactions',
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());

                      showCalenderDialog(context: context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Filter',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.sort, color: Style.pPrimaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Divider(
            height: 1,
          ),
        )
      ],
    );
  }

  void showCalenderDialog({BuildContext? context}) {
    showDialog<dynamic>(
      context: context!,
      builder: (BuildContext context) => CalendarPopupView(
        barrierDismissible: false,
        minimumDate: DateTime.now().subtract(const Duration(days: 365)),
        //  maximumDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 10),
        initialEndDate: endDate,
        initialStartDate: startDate,
        onApplyClick: (DateTime startData, DateTime endData) {
          setState(() {
            startDate = startData;
            endDate = endData;
            _transactions = new TransactionController()
                .filterByDates(finalTransactions, startData, endData);
          });
        },
        onCancelClick: () {
          setState(() {
            _transactions = finalTransactions;
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
