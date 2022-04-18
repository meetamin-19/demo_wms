import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:demo_win_wms/app/data/entity/res/res_shipping_verification_list_filter.dart';
import '../../../utils/constants.dart';
import '../../../utils/responsive.dart';

class ShippingVerificationFilterDropDown extends StatefulWidget {
  ShippingVerificationFilterDropDown(
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
  final List<CarrierlistElement>? data;
  late CarrierlistElement? selectedValue;
  final Function(CarrierlistElement?) onChange;
  final Widget? icon;

  @override
  State<ShippingVerificationFilterDropDown> createState() =>
      _ShippingVerificationFilterDropDownState();
}

class _ShippingVerificationFilterDropDownState
    extends State<ShippingVerificationFilterDropDown> {
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
    return DropdownButton<CarrierlistElement>(
      value: widget.selectedValue,
      iconSize: 30,
      style: const TextStyle(color: Colors.black),
      isExpanded: true,
      underline: const SizedBox(),
      items: widget.data?.map<DropdownMenuItem<CarrierlistElement>>(
          (CarrierlistElement value) {
        return DropdownMenuItem<CarrierlistElement>(
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
      onChanged: (CarrierlistElement? value) {
        widget.onChange(value);

        setState(() {
          widget.selectedValue = value;
        });
      },
    );
  }
}
