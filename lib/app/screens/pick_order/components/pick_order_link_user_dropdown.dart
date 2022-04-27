import 'package:demo_win_wms/app/data/entity/res/res_pickorder_link_user_list.dart';
import 'package:flutter/material.dart';
import 'package:demo_win_wms/app/utils/constants.dart';
import 'package:demo_win_wms/app/utils/responsive.dart';

class PickOrderLinkUserDropDown extends StatefulWidget {
  PickOrderLinkUserDropDown(
      {Key? key,
        this.hint,
        required this.data,
        required this.onChange,
        this.selectedValue,
      })
      : super(key: key);

  final String? hint;
  final List<PickOrderLinkUser> data;
  late PickOrderLinkUser? selectedValue;
  final Function(PickOrderLinkUser?) onChange;


  @override
  _PickOrderLinkUserDropDownState createState() => _PickOrderLinkUserDropDownState();
}

class _PickOrderLinkUserDropDownState extends State<PickOrderLinkUserDropDown> {
  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    final isMobile = Responsive.isMobile(context);

    final _size = MediaQuery.of(context).size;

    final width = isMobile ? _size.width / 2.8 : kFlexibleSize(290);

    return Container(
        width: width,
        //isMobile ? kFlexibleSize(120) : kFlexibleSize(288),
        height: 44,
        margin: EdgeInsets.only(
            right: kFlexibleSize(10), bottom: kFlexibleSize(10)),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        padding: const EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                  width: width,
                  //isMobile ? kFlexibleSize(120) : kFlexibleSize(288),
                  height: 60,
                  margin: EdgeInsets.only(
                      right: kFlexibleSize(10), bottom: kFlexibleSize(10)),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black.withOpacity(0.1)),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2)),
                  padding: const EdgeInsets.only( left: 10),
                  child: dropDown()),
            ),
          ],
        ));
  }

  Widget dropDown() {
    return DropdownButton<PickOrderLinkUser>(
      value: widget.selectedValue,
      iconSize: 20,
      style: const TextStyle(color: Colors.black),
      isExpanded: true,
      underline: const SizedBox(),
      items: widget.data.map<DropdownMenuItem<PickOrderLinkUser>>((PickOrderLinkUser value) {
        return DropdownMenuItem<PickOrderLinkUser>(
          value: value,
          child: Text(
            value.text ?? '',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        );
      }).toList(),
      hint: Text(
        widget.hint ?? '',
        style: const TextStyle(
          fontSize: 15,
        ),
      ),
      onChanged: (PickOrderLinkUser? value) {
        widget.onChange(value);

        setState(() {
          widget.selectedValue = value;
        });
      },
    );
  }
}
