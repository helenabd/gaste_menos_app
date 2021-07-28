import 'package:flutter/material.dart';
import 'package:gaste_menos_app/ui/widgets/input_with_icon.dart';

class UsernameField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String errorText;
  final Function onChanged;
  final Function onEditingComplete;

  const UsernameField({
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
            icon: Icon(Icons.person_outline),
            controller: controller,
            focusNode: focusNode,
            hintText: 'teste@teste.com',
            errorText: errorText,
            textInputType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            onChanged: onChanged,
            onEditingComplete: onEditingComplete,
          )
        ],
      ),
    );
  }
}
