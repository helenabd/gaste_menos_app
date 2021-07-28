import 'package:flutter/material.dart';
import 'package:gaste_menos_app/ui/widgets/input_with_icon.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String errorText;
  final Function onChanged;
  final Function onEditingComplete;

  const PasswordField({
    Key key,
    @required this.controller,
    @required this.focusNode,
    @required this.errorText,
    @required this.onChanged,
    @required this.onEditingComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InputWithIcon(
            controller: controller,
            focusNode: focusNode,
            errorText: errorText,
            isPassword: true,
            icon: Icon(Icons.lock_outline),
            hintText: 'Senha',
            onChanged: onChanged,
            textInputType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            onEditingComplete: onEditingComplete,
          )
        ],
      ),
    );
  }
}
