import 'package:flutter/material.dart';
import 'package:demo_win_wms/app/data/entity/res/res_get_pick_order_data_for_view.dart';
import 'package:demo_win_wms/app/screens/base_components/action_button.dart';
import 'package:demo_win_wms/app/utils/constants.dart';

class PickOrderList extends StatelessWidget {
  const PickOrderList({Key? key, this.list, this.pickItemOnClick, this.viewOnClick,required this.isEditing}) : super(key: key);

  final List<SalesOrderDetailList>? list;
  final Function(int)? viewOnClick;
  final Function(int)? pickItemOnClick;
  final bool isEditing;

  TableRow get headers => TableRow(children: [
    TableHeaderView(text: 'Part No'),
    TableHeaderView(text: 'PO No'),
    TableHeaderView(text: 'Pallet No'),
    TableHeaderView(text: 'Available Qty'),
    TableHeaderView(text: 'Requested Qty'),
    TableHeaderView(text: 'Actual Picked'),
    TableHeaderView(text: 'UOM'),
    TableHeaderView(text: 'Suggested Location'),
    TableHeaderView(text: 'Status'),
    TableHeaderView(text: 'Action'),
  ]);

  Widget listView({List<SalesOrderDetailList>? list,required BuildContext context}) {
    if (list == null) {
      return Container();
    }

    final width = (MediaQuery.of(context).size.width - 77);

    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: width < 500 ? 900 : width,
        child: Table(
          children: List.generate(list.length + 1, (index) {
            if (index == 0) {
              return headers;
            } else {
              final data = list[index - 1];

              return TableRow(children: [
                TableCellView(text: '${data.itemId ?? '-'}'),
                TableCellView(text: data.poNumber ?? '-'),
                TableCellView(text: '${data.palletNo ?? '-'}'),
                TableCellView(text: '${data.availableQty ?? '-'}'),
                TableCellView(text: '${data.qty ?? '-'}'),
                TableCellView(text: '${data.actualPicked ?? '-'}'),
                TableCellView(text: data.uom ?? '-'),
                TableCellView(text: '{data.sfgr a'),
                TableCellView(text: data.currentPartStatusTerm ?? '-'),
                TableCellView(
                    child: Wrap(
                      children: [
                        ActionButton(
                          color: const Color(0XffB981FF),
                          icon: kImgPopupViewIconWhite,
                          text: 'View',onTap: (){
                          if(viewOnClick != null){
                            viewOnClick!(data.pickOrderSODetailID ?? 0);
                          }
                        },),
                        if(isEditing && data.currentPartStatusTerm == 'Part In Progress')
                        ActionButton(
                            onTap: (){
                              if(pickItemOnClick != null){
                                pickItemOnClick!(data.pickOrderSODetailID ?? 0);
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



  Widget TableHeaderView({required String text}) {
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

  Widget TableCellView({Widget? child, String? text}) {
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
