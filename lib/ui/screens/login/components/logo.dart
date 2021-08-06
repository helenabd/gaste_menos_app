import 'package:flutter/material.dart';

import '../../../ui.dart';

class Logo extends StatelessWidget {
  const Logo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      child: Image.asset(
        Images.kLogo,
      ),
    );
  }
}
