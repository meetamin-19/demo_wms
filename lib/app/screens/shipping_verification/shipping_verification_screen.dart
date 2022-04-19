import 'package:demo_win_wms/app/screens/base_components/sidemenu_column.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demo_win_wms/app/data/entity/res/res_shipping_verification_list.dart';
import 'package:demo_win_wms/app/providers/shipping_verification_provider.dart';
import 'package:demo_win_wms/app/screens/base_components/common_app_bar.dart';
import 'package:demo_win_wms/app/screens/shipping_verification/components/pdf_view_screen.dart';
import 'package:demo_win_wms/app/screens/shipping_verification/components/shipping_verification_filter_drop_down.dart';
import 'package:demo_win_wms/app/utils/constants.dart';
import '../../data/data_service/web_service.dart';
import '../../data/entity/res/res_shipping_verification_list_filter.dart';
import '../../providers/auth_provider.dart';
import '../../providers/service_provider.dart';
import '../../utils/enums.dart';
import '../../utils/responsive.dart';
import '../../views/date_pick_view.dart';
import '../../views/loading_small.dart';
import '../../views/no_data_found.dart';
import '../../utils/extension.dart';
import '../base_components/side_drawer.dart';
import '../pick_order/components/pick_order_filter_button.dart';

class ShippingVerificationScreen extends StatefulWidget {
  const ShippingVerificationScreen({Key? key}) : super(key: key);

  @override
  State<ShippingVerificationScreen> createState() =>
      _ShippingVerificationScreenState();
}

