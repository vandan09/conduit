import 'package:first_app/constants/Constantcolors.dart';
import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  ConstantColors constantColors = ConstantColors();

  final String? buttonText;

  CustomRaisedButton({@required this.buttonText});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
      decoration: BoxDecoration(
        color: constantColors.greenColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        buttonText!,
        style: TextStyle(color: Colors.white, fontSize: 17
            // fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
