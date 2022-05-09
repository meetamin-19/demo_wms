import 'package:demo_win_wms/app/screens/base_components/common_data_showing_component.dart';
import 'package:demo_win_wms/app/views/custom_popup_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demo_win_wms/app/data/entity/res/res_get_pick_order_data_for_view.dart';
import 'package:demo_win_wms/app/providers/pallet_provider.dart';
import 'package:demo_win_wms/app/providers/pick_order_provider.dart';
import 'package:demo_win_wms/app/screens/base_components/common_app_bar.dart';
import 'package:demo_win_wms/app/screens/base_components/common_theme_container.dart';
import 'package:demo_win_wms/app/screens/pick_order/components/leading_text_field.dart';
import 'package:demo_win_wms/app/screens/pick_order_list/components/sales_order_list.dart';
import 'package:demo_win_wms/app/utils/constants.dart';
import 'package:demo_win_wms/app/utils/enums.dart';
import 'package:demo_win_wms/app/utils/responsive.dart';
import 'package:demo_win_wms/app/views/loading_small.dart';
import 'package:demo_win_wms/app/views/no_data_found.dart';

class PickOrderListScreen extends StatefulWidget {
  const PickOrderListScreen({Key? key}) : super(key: key);

  @override
  State<PickOrderListScreen> createState() => _PickOrderListScreenState();
}

class _PickOrderListScreenState extends State<PickOrderListScreen> {
  ScrollController controller = ScrollController();

  bool isLoading = false;

  getUserData(BuildContext context) {
    context.read<PickOrderProviderImpl>().getPickOrderData();
  }

  void getTotalCount() async {
    final home = context.read<PickOrderProviderImpl>();

    try {
      setState(() {
        totalCount = home.salesOrderList?.data?.data?.first.totalCount ?? 0;
        itemCount = (totalCount == null || totalCount == 0) ? 1 : (totalCount! / pageLimit).ceil();
      });
    } catch (e) {
      print(e);
    }
  }

  getSalesOrderData(BuildContext context) async{
    setState(() {
      isLoading = true;
    });
    await context.read<PickOrderProviderImpl>()
        .getSalesOrderList(startPoint: int.parse(selectedStartPoint ?? "0"), numOfData: pageLimit);
    filterData(context, searchText ?? "");
    getTotalCount();
    setState(() {
      isLoading = false;
    });
  }

  // deletePickOrderMethod(BuildContext context,{required int pikOrderID, required String updateLog}) {
  filterData(BuildContext context, String str) {
    context.read<PickOrderProviderImpl>().searchFromSalesOderList(str: str);
  }