class _ShippingVerificationScreenState
    extends State<ShippingVerificationScreen> {
  int currentIndex = 0;
  int pageLimit = 100;
  String? selectedRange = "100";
  String? selectedStartPoint = "0";
  CarrierlistElement? selectedCustomer;
  CarrierlistElement? selectedCustomerLocation;
  CarrierlistElement? selectedShipVia;
  CarrierlistElement? selectedCarrier;
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  String dropdownValue = "Unverified";
  bool redirecting = false;
  ScrollController? _scrollController;
  bool isLoading = false;
  PageController? pageController;
  int? totalCount;
  int? itemCount = 1;
  bool? loading = false;
  String? searchText = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding?.instance?.addPostFrameCallback((_) async {
      // Add Your Code here.
      await fetchFilters();
      _scrollController = ScrollController();
      pageController = PageController();
      // _scrollController?.addListener(pagination);
      await fetchList();
    });
  }

  filterData(BuildContext context, String str) {
    context
        .read<ShippingVerificationProvider>()
        .searchFromShippingVerificationList(str: str);
  }

  void getTotalCount() async {
    final home = context.read<ShippingVerificationProvider>();
    final isListLoaded =
        home.shippingVerificationList?.state == Status.COMPLETED;

    try {
      setState(() {
        totalCount =
            home.shippingVerificationList?.data?.data?.first.totalCount ?? 0;
        itemCount = (totalCount == null || totalCount == 0)
            ? 1
            : (totalCount! / 100).ceil();
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    if (kDebugMode) {
      print('totalCount inside getTotalCount :$totalCount ');
    }
  }

  void nextPage() async {
    setState(() {
      isLoading = true;
      // page += 1;
      //add api for load the more data according to new page
    });

    // print("totalCount : - $totalCount");
    if (((currentIndex == 0 ? 1 : currentIndex) * pageLimit) < totalCount!) {
      selectedRange = (pageLimit).toString();
      selectedStartPoint = ((currentIndex) * pageLimit).toString();
      await fetchList();
    } else if (((currentIndex == 0 ? 1 : currentIndex) * pageLimit) >
        totalCount!) {
      if (totalCount! - ((currentIndex == 0 ? 1 : currentIndex) * pageLimit) >
          0) {
        selectedRange = (pageLimit).toString();
        selectedStartPoint = ((currentIndex) * pageLimit).toString();
        await fetchList();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("No more data to show")));
      }
    }

    setState(() {
      isLoading = false;
      // page += 1;
    });
  }

  previousPage() async {
    setState(() {
      isLoading = true;
    });
    print(currentIndex);

    if (currentIndex > 0) {
      selectedRange = (pageLimit).toString();
      selectedStartPoint = ((currentIndex - 1) * pageLimit).toString();
      await fetchList();
    }

    setState(() {
      isLoading = false;
    });
  }

  fetchFilters() async {
    try {
      final home = context.read<ServiceProviderImpl>();
      await home.getShippingVerificationFilters();
    } on UnAuthorised catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${e.toString()}')));
      final auth = context.read<AuthProviderImpl>();
      Navigator.of(context).popUntil((route) => route.isFirst);
      auth.unAuthorizeUser();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${e.toString()}')));
    }
  }

  fetchList() async {
    try {
      final list = context.read<ShippingVerificationProvider>();
      await list.getShippingVerificationList(
          customer: selectedCustomer,
          customerLocation: selectedCustomerLocation,
          carrierId: selectedCarrier,
          shipVia: selectedShipVia,
          endDate: selectedEndDate,
          startDate: selectedStartDate,
          statusTerm: dropdownValue == "All" ? "" : dropdownValue,
          listStartAt: selectedStartPoint,
          numOfResults: pageLimit.toString());
      getTotalCount();
      filterData(context, searchText!);
      final res = list.shippingVerificationList?.data?.data?.length;
    } on UnAuthorised catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Something went wrong')));
      final auth = context.read<AuthProviderImpl>();
      Navigator.of(context).popUntil((route) => route.isFirst);
      auth.unAuthorizeUser();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Something went wrong')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final home = context.read<ServiceProviderImpl>();
    final listProvider = context.read<ShippingVerificationProvider>();
    final isLoading = home.shippingverificationfilters?.state == Status.LOADING;
    final isListLoaded =
        listProvider.shippingVerificationList?.state == Status.COMPLETED;
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
                                "SHIPPING VERIFICATION",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w700),
                              ),
                            )),
                        // SizedBox(
                        // height: MediaQuery.of(context).size.height * .8,
                        // child:
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(
                                top: 10, bottom: 20, left: 20, right: 20),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                // crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: filters(context)),
                                  pages(context),
                                  const SizedBox(height: 10),
                                  if (!isLoading)
                                    Expanded(child: dataTable(context)),
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
              // if (!isListLoaded)
              //   Center(
              //     child: LoadingSmall(
              //       color: Colors.blue,
              //       size: 50,
              //     ),
              //   )
            ],
          ),
          drawerScrimColor: Colors.transparent,
          drawer: const DrawerWidget(),
        ));
  }

  Widget firstActionBTNs(ShippingVerificationListData e) {
    String? msg;
    if (e.isAllPalletsVerifiedOrNot == true) {
      msg = "Verified";
    } else if (e.isInvoiceIsCreatedOrNot == true) {
      msg = "Unverified";
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          msg == "Verified"
              ? InkWell(
                  onTap: () {
                    if (msg == "Verified") {
                      Navigator.of(context)
                          .pushNamed(KVerifyEditRoute)
                          .then((value) {
                        if (value == true) {
                          fetchList();
                        }
                      });
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(kFlexibleSize(10)),
                    decoration: BoxDecoration(
                        color: const Color(0xff26C281),
                        borderRadius: BorderRadius.circular(2)),
                    child: Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: kFlexibleSize(20),
                    ),
                  ),
                )
              : Container(
                  padding: EdgeInsets.all(kFlexibleSize(10)),
                  decoration: BoxDecoration(
                      color: const Color(0xff26C281),
                      borderRadius: BorderRadius.circular(2)),
                  child: Icon(
                    Icons.check_rounded,
                    color: Colors.white,
                    size: kFlexibleSize(20),
                  ),
                ),
          const SizedBox(
            width: 10,
            height: 10,
          ),
          msg == "Verified"
              ? InkWell(
                  onTap: () {
                    if (msg == "Verified") {
                      Navigator.of(context)
                          .pushNamed(KVerifyEditRoute)
                          .then((value) {
                        if (value == true) {
                          fetchList();
                        }
                      });
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(kFlexibleSize(10)),
                    decoration: BoxDecoration(
                        color: const Color(0xff337AB7),
                        borderRadius: BorderRadius.circular(2)),
                    child: SizedBox(
                      child: kShippingEditIcon,
                      width: kFlexibleSize(20),
                    ),
                  ),
                )
              : Container(
                  padding: EdgeInsets.all(kFlexibleSize(10)),
                  decoration: BoxDecoration(
                      color: const Color(0xff337AB7),
                      borderRadius: BorderRadius.circular(5)),
                  child: SizedBox(
                    child: kShippingEditIcon,
                    width: kFlexibleSize(20),
                  ),
                ),
        ],
      ),
    );
  }

  Widget secondActionBTNs(
      {bool? isCreditMemoGen,
      int? invoiceID,
      String? invoiceNo,
      bool? isBolAttachment,
      int? salesOrderID}) {
    final home = context.watch<ShippingVerificationProvider>();
    final isLoading = home.shippingVerificationList?.state == Status.LOADING;
    final hasError = home.shippingVerificationList?.state == Status.ERROR;
    if (isLoading) {
      return Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          height: 50,
          color: Colors.white,
          child: Center(child: LoadingSmall()));
    }

    if (hasError) {
      return NoDataFoundView(
        title: home.shippingVerificationList?.msg ?? '',
        retryCall: () async {
          fetchFilters();
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: SizedBox(
        child: Wrap(
          runSpacing: 3.0,
          spacing: 3.0,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  loading = true;
                });
                _openPDF(
                    invoiceID: invoiceID, invoiceNo: invoiceNo, msg: "ASN");
              },
              child: Container(
                padding: EdgeInsets.all(kFlexibleSize(10)),
                decoration: BoxDecoration(
                    color: const Color(0xff67809F),
                    borderRadius: BorderRadius.circular(2)),
                child: Icon(
                  Icons.remove_red_eye,
                  color: Colors.white,
                  size: kFlexibleSize(20),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  loading = true;
                });
                _openPDF(
                    invoiceID: invoiceID,
                    invoiceNo: invoiceNo,
                    msg: isCreditMemoGen! ? "CREDIT" : "INVOICE");
                // PdfView(controller: pdfController!,);
              },
              child: Container(
                padding: EdgeInsets.all(kFlexibleSize(10)),
                decoration: BoxDecoration(
                    color: isCreditMemoGen == null
                        ? null
                        : isCreditMemoGen
                            ? Colors.deepOrange
                            : Colors.blueAccent,
                    borderRadius: BorderRadius.circular(2)),
                child: SizedBox(
                  child: kShippingInvoiceIcon,
                  width: kFlexibleSize(20),
                ),
              ),
            ),
            isBolAttachment == true
                ? InkWell(
                    onTap: () {
                      setState(() {
                        loading = true;
                      });
                      _openBolAttachment(salesOrderID: salesOrderID);
                    },
                    child: Container(
                      padding: EdgeInsets.all(kFlexibleSize(10)),
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(2)),
                      child: SizedBox(
                        child: kShippingInvoiceIcon,
                        width: kFlexibleSize(20),
                      ),
                    ))
                : const SizedBox()
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

  Widget dataTable(BuildContext context) {
    final home = context.watch<ShippingVerificationProvider>();
    final filters = context.watch<ServiceProviderImpl>();
    final filtersLoaded =
        filters.shippingverificationfilters?.state == Status.COMPLETED;
    final listloading =
        home.shippingVerificationList?.state == Status.COMPLETED;

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
              borderRadius: BorderRadius.circular(
                  5), /*border: Border.all(color: Colors.black.withOpacity(0.1))*/
            ),
            child: table());
      }
    } else {
      return Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          height: 50,
          color: Colors.white,
          child: Center(child: LoadingSmall()));
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

    final home = context.watch<ShippingVerificationProvider>();
    final emptyList = home.shippingVerificationList?.data?.data?.length;
    final hasError = home.shippingVerificationList?.state == Status.ERROR;

    if (hasError) {
      return NoDataFoundView(
        retryCall: () {
          context
              .read<ShippingVerificationProvider>()
              .getShippingVerificationList();
        },
      );
    }

    if (emptyList == 0) {
      return const NoDataFoundView(
        title: "No Data Found ",
      );
    }

    final list = home.filteredShippingVerificationData;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
                border: Border.all(
                    style: BorderStyle.solid,
                    color: Colors.black.withOpacity(0.1))),
            child: Table(
              // border: TableBorder.all(),
              columnWidths: const {
                0: FlexColumnWidth(5),
                1: FlexColumnWidth(5),
                2: FlexColumnWidth(7),
                3: FlexColumnWidth(7),
                4: FlexColumnWidth(6),
                5: FlexColumnWidth(6),
              },
              children: [
                TableRow(children: [
                  headerWidget('Documents'),
                  headerWidget('SON'),
                  headerWidget('Customer'),
                  headerWidget('Customer Location'),
                  headerWidget('Ship Via (Carrier)'),
                  headerWidget('Ship Date'),
                ])
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Table(
                columnWidths: const {
                  0: FlexColumnWidth(5),
                  1: FlexColumnWidth(5),
                  2: FlexColumnWidth(7),
                  3: FlexColumnWidth(7),
                  4: FlexColumnWidth(6),
                  5: FlexColumnWidth(6),
                },
                // border: TableBorder.all(color: kBorderColor),
                children: List.generate((list?.length ?? 0), (index) {
                  Color? colorForRow = Colors.white;

                  if (index % 2 == 0) {
                    colorForRow = const Color(0xffF9F9F9);
                  }

                  final data = list?[index];

                  return TableRow(
                      decoration: BoxDecoration(color: colorForRow),
                      children: [
                        Center(
                          child: secondActionBTNs(
                              isCreditMemoGen: data?.isCreditMemoGenerated,
                              invoiceNo: data?.invoiceNo,
                              invoiceID: data?.invoiceId,
                              isBolAttachment:
                                  data?.isBolAttachmentUploadedOrNot,
                              salesOrderID: data?.salesOrderID),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: sonButton(
                                data!,
                                data.isAllPalletsVerifiedOrNot,
                                data.isInvoiceIsCreatedOrNot),
                          ),
                        ),
                        Center(
                            child: childText(
                                '${data.customerName} ', Colors.black)),
                        Center(
                          child: childText(
                              '${data.customerLocation}', Colors.black),
                        ),
                        Center(
                          child: childText(
                              '${data.shipperName} (${data.carrierName})',
                              Colors.black),
                        ),
                        Center(
                            child: childText(
                                '${data.shipDate?.day}/${data.shipDate?.month}/${data.shipDate?.year}',
                                Colors.black)),
                      ]);
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget table(Widget headerWidget(String text), List<ShippingVerificationListData>? list) {
  //
  //   return Column(
  //     children: [
  //
  //       Row(children:  [
  //         headerWidget('Documents'),
  //         headerWidget('SON'),
  //         headerWidget('Customer'),
  //         headerWidget('Customer Location'),
  //         headerWidget('Ship Via (Carrier)'),
  //         headerWidget('Ship Date'),
  //       ]),
  //
  //       Table(children: list!
  //           .map((e) => TableRow(children: [
  //         (firstActionBTNs(e)),
  //         (secondActionBTNs(
  //             isCreditMemoGen: e.isCreditMemoGenerated,
  //             invoiceNo: e.invoiceNo,
  //             invoiceID: e.invoiceId)),
  //         (Padding(
  //           padding: const EdgeInsets.symmetric(
  //               vertical: 8, horizontal: 5),
  //           child: SONButton(
  //               e,
  //               childText,
  //               e.isAllPalletsVerifiedOrNot,
  //               e.isInvoiceIsCreatedOrNot),
  //         )),
  //         (childText('${e.customerName} ', Colors.black)),
  //         (
  //             childText('${e.customerLocation}', Colors.black)),
  //         (childText(
  //             '${e.shipperName} (${e.carrierName})', Colors.black)),
  //         (childText('${e.shipDate}', Colors.black))
  //       ]))
  //           .toList(),),
  //     ],
  //   );
  //
  //   return DataTable(
  //         columns: [
  //           DataColumn(label: headerWidget('Action')),
  //           DataColumn(label: headerWidget('Documents')),
  //           DataColumn(label: headerWidget('SON')),
  //           DataColumn(label: headerWidget('Customer')),
  //           DataColumn(label: headerWidget('Customer Location')),
  //           DataColumn(label: headerWidget('Ship Via (Carrier)')),
  //           DataColumn(label: headerWidget('Ship Date')),
  //         ],
  //         rows: list!
  //             .map((e) => DataRow(cells: [
  //                   DataCell(firstActionBTNs(e)),
  //                   DataCell(secondActionBTNs(
  //                       isCreditMemoGen: e.isCreditMemoGenerated,
  //                       invoiceNo: e.invoiceNo,
  //                       invoiceID: e.invoiceId)),
  //                   DataCell(Padding(
  //                     padding: const EdgeInsets.symmetric(
  //                         vertical: 8, horizontal: 5),
  //                     child: SONButton(
  //                         e,
  //                         childText,
  //                         e.isAllPalletsVerifiedOrNot,
  //                         e.isInvoiceIsCreatedOrNot),
  //                   )),
  //                   DataCell(childText('${e.customerName} ', Colors.black)),
  //                   DataCell(
  //                       childText('${e.customerLocation}', Colors.black)),
  //                   DataCell(childText(
  //                       '${e.shipperName} (${e.carrierName})', Colors.black)),
  //                   DataCell(childText('${e.shipDate}', Colors.black))
  //                 ]))
  //             .toList(),
  //
  //       );
  // }

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
              _callPathToVerify(
                  salesOrderID: e.salesOrderID!, pickOrderId: e.pickOrderId!);
            },
            child: Center(
                child: Container(
                    decoration: BoxDecoration(
                        color: btnColor,
                        borderRadius: BorderRadius.circular(2)),
                    padding: const EdgeInsets.all(5),
                    child: childText('${e.soNumber}', Colors.white)))),
        e.isAllPalletsVerifiedOrNot!
            ? InkWell(
                onTap: () {
                  setState(() {
                    loading = true;
                  });
                  _callPathToVerify(
                      salesOrderID: e.salesOrderID!,
                      pickOrderId: e.pickOrderId!,
                      msg: "Edit");
                },
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(2)),
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

  Widget filters(BuildContext context) {
    final service = context.watch<ServiceProviderImpl>();

    final isLoading =
        service.shippingverificationfilters?.state == Status.LOADING;

    final hasError = service.shippingverificationfilters?.state == Status.ERROR;

    if (isLoading) {
      return Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          height: 50,
          color: Colors.white,
          child: Center(child: LoadingSmall()));
    }

    if (hasError) {
      return NoDataFoundView(
        title: service.shippingverificationfilters?.msg ?? '',
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
            if (service.shippingverificationfilters?.data?.data?.customerlist !=
                null)
              ShippingVerificationFilterDropDown(
                width: 250,
                data: service
                    .shippingverificationfilters!.data!.data!.customerlist!,
                selectedValue: selectedCustomer,
                hint: 'Customer',
                onChange: (customer) {
                  selectedCustomer = customer;
                },
                // icon: kImgCustomerIcon
              ),
            if (service.shippingverificationfilters?.data?.data
                    ?.customerlocationlist !=
                null)
              ShippingVerificationFilterDropDown(
                width: 300,
                data: service.shippingverificationfilters!.data!.data!
                    .customerlocationlist!,
                selectedValue: selectedCustomerLocation,
                hint: 'Customer Location',
                onChange: (location) {
                  selectedCustomerLocation = location;
                },
                // icon: kImgCustomerLocationIcon
              ),
            if (service.shippingverificationfilters?.data?.data?.shipvialist !=
                null)
              ShippingVerificationFilterDropDown(
                width: 200,
                data: service
                    .shippingverificationfilters!.data!.data!.shipvialist!,
                selectedValue: selectedShipVia,
                hint: 'Ship Via',
                onChange: (ship) {
                  selectedShipVia = ship;
                },
                // icon: kShippingEditIcon
              ),
            DatePickView(
                showBorder: true,
                passedDate: selectedStartDate,
                title: selectedStartDate != null
                    ? (selectedStartDate?.toStrCommonFormat() ?? '')
                    : 'Ship Date Start',
                selectedDate: (date) {
                  setState(() {
                    selectedStartDate = date;
                  });
                }),
            DatePickView(
                showBorder: true,
                passedDate: selectedEndDate,
                title: selectedEndDate != null
                    ? (selectedEndDate?.toStrCommonFormat() ?? '')
                    : 'Ship Date End',
                selectedDate: (date) {
                  setState(() {
                    selectedEndDate = date;
                  });
                }),
            dropDownContainer(),
            if (service.shippingverificationfilters?.data?.data?.carrierlist !=
                null)
              ShippingVerificationFilterDropDown(
                width: 190,
                data: service
                    .shippingverificationfilters!.data!.data!.carrierlist!,
                selectedValue: selectedCarrier,
                hint: 'Carrier ',
                onChange: (carrier) {
                  selectedCarrier = carrier;
                },
                // icon: kImgDateIcon
              ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black.withOpacity(0.1)),
                  borderRadius: BorderRadius.circular(2)),
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
          direction:
              Responsive.isDesktop(context) ? Axis.horizontal : Axis.vertical,
          children: [
            PickOrderFilterButton(
              bgColor: kPrimaryColor,
              text: 'Apply',
              onTap: () {
                if (selectedCustomer != null ||
                    selectedCarrier != null ||
                    selectedShipVia != null ||
                    selectedCustomerLocation != null ||
                    selectedStartDate != null ||
                    selectedEndDate != null) {
                  if (selectedStartDate != null && selectedEndDate != null) {
                    if (selectedStartDate!.isBefore(selectedEndDate!)) {
                      setState(() {
                        selectedStartPoint = "0";
                        // pageController?.jumpToPage(0);
                        fetchList();
                        return;
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please select valid date duration')));
                      return;
                    }
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
                if (selectedCustomer != null ||
                    selectedCarrier != null ||
                    selectedShipVia != null ||
                    selectedCustomerLocation != null ||
                    selectedStartDate != null ||
                    selectedEndDate != null) {
                  setState(() {
                    selectedCustomer = null;
                    selectedCustomerLocation = null;
                    selectedShipVia = null;
                    selectedCarrier = null;
                    selectedStartDate = null;
                    selectedEndDate = null;
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
    final home = context.read<ShippingVerificationProvider>();
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
                value: dropdownValue,
                elevation: 16,
                iconSize: 30,
                underline: const SizedBox(),
                onChanged: (String? newValue) {
                  setState(() {
                    if (dropdownValue != newValue) {
                      dropdownValue = newValue!;
                      selectedStartPoint = "0";

                      // pageController?.jumpToPage(0);
                      fetchList();
                    }
                    // dropdownValue = newValue!;
                  });
                },
                items: <String>['Unverified', 'Verified', 'All']
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

  _callPathToVerify({int? salesOrderID, int? pickOrderId, String? msg}) async {
    final home = context.read<ShippingVerificationProvider>();
    if (dropdownValue == "Unverified") {
      await home.checkForVerification(salesOrderID: salesOrderID);
    }
    final verificationVar = home.checkForVrf;
    if (verificationVar?.data?.data?.first.errorMessage
                ?.toUpperCase()
                .compareTo("USER CAN VERIFY THIS SALESORDER.") ==
            0 &&
        verificationVar?.data?.data?.first.primaryKey == "1") {
      await home.GetEditScreenData(
          salesOrderID: salesOrderID,
          PickOrderID: pickOrderId,
          i: dropdownValue == "Unverified" ? 0 : 1);
      if (home.editScreen?.state == Status.COMPLETED) {
        Navigator.pushNamed(context, KVerifyEditRoute, arguments: msg)
            .then((value) {
          if (value == true) {
            fetchList();
          }
        });
      }
    } else {
      await home.GetEditScreenData(
          salesOrderID: salesOrderID,
          PickOrderID: pickOrderId,
          i: dropdownValue == "Unverified" ? 0 : 1);
      if (home.editScreen?.state == Status.COMPLETED) {
        Navigator.pushNamed(context, KVerifyEditRoute, arguments: msg)
            .then((value) {
          if (value == true) {
            fetchList();
          }
        });
      }
    }
    setState(() {
      loading = false;
    });
  }

  _openPDF({String? invoiceNo, int? invoiceID, String? msg}) async {
    final home = context.read<ShippingVerificationProvider>();
    await home.getPdfPath(invoiceID: invoiceID, invoiceNo: invoiceNo, msg: msg);
    final path = home.getASN_PdfPath?.data?.data;

    print("http://wmsqa.softcube.in" + path!);

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            PdfViewScreen(path: "http://wmsqa.softcube.in" + path)));
    setState(() {
      loading = false;
    });
  }

  _openBolAttachment({int? salesOrderID}) async {
    final home = context.read<ShippingVerificationProvider>();
    await home.getBolPath(salesOrderID: salesOrderID);
    final path = home.getBolPDF?.data?.data;
    final message = home.getBolPDF?.data?.message;

    print(message);

      print("http://wmsqa.softcube.in" + path!);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            PdfViewScreen(path: "http://wmsqa.softcube.in" + path)));
    loading = false;
  }

  Widget pages(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text("Showing :", style: TextStyle(fontSize: 12)),
          const SizedBox(
            width: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            height: 30,
            decoration:
                BoxDecoration(border: Border.all(color: Color(0xffCACACA))),
            child: DropdownButton(
                iconSize: 12,
                underline: const SizedBox(),
                value: pageLimit,
                elevation: 4,
                style: const TextStyle(fontWeight: FontWeight.w600,color: Colors.black),

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
          )
          //
          // InkWell(
          //   onTap: () {
          //     previousPage();
          //     pageController?.jumpToPage(currentIndex - 1);
          //   },
          //   child: Container(
          //     width: 40,
          //     height: 40,
          //     color: kPrimaryColor,
          //     child: const Icon(Icons.chevron_left),
          //   ),
          // ),
          // SizedBox(
          //     width: 60,
          //     height: 40,
          //     // color: Colors.red,
          //     child: PageView.builder(
          //       scrollDirection: Axis.horizontal,
          //       controller: pageController,
          //       itemBuilder: (context, index) {
          //         return Container(
          //           decoration:
          //               BoxDecoration(border: Border.all(color: Colors.grey)),
          //           width: 50,
          //           child: Center(child: Text('${index + 1}')),
          //         );
          //       },
          //       onPageChanged: (ind) {
          //         currentIndex = ind;
          //       },
          //       itemCount: itemCount,
          //     )),
          // InkWell(
          //   onTap: () {
          //     pageController?.jumpToPage(currentIndex + 1);
          //     nextPage();
          //   },
          //   child: Container(
          //     width: 40,
          //     height: 40,
          //     color: kPrimaryColor,
          //     child: const Icon(Icons.chevron_right),
          //   ),
          // ),
        ],
      ),
    );
  }
}
