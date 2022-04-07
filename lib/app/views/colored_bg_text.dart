import 'package:flutter/material.dart';

class ColoredBGText extends StatelessWidget {
  const ColoredBGText({Key? key, required this.text, required this.color})
      : super(key: key);

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(text,style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w400,
        fontSize: 12
      ),),
      padding: EdgeInsets.symmetric(vertical: 5,horizontal: 7),
      decoration: BoxDecoration(color: color,borderRadius: BorderRadius.circular(5)),
    );
  }
}
