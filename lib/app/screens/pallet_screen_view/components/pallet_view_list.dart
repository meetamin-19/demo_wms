import 'package:flutter/material.dart';
import 'package:demo_win_wms/app/data/entity/res/res_get_pallet_list_data_by_id.dart';
import 'package:demo_win_wms/app/providers/pallet_provider.dart';
import 'package:demo_win_wms/app/utils/constants.dart';
import 'package:provider/provider.dart';

class PalletViewList extends StatefulWidget {
  const PalletViewList({Key? key, required this.title, this.pallets }) : super(key: key);

  final String title;

  final PickOrderPalletList? pallets;

  @override
  _PalletViewListState createState() => _PalletViewListState();
}

class _PalletViewListState extends State<PalletViewList> {

  bool isVisible = false;

  bool isFocused = false;

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: kBorderColor)
      ),
      child: Column(
        children: [
          InkWell(
            onFocusChange: (isFocus){
              setState(() {
                isFocused = (isFocus == true);
              });
            },
            onTap: (){
              setState(() {
                isVisible = !isVisible;
              });
            },
            child: Container(
              width: double.infinity,
              color: isFocused ? Colors.black.withOpacity(0.25) : kBorderColor,
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: Text('${widget.title}',style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                    ),),
                  ),
                  Container(
                      width: 44,
                      child: Icon(isVisible ? Icons.arrow_drop_down : Icons.arrow_right))
                ],
              ),
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: !isVisible ? Container() : table(pallets: widget.pallets?.child)
            ,
          ),
        ],
      ),
    );
  }

  Widget table({List<PickOrderdetailList>? pallets, int? id}) {
    Widget TableHeader(String text) => Text(text,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),textAlign: TextAlign.center,);

    Widget TableRow(String text) => Text(text,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),textAlign: TextAlign.center);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                child: Container(
                  child: Center(
                      child: Text(
                        'Generate Pdf',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      )),
                  decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(2)
                  ),
                  padding: EdgeInsets.all(5),
                ),
                onTap: (){
                  context.read<PalletProviderImpl>().printPdfFromURL();
                },
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: kBorderColor)
          ),
          child: Row(
            children: [
              Expanded(child: TableHeader('Part No')),
              Expanded(child: TableHeader('PO No')),
              Expanded(child: TableHeader('Location')),
              Expanded(child: TableHeader('Month')),
              Expanded(child: TableHeader('Year')),
              Expanded(child: TableHeader('Requested')),
              Expanded(child: TableHeader('Actual Picked')),
              Expanded(child: TableHeader('Box Qty')),
              Expanded(child: TableHeader('No of boxes')),
            ],
          ),
        ),
        SizedBox(height: 5),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: pallets?.length ?? 0,
          itemBuilder: (context, index) {

            final pallet = pallets?[index];

            return Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: kBorderColor)
              ),
              child: Row(
                children: [
                  Expanded(child: TableRow('${pallet?.itemName ?? ''}')),
                  Expanded(child: TableRow('${pallet?.palletNo ?? ''}')),
                  Expanded(child: TableRow('${pallet?.locationTitle ?? ''}')),
                  Expanded(child: TableRow('${pallet?.monthName ?? ''}')),
                  Expanded(child: TableRow('${pallet?.year ?? ''}')),
                  Expanded(child: TableRow('${pallet?.removeQty ?? 0.0}')),
                  Expanded(child: TableRow('${pallet?.actualPicked ?? 0.0}')),
                  Expanded(child: TableRow('${pallet?.boxQty ?? 0}')),
                  Expanded(child: TableRow('${pallet?.numberOfBoxes ?? 0}')),
                ],
              ),
            );
          },),
        SizedBox(height: 20),
      ],
    );
  }
}