import 'package:flutter/material.dart';
import '../constants.dart';

class Button extends StatelessWidget {
  final double width;
  final double height;
  final onPressed;
  final String text;

  const Button(
      {Key? key,
      required this.width,
      required this.height,
      required this.onPressed,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: kMainColor,
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
