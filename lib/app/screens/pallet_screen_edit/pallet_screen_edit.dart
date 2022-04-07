import 'package:flutter/material.dart';
import 'package:demo_win_wms/app/data/entity/res/res_get_pallet_list_data_by_id.dart';
import 'package:demo_win_wms/app/providers/pallet_provider.dart';
import 'package:demo_win_wms/app/screens/base_components/common_app_bar.dart';
import 'package:demo_win_wms/app/screens/base_components/common_theme_container.dart';
import 'package:demo_win_wms/app/screens/pick_order_list/components/pick_order_key_value.dart';
import 'package:demo_win_wms/app/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:demo_win_wms/app/utils/enums.dart';
import 'package:demo_win_wms/app/utils/responsive.dart';
import 'package:demo_win_wms/app/views/base_button.dart';
import 'package:demo_win_wms/app/views/loading_small.dart';
import 'package:demo_win_wms/app/views/no_data_found.dart';

class PalletScreenEdit extends StatelessWidget {
  const PalletScreenEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: CommonThemeContainer(
            title: '',
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                header(context),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    partStatus(context),
                    Row(
                      children: [
                        InkWell(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                            decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(2)),
                            child: Text(
                              'Complete Pick Order',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        InkWell(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                            decoration: BoxDecoration(
                                color: Color(0xFF11BCCB),
                                borderRadius: BorderRadius.circular(2)),
                            child: Text(
                              'Complete part',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    child: Container(
                      width: 120,
                      padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                      decoration: BoxDecoration(
                          color: Color(0xFF11BCCB),
                          borderRadius: BorderRadius.circular(2)),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                                'Add Pallet',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15),
                              )),
                          SizedBox(
                            child: kImgAddIcon,
                            width: 15,
                            height: 15,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                pallets(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text partStatus(BuildContext context) {

    final pallet = context.read<PalletProviderImpl>();

    final pickOrder = pallet.lineItemRes?.data?.data?.pickOrder;

    return Text('Part Status: ${pickOrder?.statusTerm ?? ''}',style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),);
  }

  Widget header(BuildContext context) {
    return Responsive(
        mobile: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: kBorderColor),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child:lineItem(context)
              ),
            ),
            SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: kBorderColor),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child:itemStock(context)
              ),
            ),
          ],
        ),
        desktop: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: kBorderColor),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child:lineItem(context)
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: kBorderColor),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child:itemStock(context)
                ),
              ),
            )
          ],
        ));
  }

  Widget lineItem(BuildContext context) {
    final pallet = context.watch<PalletProviderImpl>();

    Widget table() {
      final isLoading = pallet.lineItemRes?.state == Status.LOADING;

      if (isLoading) {
        return LoadingSmall();
      }

      final hasError = pallet.lineItemRes?.state == Status.ERROR;

      if (hasError) {
        return NoDataFoundView(
          retryCall: () {
            context.read<PalletProviderImpl>().pickOrderViewLineItem();
          },
        );
      }

      final pickOrder = pallet.lineItemRes?.data?.data?.pickOrder;
      final pickOrderSoDetails =
          pallet.lineItemRes?.data?.data?.pickOrderSoDetail;

      if (pickOrder == null || pickOrderSoDetails == null) {
        return NoDataFoundView(
          retryCall: () {
            context.read<PalletProviderImpl>().pickOrderViewLineItem();
          },
        );
      }

      return LayoutBuilder(builder: (context, constraints) {

        final isTab = Responsive.isTablet(context);

        final width = (constraints.maxWidth - 30) / (isTab ? 3 : 2);

        return Wrap(
          runSpacing: 10,
          children: [
            PickOrderKeyValue(width: width,title: 'Order No',value: '${pickOrder.soNumber ?? '-'}'),
            SizedBox(width: 10),
            PickOrderKeyValue(width: width,title: 'Box Qty',value: '${pickOrderSoDetails.boxQty ?? '-'}'),
            if(isTab)
              SizedBox(width: 10),
            PickOrderKeyValue(width: width,title: 'Part Number',value: '${pickOrderSoDetails.itemName ?? '-'}'),
            SizedBox(width: 10),
            PickOrderKeyValue(width: width,title: 'Requested Qty',value: '${pickOrderSoDetails.requestedQty ?? '-'}'),
            if(isTab)
              SizedBox(width: 10),
            PickOrderKeyValue(width: width,title: 'PO Number',value: '${pickOrderSoDetails.poNumber ?? '-'}'),
            SizedBox(width: 10),
            PickOrderKeyValue(width: width,title: 'UOM',value: '${pickOrderSoDetails.uom ?? '-'}'),
          ],
        );
      },);

    }

    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: kDarkFontColor,
          ),
          padding: EdgeInsets.all(10),
          child: Text(
            'Line Item',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        SizedBox(height: 6),
        table(),
        SizedBox(height: 10),
      ],
    );
  }

  Widget itemStock(BuildContext context) {
    final pallet = context.watch<PalletProviderImpl>();

    Widget header(String text) => Container(
          child: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
            textAlign: TextAlign.center,
          ),
          color: kBorderColor,
          padding: EdgeInsets.all(10),
        );
    Widget value(String text) => Container(
          child: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
            textAlign: TextAlign.center,
          ),
          padding: EdgeInsets.all(10),
        );

    Widget table() {
      final isLoading = pallet.lineItemRes?.state == Status.LOADING;

      if (isLoading) {
        return LoadingSmall();
      }

      final hasError = pallet.lineItemRes?.state == Status.ERROR;

      if (hasError) {
        return NoDataFoundView(
          retryCall: () {
            context.read<PalletProviderImpl>().pickOrderViewLineItem();
          },
        );
      }

      final pickOrder = pallet.lineItemRes?.data?.data?.pickOrder;
      final pickOrderSoDetails =
          pallet.lineItemRes?.data?.data?.pickOrderSoDetail;
      final itemLocationList =
          pallet.lineItemRes?.data?.data?.itemLocationList;


      if (pickOrder == null || pickOrderSoDetails == null) {
        return NoDataFoundView(
          retryCall: () {
            context.read<PalletProviderImpl>().pickOrderViewLineItem();
          },
        );
      }

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 7),
        child: Table(
          columnWidths: {
            0:FlexColumnWidth(5),
            1:FlexColumnWidth(8),
            2:FlexColumnWidth(5),
            3:FlexColumnWidth(5),
            4:FlexColumnWidth(5),
            5:FlexColumnWidth(5),
          },
          border: TableBorder.all(color: kBorderColor),
          children: List.generate((itemLocationList?.length ?? 0) + 1, (index) {

            if(index == 0){
              return TableRow(children: [
                header('Part No.'),
                header('Location'),
                header('LC Type'),
                header('Month'),
                header('Year'),
                header('Avail Qty'),
              ]);
            }

            final data = itemLocationList?[index - 1];

            return TableRow(
                children: [
                  value('${data?.itemName ?? '-'}'),
                  value('${data?.locationName ?? '-'}\n${data?.warehouseName ?? '-'}\n${data?.sectionName ?? '-'}\n${data?.companyName ?? '-'}'),
                  value('${data?.locationType ?? '-'}'),
                  value('${data?.monthName ?? '-'}'),
                  value('${data?.fullYear ?? '-'}'),
                  value('${data?.availableQty ?? 0}'),
            ]);
          }),
        ),
      );
    }

    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: kDarkFontColor,
          ),
          padding: EdgeInsets.all(10),
          child: Text(
            'Item Stock',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        SizedBox(height: 6),
        table(),
        SizedBox(height: 10),
      ],
    );
  }

  Widget pallets(BuildContext context) {
    final provider = context.watch<PalletProviderImpl>();

    final isLoading = provider.palletsRes?.state == Status.LOADING;

    if (isLoading) {
      return LoadingSmall();
    }

    final hasError = provider.palletsRes?.state == Status.ERROR;

    if (hasError) {
      return NoDataFoundView(
        title: 'No Pallets Found',
      );
    }

    final data = provider.palletsRes?.data?.data?.pickOrderPalletList;

    if (data == null) {
      return NoDataFoundView(
        title: 'No Pallets Found',
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final res = data[index];

        return PalletEditList(
          PickOrder: res,
          pallets: res.child,
        );
      },
    );
  }
}

