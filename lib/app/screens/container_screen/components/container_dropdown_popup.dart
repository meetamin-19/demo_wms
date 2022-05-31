import 'package:demo_win_wms/app/data/entity/res/res_container_link_location.dart';
import 'package:demo_win_wms/app/data/entity/res/res_pickorder_link_user_list.dart';
import 'package:flutter/material.dart';
import 'package:demo_win_wms/app/utils/constants.dart';
import 'package:demo_win_wms/app/utils/responsive.dart';
import 'package:flutter/widgets.dart';

class ContainerLinkLocationDropDown extends StatefulWidget {
  ContainerLinkLocationDropDown(
      {Key? key,
        this.hint,
        required this.data,
        required this.onChange,
        this.selectedValue,
      })
      : super(key: key);

  final String? hint;
  final List<WarehouseLocationlist> data;
  late WarehouseLocationlist? selectedValue;
  final Function(WarehouseLocationlist?) onChange;


  @override
  _ContainerLinkLocationDropDownState createState() => _ContainerLinkLocationDropDownState();
}

class _ContainerLinkLocationDropDownState extends State<ContainerLinkLocationDropDown> {
  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    final isMobile = Responsive.isMobile(context);

    final _size = MediaQuery.of(context).size;

    final width = isMobile ? _size.width / 2.8 : kFlexibleSize(290);

    return Container(
        width: MediaQuery.of(context).size.width / 2.8,
        //isMobile ? kFlexibleSize(120) : kFlexibleSize(288),
        height: 48,
        margin: EdgeInsets.only(
            right: kFlexibleSize(10), bottom: kFlexibleSize(10)),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        padding: const EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Container(
                  // width: width,
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
    return DropdownButtonHideUnderline(
      child: DropdownButton<WarehouseLocationlist>(
        value: widget.selectedValue,
        iconSize: 20,
        style: const TextStyle(color: Colors.black),
        isExpanded: true,
        underline: const SizedBox(),
        items: widget.data.map<DropdownMenuItem<WarehouseLocationlist>>((WarehouseLocationlist value) {
          return DropdownMenuItem<WarehouseLocationlist>(
            value: value,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    value.text ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 3),
                    child: Container(
                      height: kFlexibleSize(20),
                      color: Color(0xff32C5D2),
                      child: Center(
                        child: Text(
                          value.data1 ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 3),
                    child: Container(
                      height: kFlexibleSize(20),
                      color: Color(0xffFF5555),
                      child: Center(
                        child: Text(
                          value.data2 ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 3),
                    child: Container(
                      height: kFlexibleSize(20),
                      color: Color(0xffFF5555),
                      child: Center(
                        child: Text(
                          value.data3 ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
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
        onChanged: (WarehouseLocationlist? value) {
          widget.onChange(value);

          setState(() {
            widget.selectedValue = value;
          });
        },
      ),
    );
  }
}
