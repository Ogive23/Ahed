import 'package:ahed/Models/Needy.dart';
import 'package:flutter/material.dart';

class NeedyData extends ChangeNotifier {
  Needy? selectedNeedy;

  chooseNeedy(Needy selectedNeedy) {
    this.selectedNeedy = selectedNeedy;
    notifyListeners();
  }


  deleteSelectedNeedy() {
    selectedNeedy = null;
    notifyListeners();
  }
}
