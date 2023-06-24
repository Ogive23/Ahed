import 'package:ahed/Models/Needy.dart';

import 'Transaction.dart';

class OnlineTransaction extends Transaction {
  double remaining;
  OnlineTransaction(String id, String giver, Needy needy, double amount,
      DateTime createdAt, String type, this.remaining)
      : super(id, giver, needy, amount, createdAt, type);
}
