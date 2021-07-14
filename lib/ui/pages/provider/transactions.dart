import 'package:assignment/controllers/provider/transaction_controller.dart';
import 'package:assignment/theme/style.dart';
import 'package:assignment/ui/views/transactions_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Transactions',
      theme: Style.buildLightTheme(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Transactions'),
        ),
        body: ChangeNotifierProvider(
          create: (context) => TransactionController(),
          child: Builder(builder: (context) {
            final transactionController =
                Provider.of<TransactionController>(context);

            if (transactionController.state == DataState.Loading) {
              return Center(child: CircularProgressIndicator());
            }
            if (transactionController.state == DataState.Error) {
              return Center(
                  child: Text('Error: ${transactionController.message}'));
            }

            return ListView.builder(
              itemCount: transactionController.transactionsList.length,
              itemBuilder: (context, index) {
                return TransactionsListItem(
                    transactionController.transactionsList[index]);
              },
            );
          }),
        ),
      ),
    );
  }
}
