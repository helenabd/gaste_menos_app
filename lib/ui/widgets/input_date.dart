import 'package:flutter/material.dart';

class InputDate extends StatelessWidget {
  const InputDate({
    Key key,
    this.valueText,
    this.valueStyle,
    this.onPressed,
  }) : super(key: key);

  final String valueText;
  final TextStyle valueStyle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Center(child: Text(valueText, style: valueStyle)),
    );
  }
}
