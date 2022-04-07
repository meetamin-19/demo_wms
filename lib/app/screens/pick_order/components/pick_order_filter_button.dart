import 'package:flutter/material.dart';
import 'package:demo_win_wms/app/utils/constants.dart';

class PickOrderFilterButton extends StatelessWidget {
  const PickOrderFilterButton({Key? key,required this.text, this.onTap}) : super(key: key);

  final String text;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          if(onTap != null){
            onTap!();
          }
        },
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Text(
              text,
              style: TextStyle(color: Colors.black, fontSize: 15,fontWeight: FontWeight.w500),
            )));
  }
}
