

import 'package:demo_win_wms/app/data/entity/res/res_pick_order_sales_order_list.dart';
import 'package:flutter/material.dart';
import 'package:demo_win_wms/app/utils/constants.dart';

class SalesOrderListView extends StatelessWidget {
  const SalesOrderListView({Key? key, this.list, this.pickItemOnClick, this.viewOnClick, required this.isEditing, this.completeOrder})
      : super(key: key);

  final List<SalesOrderList>? list;
  final Function(int)? viewOnClick;
  final Function(int)? pickItemOnClick;
  final Function()? completeOrder;
  final bool isEditing;

  TableRow get headers => TableRow(children: [
        tableHeaderView(text: 'Part No'),
        tableHeaderView(text: 'PO No'),
        tableHeaderView(text: 'Pallet No'),
        tableHeaderView(text: 'Available Qty'),
        tableHeaderView(text: 'Requested Qty'),
        tableHeaderView(text: 'Pending Qty'),
        tableHeaderView(text: 'Actual Picked'),
        tableHeaderView(text: 'UOM'),
        tableHeaderView(text: 'Suggested Location'),
        tableHeaderView(text: 'Status'),
        // tableHeaderView(text: 'Action'),
      ]);

  Widget listView({List<SalesOrderList>? list, required BuildContext context}) {
    if (list == null) {
      return Container();
    }

    final width = (MediaQuery.of(context).size.width - 77);

    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: width < 500 ? 900 : width,
        child: Table(
          children: List.generate(list.length + 1, (index) {
            if (index == 0) {
              return headers;
            } else {
              final data = list[index - 1];

              var actualPickedQty = data.actualPicked ?? 0;
              var requestedQty = data.qty ?? 0;
              var isPartInQaAlertOrNot = data.isPartInQaAlertOrNot == true;
              var isPartInTote = data.isPartInTote == true;
              var availableQty = data.availableQty ?? 0;
              Color? colorForPartNo;
              Color? colorForPartNoText;
              Color? color;
              Color? txtBgColor;
              Color? actualPickedColor;
              Color? actualPickedTxtBgColor;
              var transistQty = data.transistQty ?? 0;
              var isQtyArrivingBeforeShipDate = data.isQtyArrivingBeforeShipDate == true;

              if (requestedQty > availableQty) {
                if (isQtyArrivingBeforeShipDate && (availableQty + transistQty) >= requestedQty) {
                  color = const Color(0xfff9e491);
                } else {
                  color = const Color(0xffe7505a);
                  txtBgColor = Colors.white;
                }
              }

              if (isPartInQaAlertOrNot) {
                if (isEditing) {
                  if (data.currentPartStatusTerm?.toUpperCase() == "READY FOR DISPATCH" ||
                      data.currentPartStatusTerm?.toUpperCase() == "COMPLETED / SHORT" ||
                      data.currentPartStatusTerm?.toUpperCase() == "COMPLETED / OVER" ||
                      data.currentPartStatusTerm?.toUpperCase() == "COMPLETED / EXACT") {
                    colorForPartNo = const Color(0xfff9e491);
                    colorForPartNoText = Colors.blue;
                  } else {
                    colorForPartNo = const Color(0xfff9e491);
                    colorForPartNoText = Colors.blue;
                  }
                } else {
                  colorForPartNo = const Color(0xfff9e491);
                  colorForPartNoText = Colors.blue;
                }
              } else {
                if (isPartInTote) {
                  if (isEditing) {
                    if (data.currentPartStatusTerm?.toUpperCase() == "READY FOR DISPATCH" ||
                        data.currentPartStatusTerm?.toUpperCase() == "COMPLETED / SHORT" ||
                        data.currentPartStatusTerm?.toUpperCase() == "COMPLETED / OVER" ||
                        data.currentPartStatusTerm?.toUpperCase() == "COMPLETED / EXACT") {
                      colorForPartNo = const Color(0xff69a4e0);
                    } else {
                      colorForPartNo = const Color(0xff69a4e0);
                      colorForPartNoText = const Color(0xffFFFFFF);
                    }
                  } else {
                    colorForPartNo = const Color(0xff8e44ad);
                    colorForPartNoText = const Color(0xffFFFFFF);
                  }
                }
              }

              if (actualPickedQty < requestedQty) {
                actualPickedColor = const Color(0xffe7505a);
                actualPickedTxtBgColor = const Color(0xffffffff);
              } else if (actualPickedQty > requestedQty) {
                actualPickedColor = const Color(0xff0088cc);
                actualPickedTxtBgColor = Colors.white;
              }

              return TableRow(children: [
                tableCellViewWithColorForPartNo(
                    data: data, bgColor: colorForPartNo ?? Colors.red, textColor: colorForPartNoText ?? Colors.white),
                tableCellView(text: data.poNumber ?? '-'),
                tableCellView(text: data.palletNo ?? '-'),
                tableCellViewWithColorForAvailableQty(
                    text: '${data.availableQty ?? '-'}',
                    bgColor: color ?? Colors.white,
                    textColor: txtBgColor,
                    textBgColor: const Color(0xff578ebe)),
                tableCellView(text: '${data.qty ?? '-'}'),
                tableCellView(text: '${data.pendingQty ?? '-'}'),
                tableCellViewWithColor(
                    text: '${data.actualPicked ?? '-'}',
                    bgColor: actualPickedColor ?? Colors.white,
                    textColor: actualPickedTxtBgColor ?? Colors.black),
                tableCellView(text: data.uom ?? '-'),
                tableCellView(text: data.oldestStockSuggestedLocation ?? '-'),
                tableCellView(text: data.currentPartStatusTerm ?? '-'),
                // tableCellView(
                //     child: Wrap(
                //       children: [
                //         if(!isEditing)
                //         ActionButton(
                //           color: const Color(0XffB981FF),
                //           icon: kImgPopupViewIconWhite,
                //           text: 'View'),
                //         if(isEditing)
                //         ActionButton(
                //             onTap: (){
                //               if(pickItemOnClick != null){
                //                 pickItemOnClick!(data.pickOrderSoDetailId ?? 0);
                //               }
                //             },
                //             color: const Color(0XffFF5555),
                //             icon: kImgPopupPickWhite,
                //             text: 'Pick item'),
                //       ],
                //     )),
              ]);
            }
          }),
        ),
      ),
    );
  }

  Widget tableHeaderView({required String text}) {
    return Padding(
      padding: EdgeInsets.all(kFlexibleSize(2.5)),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: kFlexibleSize(35)),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: const Color(0xffE5E5E5),
              border: Border.all(color: Colors.black.withOpacity(0.25))),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Text(
                text,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: kFlexibleSize(16)),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget tableCellView({Widget? child, String? text}) {
    Widget myChild = Text(
      text ?? '',
      style: TextStyle(fontWeight: FontWeight.w500, fontSize: kFlexibleSize(16)),
      textAlign: TextAlign.center,
    );

    if (child != null) {
      myChild = child;
    }

    return Padding(
      padding: const EdgeInsets.all(2.5),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: kFlexibleSize(35)),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2), border: Border.all(color: Colors.black.withOpacity(0.25))),
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Center(
              child: myChild,
            ),
          ),
        ),
      ),
    );
  }

  Widget tableCellViewWithColorForPartNo(
      {required SalesOrderList data, required Color bgColor, Color? textColor, Color? textBgColor}) {
    Widget myChild = Text(
      data.itemName ?? '',
      style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: kFlexibleSize(16),
          color: textColor ?? Colors.white,
          backgroundColor: textBgColor ?? Colors.transparent),
      textAlign: TextAlign.center,
    );
    return InkWell(
      onTap: () {
        if (pickItemOnClick != null && isEditing) {
          pickItemOnClick!(data.pickOrderSoDetailId ?? 0);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(2.5),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: kFlexibleSize(35)),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(2), color: bgColor),
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Center(
                child: myChild,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget tableCellViewWithColorForAvailableQty(
      {required String text, required Color bgColor, Color? textColor, Color? textBgColor}) {
    Widget myChild = Text(
      text ,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: kFlexibleSize(16),
        color: textColor ?? Colors.white,
      ),
      textAlign: TextAlign.center,
    );
    return Padding(
      padding: const EdgeInsets.all(2.5),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: kFlexibleSize(35)),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: bgColor,
              border: Border.all(color: Colors.black.withOpacity(0.25))),
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Center(
              child: InkWell(
                  onTap: () {

                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: textBgColor,
                          borderRadius:
                              const BorderRadius.horizontal(left: Radius.circular(10), right: Radius.circular(10))),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                      child: myChild)),
            ),
          ),
        ),
      ),
    );
  }

  Widget tableCellViewWithColor({required String text, required Color bgColor, Color? textColor, Color? textBgColor}) {
    Widget myChild = Text(
      text ,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: kFlexibleSize(16),
        color: textColor ?? Colors.white,
      ),
      textAlign: TextAlign.center,
    );
    return Padding(
      padding: const EdgeInsets.all(2.5),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: kFlexibleSize(35)),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: bgColor,
              border: Border.all(color: Colors.black.withOpacity(0.25))),
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Center(
              child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.horizontal(left: Radius.circular(10), right: Radius.circular(10))),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                  child: myChild),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (list == null) {
      return Container();
    }

    Widget header(String text) => Container(
          child: Center(child: Text(text, style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500))),
          padding: const EdgeInsets.all(10),
          color: kBorderColor,
        );
    Widget value(String text) => Container(
        child: Center(child: Text(text, style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400))),
        padding: const EdgeInsets.all(10));

    return listView(context: context, list: list);
  }
}
