import 'package:flutter/material.dart';
import 'package:demo_win_wms/app/utils/constants.dart';

class PickOrderKeyValue extends StatelessWidget {
  const PickOrderKeyValue({Key? key,required this.width,this.title,this.value}) : super(key: key);

  final double width;
  final String? title;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? '',
          style: TextStyle(
              fontSize: kFlexibleSize(16), fontWeight: FontWeight.w500),
        ),
        kFlexibleSizedBox(height: 5),
        Container(
          width: width,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(color: Colors.black.withOpacity(0.25))),
          child: Text(value ?? ''),
        ),
      ],
    );
  }
}