class PalletEditList extends StatefulWidget {
  const PalletEditList({Key? key, required this.PickOrder, this.pallets})
      : super(key: key);

  final PickOrderPalletList PickOrder;

  final List<PickOrderdetailList>? pallets;

  @override
  _PalletEditListState createState() => _PalletEditListState();
}

class _PalletEditListState extends State<PalletEditList> {
  bool isVisible = false;

  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final fieldsWidth = width * 0.37;

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: kBorderColor)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onFocusChange: (isFocus) {
              setState(() {
                isFocused = (isFocus == true);
              });
            },
            onTap: () {
              setState(() {
                isVisible = !isVisible;
              });
            },
            child: Container(
              width: double.infinity,
              color: isFocused ? kDarkFontColor : kDarkFontColor,
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${widget.PickOrder.palletNo ?? ''}',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Text('Pallet Status: ${widget.PickOrder.statusTerm ?? ''}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                  Container(
                      width: 44,
                      child: Icon(
                          isVisible ? Icons.arrow_drop_down : Icons.arrow_right,
                          color: Colors.white))
                ],
              ),
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: !isVisible
                ? Container()
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Scan Location',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(height: 10),
                                SizedBox(
                                  width: fieldsWidth,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border:
                                              Border.all(color: kBorderColor)),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: TextField(
                                              autofocus: true,
                                              decoration: InputDecoration(
                                                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                                  border: InputBorder.none),
                                            ),
                                          ),
                                          Container(
                                            height: 50,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 20),
                                            color: kThemeBlueFontColor,
                                            child: Center(
                                              child: Text(
                                                'Change Location',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Scan Part',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(height: 10),
                                SizedBox(
                                  width: fieldsWidth,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border:
                                              Border.all(color: kBorderColor)),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: TextField(
                                              autofocus: true,
                                              decoration: InputDecoration(
                                                // prefixIcon: LoadingSmall(),
                                                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                                  border: InputBorder.none),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      table(pallets: widget.pallets),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                decoration: BoxDecoration(
                                    color: kThemeBlueFontColor,
                                    borderRadius: BorderRadius.circular(2)),
                                child: Text(
                                  'Bind Location',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            InkWell(
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    borderRadius: BorderRadius.circular(2)),
                                child: Text(
                                  'Delete Pallet',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget table({List<PickOrderdetailList>? pallets}) {
    Widget header(String text) => Container(
          child: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
            textAlign: TextAlign.center,
          ),
          color: kBorderColor,
          padding: EdgeInsets.all(10),
        );
    Widget value(String text) => Container(
          child: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
            textAlign: TextAlign.center,
          ),
          padding: EdgeInsets.all(10),
        );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Table(
          border: TableBorder.all(color: kBorderColor),
          children: List.generate((pallets?.length ?? 0) + 1, (index) {
            if (index == 0) {
              return TableRow(
                children: [
                  header('Part No'),
                  header('PO No'),
                  header('Location Name'),
                  header('Month'),
                  header('Year'),
                  header('Actual Picked'),
                  header('Number of Boxes'),
                ],
              );
            }

            final pallet = pallets?[index - 1];

            return TableRow(
              children: [
                value('${pallet?.itemName ?? ''}'),
                value('${pallet?.palletNo ?? ''}'),
                value('${pallet?.locationTitle ?? ''}'),
                value('${pallet?.monthName ?? ''}'),
                value('${pallet?.year ?? ''}'),
                value('${pallet?.actualPicked ?? 0.0}'),
                value('${pallet?.numberOfBoxes ?? 0}'),
              ],
            );
          })),
    );
  }
}
