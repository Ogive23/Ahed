import 'Transaction.dart';

class OnlineTransaction extends Transaction {
  double remaining;
  OnlineTransaction(String id, String giver, String needy, double amount,
      DateTime createdAt, String type, this.remaining)
      : super(id, giver, needy, amount, createdAt, type);
}
