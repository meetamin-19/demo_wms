import 'package:demo_win_wms/app/data/data_service/web_service.dart';
import 'package:demo_win_wms/app/data/entity/res/res_container_link_location.dart';
import 'package:demo_win_wms/app/data/entity/res/res_get_container_list.dart';
import 'package:demo_win_wms/app/data/entity/res/res_get_container_list_filter.dart';
import 'package:demo_win_wms/app/data/entity/res/res_shipping_verification_list.dart';
import 'package:demo_win_wms/app/data/entity/res/res_shipping_verification_list_filter.dart';
import 'package:demo_win_wms/app/providers/auth_provider.dart';
import 'package:demo_win_wms/app/providers/container_list_provider.dart';
import 'package:demo_win_wms/app/providers/service_provider.dart';
import 'package:demo_win_wms/app/providers/shipping_verification_provider.dart';
import 'package:demo_win_wms/app/screens/base_components/common_app_bar.dart';
import 'package:demo_win_wms/app/screens/base_components/side_drawer.dart';
import 'package:demo_win_wms/app/screens/base_components/sidemenu_column.dart';
import 'package:demo_win_wms/app/screens/container_screen/components/container_dropdown_popup.dart';
import 'package:demo_win_wms/app/screens/container_screen/container_filter_dropdown.dart';
import 'package:demo_win_wms/app/screens/pick_order/components/pick_order_filter_button.dart';
import 'package:demo_win_wms/app/screens/pick_order/components/pick_order_link_user_dropdown.dart';
import 'package:demo_win_wms/app/screens/receiving_screen/receiving_screen.dart';
import 'package:demo_win_wms/app/utils/constants.dart';
import 'package:demo_win_wms/app/utils/enums.dart';
import 'package:demo_win_wms/app/utils/responsive.dart';
import 'package:demo_win_wms/app/views/custom_pop_up_with_dropdown.dart';
import 'package:demo_win_wms/app/views/custom_popup_view.dart';
import 'package:demo_win_wms/app/views/date_pick_view.dart';
import 'package:demo_win_wms/app/views/loading_small.dart';
import 'package:demo_win_wms/app/views/no_data_found.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/extension.dart';

class ContainerListScreen extends StatefulWidget {
  const ContainerListScreen({Key? key}) : super(key: key);

  @override
  State<ContainerListScreen> createState() => _ContainerListScreenState();
}

