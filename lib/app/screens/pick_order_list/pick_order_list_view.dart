import 'package:demo_win_wms/app/screens/base_components/common_data_showing_component.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demo_win_wms/app/data/entity/res/res_get_pick_order_data_for_view.dart';
import 'package:demo_win_wms/app/providers/pallet_provider.dart';
import 'package:demo_win_wms/app/providers/pick_order_provider.dart';
import 'package:demo_win_wms/app/screens/base_components/common_app_bar.dart';
import 'package:demo_win_wms/app/screens/base_components/common_theme_container.dart';
import 'package:demo_win_wms/app/screens/pick_order/leading_text_field.dart';
import 'package:demo_win_wms/app/screens/pick_order_list/components/pick_order_list.dart';
import 'package:demo_win_wms/app/utils/constants.dart';
import 'package:demo_win_wms/app/utils/enums.dart';
import 'package:demo_win_wms/app/utils/responsive.dart';
import 'package:demo_win_wms/app/views/loading_small.dart';
import 'package:demo_win_wms/app/views/no_data_found.dart';

class PickOrderListScreen extends StatelessWidget {
  PickOrderListScreen({Key? key}) : super(key: key);

  ScrollController controller = ScrollController();

  getUserData(BuildContext context) {
    context.read<PickOrderProviderImpl>().getPickOrderData();
  }

  // deletePickOrderMethod(BuildContext context,{required int pikOrderID, required String updateLog}) {
  //   context.read()
  // }

  filterData(BuildContext context, String str) {
    context.read<PickOrderProviderImpl>().searchFromSalesOderList(str: str);
  }

  scroll() {
    // controller.animateTo(400, duration: Duration(milliseconds: 400),curve: Curves.easeIn);
  }

  viewItem(int id, BuildContext context) {
    final pallet = context.read<PalletProviderImpl>();
    final pickOrder = context.read<PickOrderProviderImpl>();
    pallet.selectedPickOrderID = pickOrder.pickOrderID;
    pallet.selectedPickOrderSODetailID = id;

    pallet.pickOrderViewLineItem();
    pallet.getPallets();

    Navigator.of(context).pushNamed(kPalletScreenEditRoute);
  }

  pickItem(int id, BuildContext context) {
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
      appBar: CommonAppBar(
        hasLeading: true,
        isTitleScan: true,
      ),
      body: body(context, provider, _size, isMobile),
    );
  }

  Widget body(context, PickOrderProviderImpl provider, Size _size, bool isMobile) {
    final isLoading = provider.getPickOrder?.state == Status.LOADING;

    if (isLoading) {
      return Container(
        color: Colors.black12,
        child: Center(
          child: Container(
              height: 50,
              width: 50,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
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
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          height: 30,
                          decoration: BoxDecoration(border: Border.all(color: const Color(0xffCACACA))),
                          child: DropdownButton(
                              iconSize: 12,
                              underline: const SizedBox(),
                              value: 10,
                              elevation: 4,
                              style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
                              items: const [
                                DropdownMenuItem(
                                  child: Text(
                                    "100 Rows",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  value: 100,
                                ),
                                DropdownMenuItem(
                                  child: Text("50 Rows", style: TextStyle(fontSize: 12)),
                                  value: 50,
                                ),
                                DropdownMenuItem(
                                  child: Text("25 Rows", style: TextStyle(fontSize: 12)),
                                  value: 25,
                                ),
                                DropdownMenuItem(
                                  child: Text("10 Rows", style: TextStyle(fontSize: 12)),
                                  value: 10,
                                )
                              ], onChanged: (int? value) {  },
                              ),
                        )
                      ],
                    ),
                    kFlexibleSizedBox(height: 15),
                    PickOrderList(
                      list: salesList,
                      viewOnClick: (int id) {
                        viewItem(id, context);
                      },
                      pickItemOnClick: (int id) {
                        pickItem(id, context);
                      },
                      isEditing: provider.isInEditingMode,
                    )
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
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;

      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: CommonDataViewComponent(
              width: width / 2.1,
              title: 'Shipping Address :',
              value: sales?.shippingOrToteAddress ?? '-',
              isHtml: true,
            ),
            // child: Column(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   crossAxisAlignment: CrossAxisAlignment.stretch,
            //   children: [
            //     Text('Shipping Address :'),
            //     SizedBox(height: 10),
            //     Container(
            //         padding: EdgeInsets.all(10),
            //         decoration: BoxDecoration(
            //             color: Colors.grey.withOpacity(0.1),
            //             borderRadius: BorderRadius.circular(5.0),
            //             border: Border.all(color: Colors.black.withOpacity(0.25))),
            //         child: Text('${sales?.shippingOrToteAddress ?? '-'}')),
            //   ],
            // ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: CommonDataViewComponent(
              width: width / 2.1,
              title: 'Billing Address :',
              value: sales?.billingAddress ?? '-',
              isHtml: true,
            ),
            // child: Column(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   crossAxisAlignment: CrossAxisAlignment.stretch,
            //   children: [
            //
            //     // Text('Billing Address :'),
            //     // SizedBox(height: 10),
            //     // Container(
            //     //     padding: EdgeInsets.all(10),
            //     //     decoration: BoxDecoration(
            //     //         color: Colors.grey.withOpacity(0.1),
            //     //         borderRadius: BorderRadius.circular(5.0),
            //     //         border: Border.all(
            //     //             color: Colors.black.withOpacity(0.25))),
            //     //     child: Text('${sales?.billingAddress ?? '-'}')),
            //   ],
            // ),
          ),
        ],
      );
    });
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

          final componentWidth = isMobile ? (width - difference) / ratio : (width - difference) / ratio;

          return Wrap(
            direction: Axis.horizontal,
            spacing: 20,
            runSpacing: 15,
            children: [
              CommonDataViewComponent(
                  width: componentWidth, title: 'Order Date :', value: '${sales.dateOfSoStr ?? '-'}'),
              CommonDataViewComponent(
                  width: componentWidth, title: 'Customer :', value: '${sales.customerName ?? '-'}'),
              CommonDataViewComponent(
                  width: componentWidth, title: 'Customer Location :', value: '${sales.customerLocation ?? '-'}'),
              CommonDataViewComponent(
                  width: componentWidth, title: 'Account :', value: '${sales.accountNumber ?? '-'}'),
              CommonDataViewComponent(width: componentWidth, title: 'Terms :', value: '${sales.soTerm ?? '-'}'),
              CommonDataViewComponent(
                  width: componentWidth, title: 'Ship Date :', value: '${sales.shipDateStr ?? '-'}'),
              CommonDataViewComponent(width: componentWidth, title: 'Ship Via :', value: '${sales.shipperName ?? '-'}'),
              CommonDataViewComponent(width: componentWidth, title: 'Carrier :', value: '${sales.carrierName ?? '-'}'),
              CommonDataViewComponent(width: componentWidth, title: 'FOB :', value: 'Shipping Point'),
              CommonDataViewComponent(
                  width: componentWidth, title: 'Proto/PPAP :', value: '${sales.isAttachedProtoPpapStr ?? '-'}'),
              CommonDataViewComponent(
                  width: componentWidth,
                  title: 'Additional Quantity :',
                  value: '${sales.isAllowAdditionalQtyStr ?? '-'}'),
              CommonDataViewComponent(width: componentWidth, title: 'Sales Note :', value: '${sales.soNotes ?? '-'}'),
            ],
          );
        },
      ),
    );
  }
}
