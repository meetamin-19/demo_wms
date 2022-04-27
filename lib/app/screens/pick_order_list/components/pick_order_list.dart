import 'package:demo_win_wms/app/data/entity/res/res_pick_order_sales_order_list.dart';
import 'package:flutter/material.dart';
import 'package:demo_win_wms/app/screens/base_components/action_button.dart';
import 'package:demo_win_wms/app/utils/constants.dart';

class PickOrderList extends StatelessWidget {
  const PickOrderList({Key? key, this.list, this.pickItemOnClick, this.viewOnClick,required this.isEditing}) : super(key: key);

  final List<SalesOrderList>? list;
  final Function(int)? viewOnClick;
  final Function(int)? pickItemOnClick;
  final bool isEditing;

  TableRow get headers => TableRow(children: [
    tableHeaderView(text: 'Part No'),
    tableHeaderView(text: 'PO No'),
    tableHeaderView(text: 'Pallet No'),
    tableHeaderView(text: 'Available Qty'),
    tableHeaderView(text: 'Requested Qty'),
    tableHeaderView(text: 'Actual Picked'),
    tableHeaderView(text: 'UOM'),
    tableHeaderView(text: 'Suggested Location'),
    tableHeaderView(text: 'Status'),
    tableHeaderView(text: 'Action'),
  ]);

  Widget listView({List<SalesOrderList>? list,required BuildContext context}) {
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


              var actualPickedQty = data.actualPicked;
              var requestedQty = data.qty ?? 0;
              var isPartInQaAlertOrNot = data.isPartInQaAlertOrNot == true;
              var isPartInTote = data.isPartInTote == true;
              var availableQty = data.availableQty ?? 0 ;
              var transistQty = data.transistQty ?? 0;
              var isQtyArrivingBeforeShipDate = data.isQtyArrivingBeforeShipDate == true;

              if(requestedQty > availableQty) {
                if(isQtyArrivingBeforeShipDate && (availableQty + transistQty) >= requestedQty){

                }
              }


              return TableRow(children: [
                tableCellViewWithColor(text: '${data.itemId ?? '-'}', bgColor: Colors.red),
                tableCellView(text: data.poNumber ?? '-'),
                tableCellView(text: data.palletNo ?? '-'),
                tableCellView(text: '${data.availableQty ?? '-'}'),
                tableCellView(text: '${data.qty ?? '-'}'),
                tableCellView(text: '${data.actualPicked ?? '-'}'),
                tableCellView(text: data.uom ?? '-'),
                tableCellView(text: data.oldestStockSuggestedLocation ?? '-'),
                tableCellView(text: data.currentPartStatusTerm ?? '-'),
                tableCellView(
                    child: Wrap(
                      children: [
                        ActionButton(
                          color: const Color(0XffB981FF),
                          icon: kImgPopupViewIconWhite,
                          text: 'View',onTap: (){
                          if(viewOnClick != null){
                            viewOnClick!(data.pickOrderSoDetailId ?? 0);
                          }
                        },),
                        if(isEditing && data.currentPartStatusTerm == 'Part In Progress')
                        ActionButton(
                            onTap: (){
                              if(pickItemOnClick != null){
                                pickItemOnClick!(data.pickOrderSoDetailId ?? 0);
                              }
                            },
                            color: Color(0XffFF5555),
                            icon: kImgPopupPickWhite,
                            text: 'Pick item'),
                      ],
                    )),
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
                style: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: kFlexibleSize(16)),
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
      style:
      TextStyle(fontWeight: FontWeight.w500, fontSize: kFlexibleSize(16)),
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
              borderRadius: BorderRadius.circular(2),
              border: Border.all(color: Colors.black.withOpacity(0.25))),
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

  Widget tableCellViewWithColor({required String text , required Color bgColor , Color? textColor, Color? textBgColor }){
    Widget myChild = Text(
      text ?? '',
      style:
      TextStyle(fontWeight: FontWeight.w500, fontSize: kFlexibleSize(16),color: textColor ?? Colors.white,backgroundColor: textBgColor ?? Colors.transparent),
      textAlign: TextAlign.center,
    );
    return Padding(
      padding: const EdgeInsets.all(2.5),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: kFlexibleSize(35)),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
            color: bgColor
              ),
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

  @override
  Widget build(BuildContext context) {
    if (list == null) {
      return Container();
    }

    Widget header(String text) => Container(child: Center(child: Text(text, style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w500))),padding: EdgeInsets.all(10),color: kBorderColor,);
    Widget value(String text) => Container(child: Center(child: Text(text, style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.w400))),padding: EdgeInsets.all(10));

    return listView(context: context,list: list);
  }
}
