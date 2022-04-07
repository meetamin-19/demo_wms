import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demo_win_wms/app/data/entity/res/res_get_pick_order_data_for_view.dart';
import 'package:demo_win_wms/app/providers/pallet_provider.dart';
import 'package:demo_win_wms/app/providers/pick_order_provider.dart';
import 'package:demo_win_wms/app/screens/base_components/action_button.dart';
import 'package:demo_win_wms/app/screens/base_components/common_app_bar.dart';
import 'package:demo_win_wms/app/screens/base_components/common_theme_container.dart';
import 'package:demo_win_wms/app/screens/pick_order/leading_text_field.dart';
import 'package:demo_win_wms/app/screens/pick_order_list/components/pick_order_list.dart';
import 'package:demo_win_wms/app/utils/constants.dart';
import 'package:demo_win_wms/app/utils/enums.dart';
import 'package:demo_win_wms/app/utils/responsive.dart';
import 'package:demo_win_wms/app/views/loading_small.dart';
import 'package:demo_win_wms/app/views/no_data_found.dart';

import 'components/pick_order_key_value.dart';

class PickOrderListScreen extends StatelessWidget {
  PickOrderListScreen({Key? key}) : super(key: key);

  ScrollController controller = ScrollController();

  getUserData(BuildContext context) {
    context.read<PickOrderProviderImpl>().getPickOrderData();
  }

  filterData(BuildContext context, String str) {
    context.read<PickOrderProviderImpl>().searchFromSalesOderList(str: str);
  }

  scroll() {
    // controller.animateTo(400, duration: Duration(milliseconds: 400),curve: Curves.easeIn);
  }

  viewItem(int id,BuildContext context){
    final pallet = context.read<PalletProviderImpl>();
    final pickOrder = context.read<PickOrderProviderImpl>();

    pallet.selectedPickOrderID = pickOrder.pickOrderID;
    pallet.selectedPickOrderSODetailID = id;

    pallet.pickOrderViewLineItem();
    pallet.getPallets();

    Navigator.of(context).pushNamed(kPalletViewScreenRoute);
  }

  pickItem(int id,BuildContext context){
    final pallet = context.read<PalletProviderImpl>();
    final pickOrder = context.read<PickOrderProviderImpl>();

    pallet.selectedPickOrderID = pickOrder.pickOrderID;
    pallet.selectedPickOrderSODetailID = id;

    pallet.pickOrderViewLineItem();
    pallet.getPallets();

    Navigator.of(context).pushNamed(kPalletScreenEditRoute);
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    final isMobile = Responsive.isMobile(context);

    final provider = context.watch<PickOrderProviderImpl>();

    return Scaffold(
      appBar: CommonAppBar(),
      body: body(context, provider, _size, isMobile),
    );
  }

