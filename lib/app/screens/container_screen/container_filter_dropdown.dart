import 'package:demo_win_wms/app/data/entity/res/res_get_container_list_filter.dart';
import 'package:demo_win_wms/app/utils/constants.dart';
import 'package:demo_win_wms/app/utils/responsive.dart';
import 'package:flutter/material.dart';

class ContainerFilterDropDown extends StatefulWidget {
  ContainerFilterDropDown(
      {Key? key,
        required this.width,
        this.hint,
        required this.data,
        required this.onChange,
        this.selectedValue,
        this.icon})
      : super(key: key);

  final String? hint;
  final int width;
  final List<Warehouselist>? data;
  late Warehouselist? selectedValue;
  final Function(Warehouselist?) onChange;
  final Widget? icon;

  @override
  State<ContainerFilterDropDown> createState() =>
      _ContainerFilterDropDownState();
}

class _ContainerFilterDropDownState
    extends State<ContainerFilterDropDown> {
  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    final isMobile = Responsive.isMobile(context);

    final _size = MediaQuery.of(context).size;

    final width =
    isMobile ? _size.width / 2.8 : kFlexibleSize(widget.width.toDouble());

    return Container(
        width: width,
        //isMobile ? kFlexibleSize(120) : kFlexibleSize(288),
        height: 44,
        margin: EdgeInsets.only(
            right: kFlexibleSize(10), bottom: kFlexibleSize(10)),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black.withOpacity(0.1)),
            color: Colors.white,
            borderRadius: BorderRadius.circular(2)),
        padding: const EdgeInsets.only( left: 10),
        child: dropDown());
  }

  // Widget dropDownSearch() {
  //   return DropdownSearch<CarrierlistElement>(
  //       dropdownSearchDecoration: InputDecoration(
  //           border: InputBorder.none,
  //           hintText: widget.hint,
  //           contentPadding: EdgeInsets.zero),
  //       showAsSuffixIcons: true,
  //       dropDownButton: const Icon(
  //         Icons.arrow_drop_down,
  //         size: 30,
  //       ),
  //       showSearchBox: true,
  //       mode: Mode.MENU,
  //       items: widget.data,
  //       itemAsString: (CarrierlistElement? c) => (c?.text ?? ''),
  //       // onFind: (String? filter) => getData(filter),
  //       onChanged: print,
  //       selectedItem: widget.selectedValue);
  // }

  // Future<List<CarrierlistElement>> getData(String? s) {
  //   // print(s);
  //   return Future.value((widget.data
  //       ?.where((element) => (element.text ?? '').contains(s ?? ''))
  //       .toList()));
  // }

  Widget dropDown() {
    return DropdownButton<Warehouselist>(
      value: widget.selectedValue,
      iconSize: 30,
      style: const TextStyle(color: Colors.black),
      isExpanded: true,
      underline: const SizedBox(),
      items: widget.data?.map<DropdownMenuItem<Warehouselist>>(
              (Warehouselist value) {
            return DropdownMenuItem<Warehouselist>(
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
      onChanged: (Warehouselist? value) {
        widget.onChange(value);

        setState(() {
          widget.selectedValue = value;
        });
      },
    );
  }
}
