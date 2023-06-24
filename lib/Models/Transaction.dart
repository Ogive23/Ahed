import 'package:ahed/Models/Needy.dart';

class Transaction{
  String id;
  String giver;
  Needy needy;
  double amount;
  DateTime createdAt;
  String type;
  Transaction(this.id,this.giver,this.needy,this.amount,this.createdAt,this.type);
}