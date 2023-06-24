import 'package:ahed/Models/Needy.dart';

import 'Transaction.dart';

class OfflineTransaction extends Transaction {
  String preferredSection;
  String address;
  String phoneNumber;
  DateTime startCollectDate;
  DateTime endCollectDate;
  DateTime? selectedDate;
  bool collected;

  OfflineTransaction(
      String id,
      String giver,
      Needy needy,
      double amount,
      DateTime createdAt,
      String type,
      this.preferredSection,
      this.address,
      this.phoneNumber,
      this.startCollectDate,
      this.endCollectDate,
      this.selectedDate,
      this.collected)
      : super(id, giver, needy, amount, createdAt, type);
}
