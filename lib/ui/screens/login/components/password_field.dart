import 'package:flutter/material.dart';
import 'package:gaste_menos_app/ui/widgets/input_with_icon.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InputWithIcon(
            isPassword: true,
            icon: Icon(Icons.lock_outline),
            hintText: 'Senha',
            onChanged: (username) => print(username),
            textInputType: TextInputType.visiblePassword,
          )
        ],
      ),
    );
  }
}
