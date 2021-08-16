import 'package:ahed/Models/OfflineTransaction.dart';
import 'package:flutter/material.dart';

class TransactionData extends ChangeNotifier {
  OfflineTransaction? selectedTransaction;

  chooseTransaction(OfflineTransaction selectedTransaction) {
    this.selectedTransaction = selectedTransaction;
    notifyListeners();
  }


  deleteSelectedNeedy() {
    this.selectedTransaction = null;
    notifyListeners();
  }
}
