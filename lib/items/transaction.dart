import 'package:japa/utils/util.dart';
import "dart:convert" show json;

enum TransactionType{ Deposite, Transfer, Recieved, Withdrawal }
TransactionType __transactionTypeParser(String data){
    switch(data){
        case "deposite":
            return TransactionType.Deposite;
            case "transfer":
                return TransactionType.Transfer;
        case "recieved":
            return TransactionType.Recieved;
        default:
            return TransactionType.Withdrawal;
    }
}

class Transaction{
    TransactionType transactionType;
    int amount;
    DateTime date;

    Transaction({required this.transactionType, required this.amount, required this.date});
    Transaction.from(Map<String, dynamic> data):
            this(amount: JsonHelper.getInt(data["amount"]), date: JsonHelper.getDateTime(data["date"]), transactionType:  __transactionTypeParser(JsonHelper.getString(data["type"])));
    Transaction.parse(String data): this.from(json.decode(data));
}