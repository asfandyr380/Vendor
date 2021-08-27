import 'package:admin_panal/Config/sizeconfig.dart';
import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  final String? label;
  const Label({this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      '$label',
      style: TextStyle(
        fontSize: SizeConfig.blockSizeHorizontal * 1.25,
      ),
    );
  }
}
