import 'package:assignment/controllers/getX/transaction_controller.dart';
import 'package:assignment/theme/style.dart';
import 'package:assignment/ui/views/transactions_list_item.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:flutter/material.dart';

class TransactionsPage extends StatelessWidget {
  final TransactionController transactionController =
      Get.put(TransactionController());

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
        body: Obx(() {
          if (transactionController.isLoading.value)
            return Center(child: CircularProgressIndicator());
          else
            return ListView.builder(
              itemCount: transactionController.transactionsList.length,
              itemBuilder: (context, index) {
                return TransactionsListItem(
                    transactionController.transactionsList[index]);
              },
            );
        }),
      ),
    );
  }
}
