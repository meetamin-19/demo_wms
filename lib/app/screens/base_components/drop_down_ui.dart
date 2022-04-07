import 'package:flutter/material.dart';
import 'package:demo_win_wms/app/utils/constants.dart';
import 'package:demo_win_wms/app/utils/responsive.dart';

class DropDownUI extends StatelessWidget {
  const DropDownUI({Key? key, required this.text, required this.icon}) : super(key: key);

  final Widget icon;
  final String text;

  @override
  Widget build(BuildContext context) {

    final isDesktop = Responsive.isDesktop(context);

    final isMobile = Responsive.isMobile(context);

    final _size = MediaQuery.of(context).size;

    final width = isMobile ? _size.width / 2.8 : kFlexibleSize(290);

    return Container(
        width: width,//isMobile ? kFlexibleSize(120) : kFlexibleSize(288),
        height: 44,
        margin: EdgeInsets.only(right: kFlexibleSize(10), bottom: kFlexibleSize(10)),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        padding: EdgeInsets.symmetric(vertical: kFlexibleSize(5), horizontal: kFlexibleSize(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  SizedBox(child: icon,height: kFlexibleSize(20),width: kFlexibleSize(20)),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      text,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.black, fontSize: 15,fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.black,
              size: 30,
            ),
          ],
        ));
  }
}