class _ContainerListScreenState extends State<ContainerListScreen> {
  bool isListLoaded = true;
  int pageLimit = 100;
  String? selectedRange = "100";
  String? selectedStartPoint = "0";
  int? selectedSortCol = 0;
  Warehouselist? selectedWarehouse;
  Warehouselist? selectedContainerStatus;
  Warehouselist? selectedReceivingType;
  DateTime? selectedStartDate;
  bool? loading = false;
  int? itemCount = 1;
  int startingIndex = 1;
  int selectedIndex = 1;
  int length = 20;
  int? totalCount;
  String selectedStatusValue = "Upcoming";
  String selectedReceivingValue = "Via Air";
  String? searchText = "";
  bool isScreenLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      // Add Your Code here.
      await fetchFilters();
      // _scrollController?.addListener(pagination);
      await fetchList();
    });
  }

  BoxDecoration unselectedBox = BoxDecoration(
      color: const Color(0xffE5E5E5).withOpacity(0.5), borderRadius: const BorderRadius.all(const Radius.circular(3)));

  BoxDecoration selectedBox =
      const BoxDecoration(color: Color(0xff7F849A), borderRadius: BorderRadius.all(Radius.circular(3)));

  filterData(BuildContext context, String str) {
    context.read<ContainerListProvider>().searchFromfilteredContainerList(str: str);
  }

  void getTotalCount() async {
    final home = context.read<ContainerListProvider>();

    try {
      setState(() {
        totalCount = home.getContainerList?.data?.data?.first.totalCount ?? 0;
        itemCount = (totalCount == null || totalCount == 0) ? 1 : (totalCount! / pageLimit).ceil();
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  fetchList() async {
    try {
      final list = context.read<ContainerListProvider>();
      await list.getContainerListData(
          numOfResults: pageLimit.toString(),
          startDate: selectedStartDate,
          containerStatus: selectedStatusValue == "Completed" ? "" : selectedStatusValue,
          receivingType: selectedReceivingValue == "All" ? "" : selectedReceivingValue,
          warehouse: selectedWarehouse,
          sortCol: selectedSortCol,
          listStartAt: selectedStartPoint);
      getTotalCount();
      filterData(context, searchText!);
    } on UnAuthorised {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Something went wrong')));
      final auth = context.read<AuthProviderImpl>();
      Navigator.of(context).popUntil((route) => route.isFirst);
      auth.unAuthorizeUser();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Something went wrong')));
    }
  }

  fetchFilters() async {
    try {
      final home = context.read<ServiceProviderImpl>();
      await home.getContainerListFilters();
    } on UnAuthorised catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      final auth = context.read<AuthProviderImpl>();
      Navigator.of(context).popUntil((route) => route.isFirst);
      auth.unAuthorizeUser();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    final home = context.read<ServiceProviderImpl>();
    final isLoading = home.getContainerListFilter?.state == Status.LOADING;

    return Scaffold(
      appBar: CommonAppBar(
        hasLeading: true,
      ),
      body: Scaffold(
        body: Stack(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SideMenuColumnWidget(context),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 20, top: 5),
                            child: Text(
                              "CONTAINER LIST",
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                            ),
                          )),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(top: 10, bottom: 20, left: 20, right: 20),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              // crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(padding: const EdgeInsets.only(top: 20), child: filters(context)),
                                if (!isLoading) pages(context),
                                const SizedBox(height: 10),
                                if (!isLoading) Expanded(child: dataTable(context)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
            if (!isListLoaded)
              Center(
                child: LoadingSmall(
                  color: Colors.blue,
                  size: 50,
                ),
              )
          ],
        ),
        drawerScrimColor: Colors.transparent,
        drawer: DrawerWidget(),
      ),
    );
  }

  Widget dataTable(BuildContext context) {
    final home = context.watch<ContainerListProvider>();
    final filters = context.watch<ServiceProviderImpl>();
    final filtersLoaded = filters.shippingverificationfilters?.state == Status.COMPLETED;
    final listloading = home.getContainerList?.state == Status.COMPLETED;

    if (filtersLoaded) {
      if (!listloading) {
        return Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            height: 50,
            color: Colors.white,
            child: Center(child: LoadingSmall()));
      } else {
        return Container(
            width: MediaQuery.of(context).size.width * 0.95,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), /*border: Border.all(color: Colors.black.withOpacity(0.1))*/
            ),
            child: table());
      }
    } else {
      return Container(
          width: MediaQuery.of(context).size.width * 0.95,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), /*border: Border.all(color: Colors.black.withOpacity(0.1))*/
          ),
          child: table());
    }
  }

  Widget table() {
    Widget headerWidget(String text) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          textAlign: TextAlign.center,
        ),
      );
    }

    final home = context.watch<ContainerListProvider>();
    final emptyList = home.getContainerList?.data?.data?.length;
    final hasError = home.getContainerList?.state == Status.ERROR;

    if (hasError) {
      return NoDataFoundView(
        retryCall: () {
          context.read<ContainerListProvider>().getContainerListData();
        },
      );
    }

    if (emptyList == 0) {
      return const NoDataFoundView(
        title: "No Data Found ",
      );
    }

    final list = home.filteredContainerListData;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            decoration:
                BoxDecoration(border: Border.all(style: BorderStyle.solid, color: Colors.black.withOpacity(0.1))),
            child: Table(
              // border: TableBorder.all(),
              columnWidths: const {
                0: FlexColumnWidth(10),
                1: FlexColumnWidth(5),
                2: FlexColumnWidth(4),
                3: FlexColumnWidth(5),
                4: FlexColumnWidth(5),
                5: FlexColumnWidth(5),
                6: FlexColumnWidth(5),
                7: FlexColumnWidth(5),
                8: FlexColumnWidth(5),
                9: FlexColumnWidth(5),
              },
              children: [
                TableRow(children: [
                  headerWidget('Action'),
                  headerWidget('Receiving Type'),
                  headerWidget('Container Code'),
                  headerWidget('Customer Name'),
                  headerWidget('Warehuse Name'),
                  headerWidget('ETA'),
                  headerWidget('Received Date'),
                  headerWidget('Completed Date'),
                  headerWidget('Status'),
                  headerWidget('Container Parts'),
                ])
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Table(
                columnWidths: const {
                  0: FlexColumnWidth(10),
                  1: FlexColumnWidth(5),
                  2: FlexColumnWidth(4),
                  3: FlexColumnWidth(5),
                  4: FlexColumnWidth(5),
                  5: FlexColumnWidth(5),
                  6: FlexColumnWidth(5),
                  7: FlexColumnWidth(5),
                  8: FlexColumnWidth(5),
                  9: FlexColumnWidth(5),
                },
                // border: TableBorder.all(color: kBorderColor),
                children: List.generate((list?.length ?? 0), (index) {
                  Color? colorForRow = Colors.white;

                  if (index % 2 == 0) {
                    colorForRow = const Color(0xffF9F9F9);
                  }

                  final data = list?[index];

                  return TableRow(decoration: BoxDecoration(color: colorForRow), children: [
                    Padding(
                      padding: EdgeInsets.only(left: 8),
                     child: SizedBox(
                      child: Wrap(
                        runSpacing: 3.0,
                        spacing: 3.0,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                // loading = true;
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ReceivingScreen(),
                              ));
                              // _openPDF(invoiceID: invoiceID, invoiceNo: invoiceNo, msg: "ASN");
                            },
                            child: Container(
                              width: kFlexibleSize(35),
                              height: kFlexibleSize(35),
                              padding: EdgeInsets.all(kFlexibleSize(10)),
                              decoration: BoxDecoration(color: const Color(0xff337AB7), borderRadius: BorderRadius.circular(2)),
                              child: kShippingEditIcon,
                            ),
                          ),
                          // selectedStatusValue == 'Transist'?
                          InkWell(
                            onTap: () async {

                              WarehouseLocationlist? selectedUser;
                              final home = context.read<ContainerListProvider>();
                              await home.getContainerLinkLocationList(id: data?.containerId ?? 0);
                              if (kDebugMode) {
                                print(home.linkLocationList?.data?.data?.container);
                              }
                              CustomPopUpWithDropDown(context, primaryBtnTxt: 'Save', secondaryBtnTxt: 'Cancel', primaryAction: () {
                                // if (selectedUser != null) {
                                //   linkOrder(data: home.filteredPickOrderList![index], assignToId: selectedUser!.value!);
                                // } else {
                                //   if (kDebugMode) {
                                //     print("selected User null");
                                //   }
                                // }
                              },
                                  title: 'Link Location',
                                  message: 'Select Location',
                                  dropdownWidget:
                                  ContainerLinkLocationDropDown(
                                    data: home.linkLocationList!.data!.data!.warehouseLocationlist!,
                                    onChange: (user) {
                                      setState(() {
                                        selectedUser = user;
                                        if (kDebugMode) {
                                          print(selectedUser?.value);
                                        }
                                      });
                                    },
                                    hint: 'Select Location',
                                  ));
                              //    : const Text("Something went wrong in getting user list"));
                            },
                            child: Container(
                              width: kFlexibleSize(35),
                              height: kFlexibleSize(35),
                              padding: EdgeInsets.all(kFlexibleSize(10)),
                              decoration: BoxDecoration(color: const Color(0xff36C6D3), borderRadius: BorderRadius.circular(2)),
                              child: kImgSend,
                            ),
                          ) ,
                          // : Container(),
                          InkWell(
                            onTap: () {
                              setState(() {
                                // loading = true;
                              });
                              // _openPDF(invoiceID: invoiceID, invoiceNo: invoiceNo, msg: "ASN");
                            },
                            child: Container(
                              width: kFlexibleSize(35),
                              height: kFlexibleSize(35),
                              padding: EdgeInsets.all(kFlexibleSize(10)),
                              decoration: BoxDecoration(color: const Color(0xff26C281), borderRadius: BorderRadius.circular(2)),
                              child: kImgAttach,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                // loading = true;
                              });
                              // _openPDF(invoiceID: invoiceID, invoiceNo: invoiceNo, msg: "ASN");
                            },
                            child: Container(
                              width: kFlexibleSize(35),
                              height: kFlexibleSize(35),
                              padding: EdgeInsets.all(kFlexibleSize(10)),
                              decoration: BoxDecoration(color: const Color(0xffED6B75), borderRadius: BorderRadius.circular(2)),
                              child: kImgPopupDeleteWhite,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              CustomPopup(context, title: 'Delete', message: 'Are you sure you want to delete ?', primaryBtnTxt: 'Yes',
                                  primaryAction: () async {

                                final home = context.read<ContainerListProvider>();
                                    await home.deleteEmptyContainer(containerId: data?.containerId, updatelog: data?.updatelog);

                                  }, secondaryBtnTxt: 'Close');
                            },
                            child: Container(
                              width: kFlexibleSize(35),
                              height: kFlexibleSize(35),
                              padding: EdgeInsets.all(kFlexibleSize(10)),
                              decoration: BoxDecoration(color: const Color(0xffE87E04), borderRadius: BorderRadius.circular(2)),
                              child: kImgPopupDeleteWhite,
                            ),
                          ),

                          // isBolAttachment == true
                          //     ? InkWell(
                          //     onTap: () {
                          //       setState(() {
                          //         loading = true;
                          //       });
                          //     //  _openBolAttachment(salesOrderID: salesOrderID);
                          //     },
                          //     child: Container(
                          //       padding: EdgeInsets.all(kFlexibleSize(10)),
                          //       decoration: BoxDecoration(color: Colors.blueAccent, borderRadius: BorderRadius.circular(2)),
                          //       child: SizedBox(
                          //         child: kShippingInvoiceIcon,
                          //         width: kFlexibleSize(20),
                          //       ),
                          //     ))
                          //     : const SizedBox()
                        ],
                      ),
                    ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8, bottom: 8),
                        child: childText('${data?.receivingTypeTerm} ', Colors.black),
                      ),
                    ),
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 3, right: 3, top: 8, bottom: 8),
                      child: childText('${data?.containerCode} ', Colors.black),
                    )),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 3, right: 3, top: 8, bottom: 8),
                        child: childText('${data?.containerName}', Colors.black),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 3, right: 3, top: 8, bottom: 8),
                        child: childText('${data?.warehouseName}', Colors.black),
                      ),
                    ),
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 3, right: 3, top: 8, bottom: 8),
                      child: childText('${data?.eta?.day}/${data?.eta?.month}/${data?.eta?.year}', Colors.black),
                    )),
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 3, right: 3, top: 8, bottom: 8),
                      child: childText(
                          '${data?.receivedDate?.day}/${data?.receivedDate?.month}/${data?.receivedDate?.year}',
                          Colors.black),
                    )),
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 3, right: 3, top: 8, bottom: 8),
                      child: childText(
                          '${data?.completedDate?.day}/${data?.completedDate?.month}/${data?.completedDate?.year}',
                          Colors.black),
                    )),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 3, right: 3, top: 8, bottom: 8),
                        child: childText('$selectedStatusValue', Colors.black),
                      ),
                    ),
                    Center(
                      child: containerPart('${data?.containerPartCount}', Colors.white),
                    ),
                  ]);
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget secondActionBTNs(
      {bool? isCreditMemoGen, int? containerId, String? invoiceNo, bool? isBolAttachment, int? salesOrderID,ResGetContainerListData? e}) {
    final home = context.watch<ContainerListProvider>();
    final isLoading = home.getContainerList?.state == Status.LOADING;
    final hasError = home.getContainerList?.state == Status.ERROR;
    // if (isLoading) {
    //   return Container(
    //       margin: const EdgeInsets.symmetric(vertical: 20),
    //       height: 50,
    //       color: Colors.white,
    //       child: Center(child: LoadingSmall()));
    // }
    //
    // if (hasError) {
    //   return NoDataFoundView(
    //     title: home.shippingVerificationList?.msg ?? '',
    //     retryCall: () async {
    //      // fetchFilters();
    //     },
    //   );
    // }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: SizedBox(
        child: Wrap(
          runSpacing: 3.0,
          spacing: 3.0,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  // loading = true;
                });
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ReceivingScreen(),
                ));
                // _openPDF(invoiceID: invoiceID, invoiceNo: invoiceNo, msg: "ASN");
              },
              child: Container(
                width: kFlexibleSize(35),
                height: kFlexibleSize(35),
                padding: EdgeInsets.all(kFlexibleSize(10)),
                decoration: BoxDecoration(color: const Color(0xff337AB7), borderRadius: BorderRadius.circular(2)),
                child: kShippingEditIcon,
              ),
            ),
            // selectedStatusValue == 'Transist'?
        InkWell(
              onTap: () async {

                WarehouseLocationlist? selectedUser;
                final home = context.read<ContainerListProvider>();
                await home.getContainerLinkLocationList(id: containerId ?? 0);
                if (kDebugMode) {
                  print(home.linkLocationList?.data?.data?.container);
                }
                CustomPopUpWithDropDown(context, primaryBtnTxt: 'Save', secondaryBtnTxt: 'Cancel', primaryAction: () {
                  // if (selectedUser != null) {
                  //   linkOrder(data: home.filteredPickOrderList![index], assignToId: selectedUser!.value!);
                  // } else {
                  //   if (kDebugMode) {
                  //     print("selected User null");
                  //   }
                  // }
                },
                    title: 'Link Location',
                    message: 'Select Location',
                    dropdownWidget:
                         ContainerLinkLocationDropDown(
                      data: home.linkLocationList!.data!.data!.warehouseLocationlist!,
                      onChange: (user) {
                        setState(() {
                          selectedUser = user;
                          if (kDebugMode) {
                            print(selectedUser?.value);
                          }
                        });
                      },
                      hint: 'Select Location',
                    ));
                   //    : const Text("Something went wrong in getting user list"));
              },
              child: Container(
                width: kFlexibleSize(35),
                height: kFlexibleSize(35),
                padding: EdgeInsets.all(kFlexibleSize(10)),
                decoration: BoxDecoration(color: const Color(0xff36C6D3), borderRadius: BorderRadius.circular(2)),
                child: kImgSend,
              ),
            ) ,
            // : Container(),
            InkWell(
              onTap: () {
                setState(() {
                  // loading = true;
                });
                // _openPDF(invoiceID: invoiceID, invoiceNo: invoiceNo, msg: "ASN");
              },
              child: Container(
                width: kFlexibleSize(35),
                height: kFlexibleSize(35),
                padding: EdgeInsets.all(kFlexibleSize(10)),
                decoration: BoxDecoration(color: const Color(0xff26C281), borderRadius: BorderRadius.circular(2)),
                child: kImgAttach,
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  // loading = true;
                });
                // _openPDF(invoiceID: invoiceID, invoiceNo: invoiceNo, msg: "ASN");
              },
              child: Container(
                width: kFlexibleSize(35),
                height: kFlexibleSize(35),
                padding: EdgeInsets.all(kFlexibleSize(10)),
                decoration: BoxDecoration(color: const Color(0xffED6B75), borderRadius: BorderRadius.circular(2)),
                child: kImgPopupDeleteWhite,
              ),
            ),
            InkWell(
              onTap: () {
                // CustomPopup(context, title: 'Delete', message: 'Are you sure you want to delete ?', primaryBtnTxt: 'Yes',
                //     primaryAction: () {
                //       if (home.filteredPickOrderList?[index] != null) {
                //         deletePickOrder(data: home.filteredPickOrderList![index]);
                //       }
                //     }, secondaryBtnTxt: 'Close');
              },
              child: Container(
                width: kFlexibleSize(35),
                height: kFlexibleSize(35),
                padding: EdgeInsets.all(kFlexibleSize(10)),
                decoration: BoxDecoration(color: const Color(0xffE87E04), borderRadius: BorderRadius.circular(2)),
                child: kImgPopupDeleteWhite,
              ),
            ),

            // isBolAttachment == true
            //     ? InkWell(
            //     onTap: () {
            //       setState(() {
            //         loading = true;
            //       });
            //     //  _openBolAttachment(salesOrderID: salesOrderID);
            //     },
            //     child: Container(
            //       padding: EdgeInsets.all(kFlexibleSize(10)),
            //       decoration: BoxDecoration(color: Colors.blueAccent, borderRadius: BorderRadius.circular(2)),
            //       child: SizedBox(
            //         child: kShippingInvoiceIcon,
            //         width: kFlexibleSize(20),
            //       ),
            //     ))
            //     : const SizedBox()
          ],
        ),
      ),
    );
  }

  Widget childText(String text, Color? col) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: col),
    );
  }

  Widget containerPart(String text, Color? col) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8, bottom: 8),
      child: Container(
        width: kFlexibleSize(25),
        height: kFlexibleSize(25),
        decoration: BoxDecoration(color: Color(0xff26C281), borderRadius: BorderRadius.circular(2)),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: col),
          ),
        ),
      ),
    );
  }

  Widget sonButton(
    ShippingVerificationListData e,
    // Widget Function(String text, Color? col) childText,
    bool? isAllPalletsVerifiedOrNot,
    bool? isInvoiceCreatedOrNot,
  ) {
    Color btnColor;
    if (isAllPalletsVerifiedOrNot == true) {
      btnColor = const Color(0xff26C281);
    } else if (isInvoiceCreatedOrNot == true) {
      btnColor = const Color(0xff8E44AD);
    } else {
      btnColor = Colors.white;
    }

    return Wrap(
      spacing: 5,
      runSpacing: 5,
      children: [
        InkWell(
            onTap: () {
              setState(() {
                loading = true;
              });
              //  _callPathToVerify(salesOrderID: e.salesOrderID!, pickOrderId: e.pickOrderId!);
            },
            child: Center(
                child: Container(
                    decoration: BoxDecoration(color: btnColor, borderRadius: BorderRadius.circular(2)),
                    padding: const EdgeInsets.all(5),
                    child: childText('${e.soNumber}', Colors.white)))),
        e.isAllPalletsVerifiedOrNot!
            ? InkWell(
                onTap: () {
                  setState(() {
                    loading = true;
                  });
                  //   _callPathToVerify(salesOrderID: e.salesOrderID!, pickOrderId: e.pickOrderId!, msg: "Edit");
                },
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(2)),
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 15,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        childText('Edit', Colors.white),
                      ],
                    ),
                  ),
                ),
              )
            : Container()
      ],
    );
  }

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
            decoration: BoxDecoration(border: Border.all(color: const Color(0xffCACACA))),
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
                    fetchList();
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

                        if (index == 5 && startingIndex != itemCount! - 6) {
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
                                startingIndex = itemCount! - 6;
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
                      itemCount: itemCount! >= 7 ? 7 : itemCount,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (itemCount! < 7) {
                            startingIndex = 1;
                          } else {
                            if (startingIndex + 7 < itemCount!) {
                              startingIndex += 1;
                            } else {
                              if (itemCount! - 7 > 0) {
                                startingIndex = itemCount! - 6;
                              } else {
                                startingIndex = itemCount! - 7;
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
                            if (startingIndex + 8 < itemCount!) {
                              startingIndex += 3;
                            } else {
                              if (itemCount! - 6 > 0) {
                                startingIndex = itemCount! - 6;
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
        if (startingIndex + 7 <= itemCount!) {
          setState(() {
            startingIndex += 1;
          });
        }
      } else {
        if (startingIndex + 7 < itemCount!) {
          setState(() {
            startingIndex += 2;
          });
        } else {
          setState(() {
            startingIndex = itemCount! - 6;
          });
        }
      }
    } else {}
  }

  getPage() {
    selectedStartPoint = (pageLimit * (selectedIndex - 1)).toString();
    fetchList();
  }

  Widget filters(BuildContext context) {
    final service = context.watch<ServiceProviderImpl>();

    final isLoading = service.getContainerListFilter?.state == Status.LOADING;

    final hasError = service.getContainerListFilter?.state == Status.ERROR;

    if (isLoading) {
      return Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          height: 50,
          color: Colors.white,
          child: Center(child: LoadingSmall()));
    }

    if (hasError) {
      return NoDataFoundView(
        title: service.getContainerListFilter?.msg ?? '',
        retryCall: () async {
          fetchFilters();
        },
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Wrap(
          children: [
            ContainerFilterDropDown(
              width: 250,
              data: service.getContainerListFilter?.data?.data?.warehouselist,
              selectedValue: selectedWarehouse,
              hint: 'Warehouse',
              onChange: (warehouse) {
                selectedWarehouse = warehouse;
              },
              // icon: kImgCustomerIcon
            ),
            dropDownContainer(),
            dropDownReceiving(),
            DatePickView(
                showBorder: true,
                passedDate: selectedStartDate,
                title: selectedStartDate != null ? (selectedStartDate?.toStrCommonFormat() ?? '') : 'Ship Date',
                selectedDate: (date) {
                  setState(() {
                    selectedStartDate = date;
                  });
                }),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black.withOpacity(0.1)), borderRadius: BorderRadius.circular(2)),
              height: 44,
              width: kFlexibleSize(290),
              child: TextField(
                onChanged: (str) {
                  filterData(context, str);
                  searchText = str;
                },
                decoration: const InputDecoration(
                    hintText: "Search",
                    contentPadding: EdgeInsets.only(top: 2),
                    prefixIcon: Icon(Icons.search_sharp),
                    border: OutlineInputBorder(borderSide: BorderSide.none)),
              ),
            )
          ],
        )),
        Flex(
          direction: Responsive.isDesktop(context) ? Axis.horizontal : Axis.vertical,
          children: [
            PickOrderFilterButton(
              bgColor: kPrimaryColor,
              text: 'Apply',
              onTap: () {
                if (selectedWarehouse != null ||
                    selectedStatusValue != null ||
                    selectedReceivingValue != null ||
                    selectedStartDate != null) {
                  if (selectedStartDate != null) {
                    setState(() {
                      selectedStartPoint = "0";
                      // pageController?.jumpToPage(0);
                      fetchList();
                      return;
                    });
                  }
                  setState(() {
                    selectedStartPoint = "0";
                    // pageController?.jumpToPage(0);
                    fetchList();
                  });
                }
              },
            ),
            const SizedBox(
              width: 10,
              height: 10,
            ),
            PickOrderFilterButton(
              text: 'Clear',
              onTap: () {
                if (selectedWarehouse != null ||
                    selectedStatusValue != null ||
                    selectedReceivingValue != null ||
                    selectedStartDate != null) {
                  setState(() {
                    selectedWarehouse = null;
                    selectedStartDate = null;
                    selectedStartPoint = "0";
                    // pageController?.jumpToPage(0);
                    fetchList();
                  });
                }
              },
            ),
          ],
        )
      ],
    );
  }

  Container dropDownContainer() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black.withOpacity(0.1)),
          borderRadius: const BorderRadius.all(Radius.circular(2))),
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
      height: 44,
      width: kFlexibleSize(190),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: DropdownButton<String>(
                isExpanded: true,
                value: selectedStatusValue,
                elevation: 16,
                iconSize: 30,
                underline: const SizedBox(),
                onChanged: (String? newValue) {
                  setState(() {
                    if (selectedStatusValue != newValue) {
                      pageLimit = 100;
                      selectedStatusValue = newValue!;
                      selectedStartPoint = "0";
                      fetchList();
                    }
                    // dropdownValue = newValue!;
                  });
                },
                items: <String>['Upcoming', 'Transist', 'Receiving', 'InProgress', 'Completed']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList()),
          ),
        ],
      ),
    );
  }

  Container dropDownReceiving() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black.withOpacity(0.1)),
          borderRadius: const BorderRadius.all(Radius.circular(2))),
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
      height: 44,
      width: kFlexibleSize(190),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: DropdownButton<String>(
                isExpanded: true,
                value: selectedReceivingValue,
                elevation: 16,
                iconSize: 30,
                underline: const SizedBox(),
                onChanged: (String? newValue) {
                  setState(() {
                    if (selectedReceivingValue != newValue) {
                      pageLimit = 100;
                      selectedReceivingValue = newValue!;
                      selectedStartPoint = "0";
                      fetchList();
                    }
                    // dropdownValue = newValue!;
                  });
                },
                items: <String>[
                  'Via Air',
                  'Via Sea',
                  'All',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList()),
          ),
        ],
      ),
    );
  }

  // deletePickOrder({required ResGetContainerListData data}) async {
  //   setState(() {
  //     isScreenLoading = true;
  //   });
  //
  //   try {
  //     final home = context.read<ContainerListProvider>();
  //     await home.deleteEmptyContainer(data: data);
  //
  //     setState(() {
  //       isScreenLoading = false;
  //     });
  //   } catch (e) {
  //     setState(() {
  //       isScreenLoading = false;
  //     });
  //   }
  // }
}
