import 'package:flutter/material.dart';
import 'package:demo_win_wms/app/utils/constants.dart';

class PickOrderFilterButton extends StatelessWidget {
  PickOrderFilterButton({Key? key,required this.text, this.onTap , this.bgColor}) : super(key: key);

  final String text;
  Color? bgColor = Colors.white;
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
                color: bgColor , borderRadius: BorderRadius.circular(2)),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Text(
              text,
              style: const TextStyle(color: Colors.black, fontSize: 15,fontWeight: FontWeight.w500),
            )));
  }
}
