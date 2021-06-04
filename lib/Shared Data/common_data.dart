import 'package:flutter/material.dart';

class CommonData extends ChangeNotifier {
  int step = 0;
  List<int> previousSteps = [0];
  bool scaled = false;
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  changeStep(int step) {
    this.step = step;
    this.previousSteps.add(step);
    print(previousSteps);
    notifyListeners();
  }

  back() {
    previousSteps.removeLast();
    this.step = previousSteps.last;
    print('removed $previousSteps');
    notifyListeners();
  }

  lastStep() {
    return previousSteps.length == 1;
  }

  // changeScaleCondition(context) {
  //   scaled = !scaled;
  //   if (scaled) {
  //     this.xOffset = MediaQuery.of(context).size.width / 2;
  //     this.yOffset = MediaQuery.of(context).size.height / 5;
  //     this.scaleFactor = 0.6;
  //   } else {
  //     xOffset = 0;
  //     yOffset = 0;
  //     scaleFactor = 1;
  //   }
  //   print(scaled);
  //   notifyListeners();
  // }

  goHome() {
      this.previousSteps = [0];
      this.step = previousSteps.last;
      notifyListeners();
  }
}
