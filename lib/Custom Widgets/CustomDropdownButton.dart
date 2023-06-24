import 'package:ahed/Shared%20Data/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDropdownButton extends StatelessWidget {
  final String text;
  // final double iconSize;
  final String? selectedValue;
  final void Function(String?) onChanged;
  final List<DropdownMenuItem<String>> items;
  static late AppTheme appTheme;

  const CustomDropdownButton(
      {super.key, required this.text,
      // required this.iconSize,
      required this.selectedValue,
      required this.onChanged,
      required this.items});
  @override
  Widget build(BuildContext context) {
    appTheme = Provider.of<AppTheme>(context);
    return DropdownButtonHideUnderline(
      child: ButtonTheme(
        alignedDropdown: true,
        buttonColor: Colors.black,
        child: DropdownButton(
            hint: Text(text,
              style: appTheme.themeData.primaryTextTheme.headlineSmall,),
            isExpanded: true,
            icon: const Flexible(
                child: Icon(Icons.arrow_drop_down,
                    color: Color.fromRGBO(127, 127, 127, 1.0))),
            style: appTheme.themeData.primaryTextTheme.headlineSmall,
            // iconSize: iconSize,
            value: selectedValue,
            onChanged: onChanged,
            items: items),
      ),
    );
  }
}
