import 'package:fcl/utils/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:fcl/utils/app_sizes.dart';

class TxtField extends StatefulWidget {
  final bool ishidden;
  final bool isboxborder;
  final bool isenabled;
  final String titletxt;
  final String trailingtitletxt;
  final GestureTapCallback trailingtitletxtFn;
  final bool istitletxt;
  final String hinttxt;
  final String initialvalue;
  final int maxlines;
  final bool isTxtAlignCenter;
  final bool isconatinerheight;
  final String validationerrortxt;
  final TextInputType keyboardtype;
  final void Function(String) onsaved;
  final void Function(String) onOnChange;
  final String Function(String) validator;
  final TextEditingController controller;
  TxtField({
    this.titletxt,
    @required this.hinttxt,
    @required this.validationerrortxt,
    @required this.keyboardtype,
    this.onsaved,
    @required this.validator,
    this.istitletxt = true,
    this.ishidden = false,
    this.controller,
    this.isTxtAlignCenter = false,
    this.trailingtitletxt = "",
    this.trailingtitletxtFn,
    this.maxlines = 1,
    this.initialvalue,
    this.onOnChange,
    this.isboxborder = false,
    this.isenabled = true,
    this.isconatinerheight = false,
  });

  @override
  _TxtFieldState createState() => _TxtFieldState();
}

class _TxtFieldState extends State<TxtField> {
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  FocusNode _focusNode = FocusNode();
  Color _bacgroundColor = kColorContainer;
  Color _labelColor = Colors.transparent;
  Color _hintColor = Colors.black;

  Color _txtColor;
  @override
  Widget build(BuildContext context) {
    _focusNode.addListener(() {
      setState(() {
        _bacgroundColor =
            _focusNode.hasFocus ? Colors.transparent : kColorContainer;
        _txtColor = _focusNode.hasFocus ? Colors.white : Colors.black;
        _labelColor = _focusNode.hasFocus ? kColorAccent : Colors.transparent;
        _hintColor = _focusNode.hasFocus ? Colors.transparent : Colors.black;
      });
    });
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AppSizes.blockSizeHorizontal * 2.0,
          vertical: AppSizes.blockSizeHorizontal * 2.0),
      child: Theme(
        data: new ThemeData(
          primaryColor: kColorAccent,
        ),
        child: TextFormField(
          controller: widget.controller,
          style: TextStyle(color: _txtColor),
          focusNode: _focusNode,
          textAlign:
              widget.isTxtAlignCenter ? TextAlign.center : TextAlign.start,
          initialValue: widget.initialvalue,
          enabled: widget.isenabled,
          maxLines: widget.maxlines,
          keyboardType: widget.keyboardtype,
          obscureText: widget.ishidden,
          autofocus: false,
          onChanged: widget.onOnChange,
          validator: widget.validator,
          onSaved: widget.onsaved,
          cursorColor: kColorAccent,
          decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              contentPadding: EdgeInsets.symmetric(
                  vertical: AppSizes.blockSizeVertical * 2.5,
                  horizontal: AppSizes.blockSizeHorizontal * 10.5),
              labelText: widget.hinttxt,
              alignLabelWithHint: true,
              labelStyle: TextStyle(color: _labelColor),
              hintText: widget.hinttxt,
              hintStyle: TextStyle(color: _hintColor),
              fillColor: _bacgroundColor,
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: kColorAccent,
                ),
                borderRadius:
                    BorderRadius.circular(AppSizes.blockSizeHorizontal * 7.0),
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: kColorAccent,
                    width: 0,
                    style: BorderStyle.none,
                  ),
                  gapPadding: 10.0,
                  borderRadius: BorderRadius.circular(
                      AppSizes.blockSizeHorizontal * 7.0))),
        ),
      ),
    );
  }
}
