import 'package:fcl/utils/app_colors.dart';
import 'package:fcl/utils/app_sizes.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RoundedBorderDropdown extends StatefulWidget {
  final List<DropdownMenuItem<String>> listItems;
  final Function(String) onchange;
  String dropdownvalue;
  RoundedBorderDropdown({
    @required this.listItems,
    @required this.onchange,
    @required this.dropdownvalue,
  });
  @override
  _RoundedBorderDropdownState createState() => _RoundedBorderDropdownState();
}

class _RoundedBorderDropdownState extends State<RoundedBorderDropdown> {
  String dropdownValue;

  String selectedItem;
  // void initstate() {
  //   widget.dropdownvalue = widget.listItems.first;
  // }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: AppSizes.blockSizeVertical * 7.0,
        width: AppSizes.screenWidth,
        decoration: BoxDecoration(
          color: kColorContainer,
          borderRadius:
              BorderRadius.circular(AppSizes.blockSizeHorizontal * 10.0),
          border: Border.all(
              color: Colors.transparent, style: BorderStyle.solid, width: 0.80),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppSizes.blockSizeHorizontal * 5.0),
          child: Center(
            child: DropdownButton<String>(
                hint: Text("Select Title"),
                isDense: true,
                isExpanded: true,
                value: widget.dropdownvalue,
                icon: Icon(
                  Icons.arrow_drop_down,
                ),
                iconSize: AppSizes.blockSizeHorizontal * 07,
                autofocus: false,
                style: TextStyle(color: Colors.black),
                onChanged: widget.onchange,
                items: widget.listItems),
          ),
        ),
      ),
    );
  }
}
