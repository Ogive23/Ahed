import 'package:ahed/Custom%20Widgets/CustomLoading.dart';
import 'package:flutter/material.dart';

class LoadingNeedyContainer extends StatelessWidget {
  const LoadingNeedyContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius:
            BorderRadius.circular(30),
            border: Border.all(
                color: const Color.fromRGBO(30, 111, 92,1.0),
                width: 1),
            color: const Color.fromRGBO(41, 187, 137, 1.0).withOpacity(0.1)),
        child: CustomLoading());
  }
}
