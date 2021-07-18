import 'package:flutter/material.dart';
import 'package:gaste_menos_app/ui/widgets/input_with_icon.dart';

class UsernameField extends StatelessWidget {
  const UsernameField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InputWithIcon(
            icon: Icon(Icons.person_outline),
            hintText: 'Usuário',
            onChanged: (username) => print(username),
            textInputType: TextInputType.emailAddress,
          )
        ],
      ),
    );
  }
}
