import 'package:demo_win_wms/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ReceiveDataViewComponent extends StatelessWidget {
  ReceiveDataViewComponent({Key? key, required this.title, required this.value,})
      : super(key: key);

  final String title;

  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:  EdgeInsets.only(top: kFlexibleSize(8)),
          child: Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500,color: Color(0xff454545)),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 2),
          child: Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600,color: Colors.black),
          ),
       //   padding: const EdgeInsets.all(3),
        )
      ],
    );
  }
}
