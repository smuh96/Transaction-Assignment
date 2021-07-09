import 'package:assignment/theme/style.dart';
import 'package:intl/intl.dart';

class Transaction {
  final String date;
  final String amount;
  final String type;
  final String currencyCode;
  final String iban;
  final String description;
  final String bic;
  final String id;

  Transaction(
      {required this.date,
      required this.amount,
      required this.type,
      required this.currencyCode,
      required this.iban,
      required this.description,
      required this.bic,
      required this.id});

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      date: json['date'],
      amount: json['amount'],
      type: json['type'],
      currencyCode: json['currencyCode'],
      iban: json['iban'],
      description: json['description'],
      bic: json['bic'],
      id: json['id'],
    );
  }

  DateTime getDateTime(){
    return DateFormat("yyyy-MM-dd'T'HH:mm:ssZ").parse(date);
  }

  String getFormattedDate(){
    return DateFormat("dd-MMM-yyy").format(getDateTime());
  }

  String getCustomDate(String format){
    return DateFormat(format).format(getDateTime());
  }

  getImage() {
    if (type.toLowerCase() == "deposit") {
      return "assets/up.png";
    } else {
      return "assets/down.png";
    }
  }

  getAmountTextStyle() {
    if (type.toLowerCase() == "deposit") {
      return Style.greenHeadingStyle;
    } else {
      return Style.redHeadingStyle;
    }
  }

  contain(String query){
    bool isContain = false;
    if(amount.toLowerCase().contains(query)){
      isContain = true;
    }

    if(type.toLowerCase().contains(query)){
      isContain = true;
    }

    if(getFormattedDate().toLowerCase().contains(query)){
      isContain = true;
    }

    if(currencyCode.toLowerCase().contains(query)){
      isContain = true;
    }

    return isContain;
  }
}
