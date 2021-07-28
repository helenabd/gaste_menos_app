import 'package:flutter/material.dart';

import '../ui.dart';

class InputWithIcon extends StatefulWidget {
  const InputWithIcon({
    Key key,
    @required this.hintText,
    @required this.textInputType,
    @required this.onChanged,
    @required this.icon,
    @required this.controller,
    @required this.focusNode,
    @required this.errorText,
    @required this.onEditingComplete,
    this.textInputAction = TextInputAction.next,
    this.isPassword = false,
  }) : super(key: key);

  final String hintText;
  final TextInputType textInputType;
  final Function onChanged;
  final Icon icon;
  final bool isPassword;
  final TextEditingController controller;
  final FocusNode focusNode;
  final String errorText;
  final TextInputAction textInputAction;
  final Function onEditingComplete;

  @override
  _InputWithIconState createState() => _InputWithIconState();
}

class _InputWithIconState extends State<InputWithIcon> {
  bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    IconButton suffix;
    if (widget.isPassword) {
      suffix = IconButton(
        icon: _passwordVisible
            ? Icon(Icons.visibility)
            : Icon(Icons.visibility_off),
        color: !_passwordVisible ? kColorDarkGrey : kColorDarkPurple,
        onPressed: () {
          setState(() {
            _passwordVisible = !_passwordVisible;
          });
        },
      );
    }
    return Container(
      child: TextFormField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        cursorColor: kColorPurple,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          hintText: widget.hintText,
          errorText: widget.errorText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kColorGrey, width: 2.0),
          ),
          prefixIcon: IconButton(
            icon: widget.icon,
            onPressed: () {},
          ),
          suffixIcon: suffix,
        ),
        autocorrect: false,
        keyboardType: widget.textInputType,
        textInputAction: widget.textInputAction,
        onChanged: widget.onChanged,
        obscureText: widget.isPassword ? !_passwordVisible : _passwordVisible,
        obscuringCharacter: "*",
        onEditingComplete: widget.onEditingComplete,
      ),
    );
  }
}
