import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:demo_win_wms/app/data/entity/res/res_shipping_verification_list_filter.dart';

import '../../../utils/constants.dart';
import '../../../utils/responsive.dart';

class ShippingVerificationFilterDropDown extends StatefulWidget {

   ShippingVerificationFilterDropDown({Key? key,
    this.hint,
    required this.data,
    required this.onChange,
    this.selectedValue,
    required this.icon}) : super(key: key);


  final String? hint;
  final List<CarrierlistElement>? data;
  late CarrierlistElement? selectedValue;
  final Function(CarrierlistElement?) onChange;
  final Widget icon;

  @override
  State<ShippingVerificationFilterDropDown> createState() => _ShippingVerificationFilterDropDownState();
}

class _ShippingVerificationFilterDropDownState extends State<ShippingVerificationFilterDropDown> {
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
        padding: EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  SizedBox(
                      child: widget.icon,
                      height: kFlexibleSize(20),
                      width: kFlexibleSize(20)),
                  const SizedBox(width: 5),
                  Expanded(
                    child: dropDown(),
                    // child: InkWell(
                    //   child: Text(widget.selectedValue == null ? 'cool' : (widget.selectedValue?.text ?? '')),
                    //   onTap: (){
                    //     callSearchList(context: context, searchList: widget.data.map((e) => SearchModel(id: int.parse(e.value ?? '0'),title: e.text ?? '')).toList(), selectedObject: (obj){
                    //       setState(() {
                    //         widget.selectedValue = widget.data.where((element) => element.value == obj.id.toString()).first;
                    //       });
                    //     });
                    //   },
                    // ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Widget dropDownSearch(){

    return DropdownSearch<CarrierlistElement>(
        dropdownSearchDecoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.hint,
            contentPadding: EdgeInsets.zero
        ),
        showAsSuffixIcons: true,
        dropDownButton: Icon(Icons.arrow_drop_down,size: 30,),
        showSearchBox: true,
        mode: Mode.MENU,
        items: widget.data,
        itemAsString: (CarrierlistElement? c) => (c?.text ?? ''),
        // onFind: (String? filter) => getData(filter),
        onChanged: print,
        selectedItem: widget.selectedValue);
  }

  Future<List<CarrierlistElement>> getData(String? s){
    print(s);
    return Future.value((widget.data?.where((element) => (element.text ?? '').contains(s ?? '')).toList()));
  }

  Widget dropDown() {
    return DropdownButton<CarrierlistElement>(
      value: widget.selectedValue,
      iconSize: 30,
      style: TextStyle(color: Colors.black),
      isExpanded: true,
      underline: SizedBox(),
      items: widget.data?.map<DropdownMenuItem<CarrierlistElement>>((CarrierlistElement value) {
        return DropdownMenuItem<CarrierlistElement>(
          value: value,
          child: Text(
            value.text ?? '',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        );
      }).toList(),
      hint: Text(
        widget.hint ?? '',
        style: TextStyle(
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