  Widget body(
      context, PickOrderProviderImpl provider, Size _size, bool isMobile) {
    final isLoading = provider.getPickOrder?.state == Status.LOADING;

    if (isLoading) {
      return Container(
        color: Colors.black12,
        child: Center(
          child: Container(
              height: 50,
              width: 50,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: LoadingSmall()),
        ),
      );
    }

    final hasError = provider.getPickOrder?.state == Status.ERROR;

    if (hasError) {
      return Container(
        color: Colors.white,
        width: double.infinity,
        child: NoDataFoundView(
          retryCall: () {
            getUserData(context);
          },
        ),
      );
    }

    final data = provider.getPickOrder?.data?.data;

    final sales = data?.salesOrder;
    final salesList = provider.filteredSalesOrderDetailList;

    return SingleChildScrollView(
      controller: controller,
      child: Container(
        padding: EdgeInsets.all(_size.width * 0.015),
        child: Column(
          children: [
            headerView(isMobile, sales: sales),

            kFlexibleSizedBox(height: 10),

            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(color: Colors.black.withOpacity(0.25))),
                padding: EdgeInsets.all(kFlexibleSize(15)),
                child: addresses(sales),
              ),
            ),

            kFlexibleSizedBox(height: 10),

            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(color: Colors.black.withOpacity(0.25))),
                padding: EdgeInsets.all(kFlexibleSize(15)),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: _size.width * 0.3,
                          height: 35,
                          child: LeadingTextField(
                            onTap: () {
                              scroll();
                            },
                            isLast: true,
                            onChanged: (str) {
                              filterData(context, str);
                            },
                            leading: Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child: Icon(
                                Icons.search,
                                color: const Color(0xff202842).withOpacity(0.2),
                              ),
                            ),
                            hint: 'Search',
                          ),
                        ),
                        Visibility(
                          visible: false,
                          child: Container(
                            height: 35,
                            width: _size.width * 0.2,
                            padding: EdgeInsets.only(left: kFlexibleSize(15)),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(
                                  color: Colors.black.withOpacity(0.25)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Records',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: kFlexibleSize(14),
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_drop_down_rounded,
                                  color: Colors.black,
                                  size: kFlexibleSize(30),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    kFlexibleSizedBox(height: 15),
                    PickOrderList(list: salesList,viewOnClick: (int id){
                      viewItem(id, context);
                    },pickItemOnClick: (int id){
                      pickItem(id, context);
                    },isEditing: provider.isInEditingMode,)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget addresses(SalesOrder? sales) {

    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Shipping Address :'),
                SizedBox(height: 10),
                Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                            color: Colors.black.withOpacity(0.25))),
                    child: Text('${sales?.shippingOrToteAddress ?? '-'}')),
              ],
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Billing Address :'),
                SizedBox(height: 10),
                Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                            color: Colors.black.withOpacity(0.25))),
                    child: Text('${sales?.billingAddress ?? '-'}')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget headerView(bool isMobile, {SalesOrder? sales}) {
    if (sales == null) {
      return Container();
    }

    return CommonThemeContainer(
      title: 'Pick Order : ${sales.soNumber}',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;

          final ratio = isMobile ? 2 : 4;

          final difference = isMobile ? 40 : 80;

          final componentWidth = isMobile
              ? (width - difference) / ratio
              : (width - difference) / ratio;

          return Wrap(
            direction: Axis.horizontal,
            spacing: 20,
            runSpacing: 15,
            children: [
              PickOrderKeyValue(width: componentWidth,
                  title: 'Order Date :', value: '${sales.dateOfSoStr ?? '-'}'),
              PickOrderKeyValue(width: componentWidth,
                  title: 'Customer :', value: '${sales.customerName ?? '-'}'),
              PickOrderKeyValue(width: componentWidth,
                  title: 'Customer Location :',
                  value: '${sales.customerLocation ?? '-'}'),
              PickOrderKeyValue(width: componentWidth,
                  title: 'Account :', value: '${sales.accountNumber ?? '-'}'),
              PickOrderKeyValue(width: componentWidth,
                  title: 'Terms :', value: '${sales.soTerm ?? '-'}'),
              PickOrderKeyValue(width: componentWidth,
                  title: 'Ship Date :', value: '${sales.shipDateStr ?? '-'}'),
              PickOrderKeyValue(width: componentWidth,
                  title: 'Ship Via :', value: '${sales.shipperName ?? '-'}'),
              PickOrderKeyValue(width: componentWidth,
                  title: 'Carrier :', value: '${sales.carrierName ?? '-'}'),
              PickOrderKeyValue(width: componentWidth,
                  title: 'FOB :', value: 'Shipping Point'),
              PickOrderKeyValue(width: componentWidth,
                  title: 'Proto/PPAP :',
                  value: '${sales.isAttachedProtoPpapStr ?? '-'}'),
              PickOrderKeyValue(width: componentWidth,
                  title: 'Additional Quantity :',
                  value: '${sales.isAllowAdditionalQtyStr ?? '-'}'),
              PickOrderKeyValue(width: componentWidth,
                  title: 'Sales Note :', value: '${sales.soNotes ?? '-'}'),
            ],
          );
        },
      ),
    );
  }
}
