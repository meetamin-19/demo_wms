import 'package:flutter/material.dart';
import 'package:demo_win_wms/app/utils/constants.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({Key? key,this.icon,this.text,this.color, this.onTap}) : super(key: key);

  final Widget? icon;
  final String? text;
  final Color? color;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(1.5),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(kFlexibleSize(6)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(child: icon,width: kFlexibleSize(14)),
              kFlexibleSizedBox(width: 5),
              Flexible(child: Text(text ?? '',style: TextStyle(color: Colors.white,fontSize: kFlexibleSize(12),fontWeight: FontWeight.w400),))
            ],
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.5),
              color: color ?? kPrimaryColor
          ),
        ),
      ),
    );
  }
}