  completePickOrder(BuildContext context) {
    final pickOrder = context.read<PickOrderProviderImpl>();
    final pickOrderId = pickOrder.getPickOrder?.data?.data?.pickOrder?.pickOrderId;

    pickOrder.pickOrderID = pickOrderId ?? 0;

    CustomPopup(context,
        message:
            "If you click on \"Yes\", all Parts of this Pick Order will also be completed. Are you sure you want to Complete Pick Order?",
        title: 'Complete Pick Order',
        primaryBtnTxt: "Yes",
        secondaryBtnTxt: "No", primaryAction: () async {
      await context.read<PickOrderProviderImpl>().completePickOrder();
      if (pickOrder.completePickOrderVar?.data?.data?.first.errorMessage?.toLowerCase() != "update successfully") {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(backgroundColor: Colors.red, content: Text("Something went wrong")));
      }
      if (pickOrder.completePickOrderVar?.state == Status.COMPLETED &&
          pickOrder.completePickOrderVar?.data?.data?.first.errorMessage?.toLowerCase() == "update successfully") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text("${pickOrder.completePickOrderVar?.data?.data?.first.errorMessage}")));
        print("Complete Pick order API successful");
        Navigator.popUntil(context, ModalRoute.withName(kPickOrderHomeRoute));
      }
    });
  }

  scroll() {
    // controller.animateTo(400, duration: Duration(milliseconds: 400),curve: Curves.easeIn);
  }

  // viewItem(int id, BuildContext context) {
  pickItem(int id, BuildContext context) {
    final pallet = context.read<PalletProviderImpl>();
    final pickOrder = context.read<PickOrderProviderImpl>();

    pallet.selectedPickOrderID = pickOrder.pickOrderID;
    pallet.selectedPickOrderSODetailID = id;

    pallet.pickOrderViewLineItem();
    pallet.getPallets(addPallet: false);

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

  int? totalCount;

  int itemCount = 1;

  int pageLimit = 100;

  String? searchText = "";

  int startingIndex = 1;

  int selectedIndex = 1;

  String? selectedRange = "100";

  String? selectedStartPoint = "0";

  BoxDecoration unselectedBox = BoxDecoration(
      color: const Color(0xffE5E5E5).withOpacity(0.5), borderRadius: const BorderRadius.all(const Radius.circular(3)));

  BoxDecoration selectedBox =
      const BoxDecoration(color: Color(0xff7F849A), borderRadius: BorderRadius.all(Radius.circular(3)));

  Widget pages(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text("Showing :", style: TextStyle(fontSize: 12)),
          const SizedBox(
            width: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            height: 30,
            decoration: BoxDecoration(border: Border.all(color: const Color(0xffCACACA)), color: Colors.white),
            child: DropdownButton(
                iconSize: 12,
                underline: const SizedBox(),
                value: pageLimit,
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
                ],
                onChanged: (int? val) {
                  setState(() {
                    pageLimit = val!;
                    getSalesOrderData(context);
                  });
                }),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                height: 30,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (startingIndex - 3 > 0) {
                            startingIndex = startingIndex - 3;
                          } else {
                            startingIndex = 1;
                          }
                        });
                        // _scrollController.jumpTo(2);
                      },
                      child: Container(
                        decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(3))),
                        height: 40,
                        width: 30,
                        child: Icon(
                          Icons.fast_rewind,
                          color: const Color(0xff263238).withOpacity(0.5),
                          size: 20,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          setState(() {
                            if (startingIndex - 1 > 0) {
                              startingIndex = startingIndex - 1;
                            } else {
                              startingIndex = 1;
                            }
                          });
                        });
                      },
                      child: Container(
                        decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(3))),
                        height: 40,
                        width: 30,
                        child: Icon(
                          Icons.arrow_left_outlined,
                          color: const Color(0xff263238).withOpacity(0.5),
                        ),
                      ),
                    ),
                    ListView.builder(
                      // controller: _scrollController,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, index) {
                        BoxDecoration box = selectedIndex == (startingIndex + index) ? selectedBox : unselectedBox;

                        if (index == 5 && startingIndex != itemCount - 6) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                            decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(2))),
                            child: const Center(
                              child: Text(
                                "...",
                                // textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        } else {
                          InkWell(
                            onTap: () {
                              setState(() {
                                selectedIndex = startingIndex + index;
                                getPage();
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 2),
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                              decoration: box,
                              child: const Center(
                                child: Text(
                                  "...",
                                  // textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          );
                        }

                        if (index == 6) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                startingIndex = itemCount - 6;
                                selectedIndex = startingIndex + index;
                                getPage();
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                              decoration: box,
                              // height: 40,
                              // width: 30,
                              child: Center(
                                child: Text(
                                  "$itemCount",
                                  // textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          );
                        }

                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedIndex = startingIndex + index;
                              getPage();
                              _setPageNumber(index);
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 2),
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                            decoration: box,
                            // height: 40,
                            // width: 30,
                            child: Center(
                              child: Text(
                                "${startingIndex + index}",
                                // textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: itemCount >= 7 ? 7 : itemCount,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (itemCount <= 7) {
                            startingIndex = 1;
                          } else {
                            if (startingIndex + 8 < itemCount) {
                              startingIndex += 1;
                            } else {
                              if (itemCount - 7 > 0) {
                                startingIndex = itemCount - 6;
                              } else {
                                startingIndex = itemCount - 7;
                              }
                            }
                          }
                        });
                      },
                      child: Container(
                        decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(3))),
                        child: Icon(
                          Icons.arrow_right_outlined,
                          color: const Color(0xff263238).withOpacity(0.5),
                        ),
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          setState(() {
                            if (startingIndex + 8 < itemCount) {
                              startingIndex += 3;
                            } else {
                              if (itemCount - 6 > 0) {
                                startingIndex = itemCount - 6;
                              } else {
                                startingIndex = 1;
                              }
                            }
                          });
                          // _scrollController.jumpTo(2);
                        },
                        child: Container(
                          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(3))),
                          child: Icon(
                            Icons.fast_forward,
                            color: const Color(0xff263238).withOpacity(0.5),
                            size: 20,
                          ),
                        )),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _setPageNumber(int index) {
    if (index == 0 || index == 1) {
      if (index == 0) {
        if (startingIndex - (index + 2) > 0) {
          setState(() {
            startingIndex -= index + 2;
          });
        } else {
          setState(() {
            startingIndex = 1;
          });
        }
      } else {
        if (startingIndex - (index) > 0) {
          setState(() {
            startingIndex -= index;
          });
        } else {
          setState(() {
            startingIndex = 1;
          });
        }
      }
    } else if (index == 3 || index == 4) {
      if (index == 3) {
        if (startingIndex + 7 <= itemCount) {
          setState(() {
            startingIndex += 1;
          });
        }
      } else {
        if (startingIndex + 7 < itemCount) {
          setState(() {
            startingIndex += 2;
          });
        } else {
          setState(() {
            startingIndex = itemCount - 6;
          });
        }
      }
    } else {}
  }

  getPage() {
    selectedStartPoint = (pageLimit * (selectedIndex - 1)).toString();
    getSalesOrderData(context);
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
            provider.isInEditingMode
                ? Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: Colors.red),
                        onPressed: () {
                          completePickOrder(context);
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            // Icon(Icons.check, color: Colors.white,size: 18 ,),
                            // kFlexibleSizedBox(width: 5),
                            Text(
                              "Complete Pick Order",
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ],
                        )),
                  )
                : Container(),
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
                      mainAxisSize: MainAxisSize.min,
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
                        Expanded(child: pages(context)),
                      ],
                    ),
                    kFlexibleSizedBox(height: 15),
                    !isLoading
                        ? SalesOrderListView(
                            list: salesList,
                            viewOnClick: (int id) {
                              // viewItem(id, context);
                            },
                            pickItemOnClick: (int id) {
                              pickItem(id, context);
                            },
                            isEditing: provider.isInEditingMode,
                          )
                        : LoadingSmall()
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
          ),
          const SizedBox(width: 20),
          Expanded(
            child: CommonDataViewComponent(
              width: width / 2.1,
              title: 'Billing Address :',
              value: sales?.billingAddress ?? '-',
              isHtml: true,
            ),
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
              CommonDataViewComponent(width: componentWidth, title: 'Order Date :', value: sales.dateOfSoStr ?? '-'),
              CommonDataViewComponent(width: componentWidth, title: 'Customer :', value: sales.customerName ?? '-'),
              CommonDataViewComponent(
                  width: componentWidth, title: 'Customer Location :', value: sales.customerLocation ?? '-'),
              CommonDataViewComponent(width: componentWidth, title: 'Account :', value: sales.accountNumber ?? '-'),
              CommonDataViewComponent(width: componentWidth, title: 'Terms :', value: sales.soTerm ?? '-'),
              CommonDataViewComponent(width: componentWidth, title: 'Ship Date :', value: sales.shipDateStr ?? '-'),
              CommonDataViewComponent(width: componentWidth, title: 'Ship Via :', value: sales.shipperName ?? '-'),
              CommonDataViewComponent(width: componentWidth, title: 'Carrier :', value: sales.carrierName ?? '-'),
              CommonDataViewComponent(width: componentWidth, title: 'FOB :', value: 'Shipping Point'),
              CommonDataViewComponent(
                  width: componentWidth, title: 'Proto/PPAP :', value: sales.isAttachedProtoPpapStr ?? '-'),
              CommonDataViewComponent(
                  width: componentWidth, title: 'Additional Quantity :', value: sales.isAllowAdditionalQtyStr ?? '-'),
              CommonDataViewComponent(width: componentWidth, title: 'Sales Note :', value: '${sales.soNotes ?? '-'}'),
            ],
          );
        },
      ),
    );
  }
}
