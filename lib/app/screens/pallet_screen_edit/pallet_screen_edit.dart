import 'package:demo_win_wms/app/screens/base_components/common_data_showing_component.dart';
import 'package:demo_win_wms/app/views/custom_popup_for_location_binding.dart';
import 'package:demo_win_wms/app/views/custom_popup_view.dart';
import 'package:flutter/material.dart';
import 'package:demo_win_wms/app/data/entity/res/res_get_pallet_list_data_by_id.dart';
import 'package:demo_win_wms/app/providers/pallet_provider.dart';
import 'package:demo_win_wms/app/screens/base_components/common_app_bar.dart';
import 'package:demo_win_wms/app/screens/base_components/common_theme_container.dart';
import 'package:demo_win_wms/app/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:demo_win_wms/app/utils/enums.dart';
import 'package:demo_win_wms/app/utils/responsive.dart';
import 'package:demo_win_wms/app/views/loading_small.dart';
import 'package:demo_win_wms/app/views/no_data_found.dart';

import '../../views/colored_bg_text.dart';

class PalletScreenEdit extends StatefulWidget {
  const PalletScreenEdit({Key? key}) : super(key: key);

  @override
  State<PalletScreenEdit> createState() => _PalletScreenEditState();
}

class _PalletScreenEditState extends State<PalletScreenEdit> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        hasLeading: true,
        isTitleSearch: true,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CommonThemeContainer(
                title: '',
                child: Stack(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        header(context),
                        const SizedBox(height: 15),
                        Flexible(
                          fit: FlexFit.loose,
                          child: Stack(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                      decoration: BoxDecoration(
                                          color: Colors.redAccent, borderRadius: BorderRadius.circular(2)),
                                      child: const Text(
                                        'Complete Pick Order',
                                        style:
                                            TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      completePart(context);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                      decoration: BoxDecoration(
                                          color: const Color(0xFF11BCCB), borderRadius: BorderRadius.circular(2)),
                                      child: const Text(
                                        'Complete part',
                                        style:
                                            TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              if (isLoading)
                                Center(
                                  child: LoadingSmall(
                                    color: Colors.blue,
                                  ),
                                )
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        partStatus(context),
                        const SizedBox(height: 15),
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              addPallet(context);
                            },
                            child: Container(
                              width: 120,
                              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                              decoration:
                                  BoxDecoration(color: const Color(0xFF11BCCB), borderRadius: BorderRadius.circular(2)),
                              child: Row(
                                children: [
                                  const Expanded(
                                      child: Text(
                                    'Add Pallet',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15),
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
                        const SizedBox(height: 15),
                        pallets(context)
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget partStatus(BuildContext context) {
    final pallet = context.read<PalletProviderImpl>();

    final pickOrder = pallet.lineItemRes?.data?.data?.pickOrderSoDetail;

    // final palletVar = pallet.palletsRes?.data?.data?.pickOrderPalletList?.first;

    return Container(
      padding: const EdgeInsets.only(left: 10),
      decoration: const BoxDecoration(
          color: Color(0xffc0edf1), border: Border(left: BorderSide(color: Color(0xff58d0da), width: 3))),
      child: Text(
        'Part Status: ${pickOrder?.currentPartStatusTerm ?? ''}',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
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
                  child: lineItem(context)),
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: kBorderColor),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: itemStock(context)),
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
                    child: lineItem(context)),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: kBorderColor),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: itemStock(context)),
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
      final pickOrderSoDetails = pallet.lineItemRes?.data?.data?.pickOrderSoDetail;

      if (pickOrder == null || pickOrderSoDetails == null) {
        return NoDataFoundView(
          retryCall: () {
            context.read<PalletProviderImpl>().pickOrderViewLineItem();
          },
        );
      }

      return LayoutBuilder(
        builder: (context, constraints) {
          final isTab = Responsive.isTablet(context);

          final width = (constraints.maxWidth - 50) / (isTab ? 3 : 2);

          return Wrap(
            runSpacing: 5,
            children: [
              CommonDataViewComponent(width: width, title: 'Order No', value: pickOrder.soNumber ?? '-'),
              const SizedBox(width: 10),
              CommonDataViewComponent(width: width, title: 'Box Qty', value: '${pickOrderSoDetails.boxQty ?? '-'}'),
              if (isTab) const SizedBox(width: 10),
              CommonDataViewComponent(width: width, title: 'Part Number', value: pickOrderSoDetails.itemName ?? '-'),
              const SizedBox(width: 10),
              CommonDataViewComponent(
                  width: width, title: 'Requested Qty', value: '${pickOrderSoDetails.requestedQty ?? '-'}'),
              if (isTab) const SizedBox(width: 10),
              CommonDataViewComponent(width: width, title: 'PO Number', value: pickOrderSoDetails.poNumber ?? '-'),
              const SizedBox(width: 10),
              CommonDataViewComponent(width: width, title: 'UOM', value: pickOrderSoDetails.uom ?? '-'),
            ],
          );
        },
      );
    }

    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: kDarkFontColor,
          ),
          padding: const EdgeInsets.all(10),
          child: const Text(
            'Line Item',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        const SizedBox(height: 6),
        table(),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget itemStock(BuildContext context) {
    final pallet = context.watch<PalletProviderImpl>();

    Widget header(String text) => Container(
          child: Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
            textAlign: TextAlign.center,
          ),
          color: kBorderColor,
          padding: const EdgeInsets.all(10),
        );
    Widget value(String text) => Container(
          child: Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
            textAlign: TextAlign.center,
          ),
          padding: const EdgeInsets.all(10),
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
      final pickOrderSoDetails = pallet.lineItemRes?.data?.data?.pickOrderSoDetail;
      final itemLocationList = pallet.lineItemRes?.data?.data?.itemLocationList;

      if (pickOrder == null || pickOrderSoDetails == null) {
        return NoDataFoundView(
          retryCall: () {
            context.read<PalletProviderImpl>().pickOrderViewLineItem();
          },
        );
      }

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7),
        child: Table(
          columnWidths: const {
            0: FlexColumnWidth(5),
            1: FlexColumnWidth(22),
            2: FlexColumnWidth(5),
            3: FlexColumnWidth(5),
            4: FlexColumnWidth(5),
            5: FlexColumnWidth(5),
          },
          border: TableBorder.all(color: kBorderColor),
          children: List.generate((itemLocationList?.length ?? 0) + 1, (index) {
            if (index == 0) {
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

            return TableRow(children: [
              value(data?.itemName ?? '-'),
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 2),
                child: Center(
                  child: Wrap(
                    runSpacing: 5.0,
                    spacing: 5.0,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
                        child: Text('${data?.locationName}'),
                      ),
                      // const SizedBox(width: 2),
                      ColoredBGText(text: '${data?.warehouseName}', color: const Color(0xffFF5555)),
                      ColoredBGText(text: '${data?.sectionName}', color: const Color(0xffB981FF)),
                      ColoredBGText(text: '${data?.companyName}', color: const Color(0xffB981FF)),
                    ],
                  ),
                ),
              ),
              value(data?.locationType ?? '-'),
              value(data?.monthName ?? '-'),
              value(data?.fullYear ?? '-'),
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
          padding: const EdgeInsets.all(10),
          child: const Text(
            'Suggested Location',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        const SizedBox(height: 6),
        table(),
        const SizedBox(height: 10),
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
      return const NoDataFoundView(
        title: 'No Pallets Found',
      );
    }

    final data = provider.palletsRes?.data?.data?.pickOrderPalletList;

    if (data == null) {
      return const NoDataFoundView(
        title: 'No Pallets Found',
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final res = data[index];

        return PalletEditList(
          pickOrder: res,
          pallets: res.child,
        );
      },
    );
  }

  completePart(BuildContext context) async {
    final pallet = context.read<PalletProviderImpl>();
    final itemId = pallet.lineItemRes?.data?.data?.pickOrderSoDetail?.itemID;
    final pickOrderId = pallet.lineItemRes?.data?.data?.pickOrder?.pickOrderID;
    final pickOrderSODetailID = pallet.lineItemRes?.data?.data?.pickOrderSoDetail?.pickOrderSODetailID;
    pallet.selectedItemID = itemId ?? 0;
    pallet.selectedPickOrderID = pickOrderId ?? 0;
    pallet.selectedPickOrderSODetailID = pickOrderSODetailID ?? 0;
    final int isCheckRequired = pallet.checkForCycleCountVar?.data?.data?.first.isCycleCountRequiredOrNot ?? 0;
    setState(() {
      isLoading = true;
    });
    await pallet.checkForCycleCounts();

    if (isCheckRequired == 0) {
      await pallet.getCompletePartStatus(cycleCount: true);
      setState(() {
        isLoading = false;
      });
      if (pallet.getCompletePartStatusVar?.data?.data?.objSaveUpdateResponseModel?.first.primaryKey == "0") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
                "${pallet.getCompletePartStatusVar?.data?.data?.objSaveUpdateResponseModel?.first.errorMessage}")));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text(
                "${pallet.getCompletePartStatusVar?.data?.data?.objSaveUpdateResponseModel?.first.errorMessage}")));
        pallet.getPallets(addPallet: false);
      }
    } else {
      setState(() {
        isLoading = false;
      });
      CustomPopup(context,
          title: 'Cycle Count Alert ',
          message: 'Please complete cycle count verification and then complete part number',
          primaryBtnTxt: 'Wrong Inventory',
          secondaryBtnTxt: 'Correct Inventory', primaryAction: () async {
        setState(() {
          isLoading = true;
        });
        pallet.getCompletePartStatus(cycleCount: true);
        if (pallet.getCompletePartStatusVar?.data?.data?.objSaveUpdateResponseModel?.first.primaryKey == "0") {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                  "${pallet.getCompletePartStatusVar?.data?.data?.objSaveUpdateResponseModel?.first.errorMessage}")));
        } else {
          setState(() {
            isLoading = true;
          });
          await pallet.getPallets(addPallet: false);
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                  "${pallet.getCompletePartStatusVar?.data?.data?.objSaveUpdateResponseModel?.first.errorMessage}")));
          pallet.getPallets(addPallet: false);
        }
      }, secondaryAction: () async {
        setState(() {
          isLoading = true;
        });
        await pallet.getCompletePartStatus(cycleCount: false);
        setState(() {
          isLoading = false;
        });
        if (pallet.getCompletePartStatusVar?.data?.data?.objSaveUpdateResponseModel?.first.primaryKey == "0") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                  "${pallet.getCompletePartStatusVar?.data?.data?.objSaveUpdateResponseModel?.first.errorMessage}")));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                  "${pallet.getCompletePartStatusVar?.data?.data?.objSaveUpdateResponseModel?.first.errorMessage}")));
          pallet.getPallets(addPallet: false);
        }
      });
    }
  }

  addPallet(BuildContext context) async {
    final pallet = context.read<PalletProviderImpl>();
    final itemId = pallet.lineItemRes?.data?.data?.pickOrderSoDetail?.itemID;
    final pickOrderId = pallet.lineItemRes?.data?.data?.pickOrder?.pickOrderID;
    final pickOrderSODetailID = pallet.lineItemRes?.data?.data?.pickOrderSoDetail?.pickOrderSODetailID;
    pallet.selectedItemID = itemId ?? 0;
    pallet.selectedPickOrderID = pickOrderId ?? 0;
    pallet.selectedPickOrderSODetailID = pickOrderSODetailID ?? 0;
    await pallet.getPallets(addPallet: true);

    if (pallet.palletsRes?.data?.data?.objSaveUpdateResponseModel?.first.primaryKey == "0") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text("${pallet.palletsRes?.data?.data?.objSaveUpdateResponseModel?.first.errorMessage}")));
    }
  }
}

class PalletEditList extends StatefulWidget {
  const PalletEditList({Key? key, required this.pickOrder, this.pallets}) : super(key: key);

  final PickOrderPalletList pickOrder;

  final List<PickOrderdetailList>? pallets;

  @override
  _PalletEditListState createState() => _PalletEditListState();
}

class _PalletEditListState extends State<PalletEditList> {
  bool isVisible = false;
  TextEditingController? locationTextController;
  TextEditingController? partTextController;
  bool isFocused = false;
  bool isFirstCompleted = false;
  FocusNode? _focusNode;
  bool generatePDF = false;
  bool showDeleteOption = false;
  bool showCompletePalletButtonBool = false;
  bool showCompletePalletButtonWithUpdate = false;
  bool bindLocationButton = false;
  bool showResetButton = false;
  bool showTxtFields = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    locationTextController = TextEditingController();
    partTextController = TextEditingController();
    _focusNode = FocusNode();
  }

  showGeneratePDF() {
    if (widget.pickOrder.statusTerm?.toUpperCase() == "COMPLETED" ||
        widget.pickOrder.statusTerm?.toUpperCase() == "VERIFIED") {
      setState(() {
        generatePDF = true;
      });
    }
  }

  showTextFields() {
    if (widget.pickOrder.statusTerm?.isNotEmpty == true &&
        (widget.pickOrder.currentPartStatusTerm?.toUpperCase() == "COMPLETED" ||
            widget.pickOrder.currentPartStatusTerm?.toUpperCase() == "VERIFIED" ||
            widget.pickOrder.currentPartStatusTerm?.toUpperCase() == "READY FOR DISPATCH" ||
            widget.pickOrder.currentPartStatusTerm?.toUpperCase() == "COMPLETED / SHORT" ||
            widget.pickOrder.currentPartStatusTerm?.toUpperCase() == "COMPLETED / OVER" ||
            widget.pickOrder.currentPartStatusTerm?.toUpperCase() == "COMPLETED / EXACT")) {
    } else {
      setState(() {
        showTxtFields = true;
      });
    }
  }

  showDeletePallet() {
    if (widget.pickOrder.isPartIsExistsOrNot == false) {
      setState(() {
        showDeleteOption = true;
      });
    }
  }

  Widget completePalletButton() {
    if (widget.pickOrder.statusTerm?.toUpperCase() != "COMPLETED" &&
        widget.pickOrder.statusTerm?.toUpperCase() != "VERIFIED") {
      if (widget.pickOrder.isPalletBindToLocationOrNot == false) {
        showCompletePalletButtonWithUpdate = true;
        // return InkWell(
        //   onTap: () {
        //     print("Complete Pallet with update");
        //   },
        //   child: Container(
        //     padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        //     decoration: BoxDecoration(color: kThemeBlueFontColor, borderRadius: BorderRadius.circular(2)),
        //     child: const Text(
        //       'Complete Pallet with update',
        //       style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15),
        //     ),
        //   ),
        // );
      } else {
        showCompletePalletButtonBool = true;
        // return InkWell(
        //   onTap: () {
        //     completePallet(context);
        //   },
        //   child: Container(
        //     padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        //     decoration: BoxDecoration(color: kThemeBlueFontColor, borderRadius: BorderRadius.circular(2)),
        //     child: const Text(
        //       'Complete Pallet',
        //       style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15),
        //     ),
        //   ),
        // );
      }
    }
    if (widget.pickOrder.statusTerm?.toUpperCase() != "VERIFIED" &&
        widget.pickOrder.statusTerm?.toUpperCase() == "COMPLETED" &&
        widget.pickOrder.isPalletBindToLocationOrNot == false) {
      bindLocationButton = true;
      // InkWell(
      //   onTap: () {
      //     print("Bind Pallet");
      //   },
      //   child: Container(
      //     padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      //     decoration: BoxDecoration(color: kThemeBlueFontColor, borderRadius: BorderRadius.circular(2)),
      //     child: const Text(
      //       'Bind Pallet',
      //       style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15),
      //     ),
      //   ),
      // );
    }

    if (widget.pickOrder.statusTerm?.toUpperCase() != "VERIFIED" &&
        widget.pickOrder.statusTerm?.toUpperCase() != "COMPLETED" &&
        widget.pickOrder.currentPartStatusTerm?.toUpperCase() != "READY FOR DISPATCH" &&
        widget.pickOrder.currentPartStatusTerm?.toUpperCase() != "COMPLETED / SHORT" &&
        widget.pickOrder.currentPartStatusTerm?.toUpperCase() != "COMPLETED / OVER" &&
        widget.pickOrder.currentPartStatusTerm?.toUpperCase() != "COMPLETED / EXACT") {
      showResetButton = true;
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    // print(provider.lineItemRes?.data?.data?.pickOrderSoDetail?.isTotePart == true);
    final width = MediaQuery.of(context).size.width;

    final fieldsWidth = width * 0.37;

    showGeneratePDF();
    showDeletePallet();
    completePalletButton();
    showTextFields();

    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: kBorderColor)),
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
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.pickOrder.palletNo ?? '',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                      generatePDF
                          ? TextButton(
                              onPressed: () {},
                              child: const Text(
                                "Generate PDF",
                                style: TextStyle(color: Colors.white),
                              ),
                              style: TextButton.styleFrom(backgroundColor: Colors.red))
                          : Container(),
                      showDeleteOption
                          ? TextButton(
                              onPressed: () {},
                              child: const Text(
                                "Delete Pallet",
                                style: TextStyle(color: Colors.white),
                              ),
                              style: TextButton.styleFrom(backgroundColor: Colors.red))
                          : Container(),
                      const SizedBox(
                        width: 10,
                      ),
                      Text('Pallet Status: ${widget.pickOrder.statusTerm ?? ''}',
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      SizedBox(
                          width: 44,
                          child: Icon(isVisible ? Icons.arrow_drop_down : Icons.arrow_right, color: Colors.white))
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
                            child: showTxtFields
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Scan Location',
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                            textAlign: TextAlign.start,
                                          ),
                                          const SizedBox(height: 10),
                                          SizedBox(
                                            width: fieldsWidth,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(5),
                                              child: Container(
                                                height: 50,
                                                decoration: BoxDecoration(
                                                    color: isFirstCompleted
                                                        ? Colors.grey.withOpacity(0.4)
                                                        : Colors.transparent,
                                                    borderRadius: BorderRadius.circular(5),
                                                    border: Border.all(color: kBorderColor)),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: TextField(
                                                        onEditingComplete: () {
                                                          setState(() {
                                                            //   isFirstCompleted = true;
                                                          });
                                                          checkScanLocation();
                                                        },
                                                        controller: locationTextController!,
                                                        autofocus: true,
                                                        enabled: !isFirstCompleted,
                                                        decoration: const InputDecoration(
                                                            contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                                            border: InputBorder.none),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          isFirstCompleted = false;
                                                        });
                                                      },
                                                      child: Container(
                                                        height: 50,
                                                        padding:
                                                            const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                                        color: kThemeBlueFontColor,
                                                        child: const Center(
                                                          child: Text(
                                                            'Change Location',
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.w500),
                                                          ),
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
                                          const Text(
                                            'Scan Part',
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                            textAlign: TextAlign.start,
                                          ),
                                          const SizedBox(height: 10),
                                          SizedBox(
                                            width: fieldsWidth,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(5),
                                              child: Container(
                                                height: 50,
                                                decoration: BoxDecoration(
                                                    color: isFirstCompleted
                                                        ? Colors.transparent
                                                        : Colors.grey.withOpacity(0.4),
                                                    borderRadius: BorderRadius.circular(5),
                                                    border: Border.all(color: kBorderColor)),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: TextField(
                                                        onEditingComplete: () {
                                                          getScanPartList();
                                                        },
                                                        focusNode: _focusNode,
                                                        enabled: isFirstCompleted,
                                                        controller: partTextController,
                                                        decoration: const InputDecoration(
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
                                  )
                                : Container(),
                          ),
                          table(pallets: widget.pallets),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                showCompletePalletButtonBool
                                    ? InkWell(
                                        onTap: () {},
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                          decoration: BoxDecoration(
                                              color: kThemeBlueFontColor, borderRadius: BorderRadius.circular(2)),
                                          child: const Text(
                                            'Complete Pallet',
                                            style: TextStyle(
                                                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15),
                                          ),
                                        ),
                                      )
                                    : Container(),
                                const SizedBox(width: 10),
                                showCompletePalletButtonWithUpdate
                                    ? InkWell(
                                        onTap: () {
                                          // updatePallet(context);
                                          completePallet(context);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                          decoration: BoxDecoration(
                                              color: kThemeBlueFontColor, borderRadius: BorderRadius.circular(2)),
                                          child: const Text(
                                            'Complete Pallet',
                                            style: TextStyle(
                                                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15),
                                          ),
                                        ))
                                    : Container(),
                                const SizedBox(width: 10),
                                showResetButton
                                    ? InkWell(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                          decoration: BoxDecoration(
                                              color: Colors.redAccent, borderRadius: BorderRadius.circular(2)),
                                          child: const Text(
                                            'Reset',
                                            style: TextStyle(
                                                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15),
                                          ),
                                        ),
                                      )
                                    : Container(),
                                const SizedBox(width: 10),
                                bindLocationButton
                                    ? InkWell(
                                        onTap: () {
                                          bindLocation(context);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                          decoration: BoxDecoration(
                                              color: kThemeBlueFontColor, borderRadius: BorderRadius.circular(2)),
                                          child: const Text(
                                            'Bind Location',
                                            style: TextStyle(
                                                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15),
                                          ),
                                        ),
                                      )
                                    : Container()
                              ],
                            ),
                          )
                        ],
                      ),
              ),
            ],
          ),
        ),
        if (isLoading)
          Center(
              child: LoadingSmall(
            color: kThemeBlueFontColor,
            size: 50,
          ))
      ],
    );
  }

  void getScanPartList() async {
    final provider = context.read<PalletProviderImpl>();
    bool isOldQrCode = false;
    bool isValidQrPattern = false;
    bool oldQrIsValid = true;
    bool qRIsValid = false;
    var array1;
    var partNo;
    var array2;
    var boxQty;
    var array3;
    int noOfBoxes;
    var array4;
    var month;
    var array5;
    int year;
    var customCode;
    int qty;

    final txt = partTextController?.text ?? "";
    if (txt.contains('#')) {
      if (txt.contains('\$') &&
          txt.contains('#') &&
          txt.contains('#') &&
          !txt.contains('%') &&
          !txt.contains('&') &&
          !txt.contains('@@') &&
          "\$".allMatches(txt).length == 2 &&
          "#".allMatches(txt).length == 2) {
        isOldQrCode = true;
      } else {
        if (txt.contains("\$") &&
            txt.contains("#") &&
            txt.contains("%") &&
            txt.contains("&") &&
            txt.contains("@@") &&
            "&".allMatches(txt).length == 2 &&
            "#".allMatches(txt).length == 2 &&
            "%".allMatches(txt).length == 2 &&
            "@".allMatches(txt).length == 2 &&
            "\$".allMatches(txt).length == 2) {
          isValidQrPattern = true;
        }
      }
    } else {
      if (txt.contains("\$") &&
          !txt.contains("%") &&
          !txt.contains("&") &&
          !txt.contains("@@") &&
          "\$".allMatches(txt).length == 2) {
        isOldQrCode = true;
      } else {
        if (txt.contains("\$") &&
            txt.contains("%") &&
            txt.contains("&") &&
            txt.contains("@@") &&
            "&".allMatches(txt).length == 2 &&
            "%".allMatches(txt).length == 2 &&
            "@".allMatches(txt).length == 2 &&
            "\$".allMatches(txt).length == 2) {
          isValidQrPattern = true;
        }
      }
    }

    if (isValidQrPattern || isOldQrCode) {
      if (txt.contains('##')) {
        if (!isValidQrPattern && isOldQrCode) {
          array1 = txt.split('\$\$');
          partNo = array1[0].trim();
          array2 = array1[1].split('##');
          boxQty = array2[0].trim();
          noOfBoxes = array2[1].trim();
          month = "99999999";
          year = int.parse("99999999");
          customCode = "zzzzzzzz";
          qty = (int.parse(boxQty) * noOfBoxes);
        } else {
          array1 = txt.split('\$\$');
          partNo = array1[0].trim();
          array2 = array1[1].split('##');
          boxQty = array2[0].trim();
          array3 = array2[1].split('%%');
          noOfBoxes = int.parse(array3[0].trim());
          array4 = array3[1].split('&&');
          month = array4[0].trim();
          array5 = array4[1].split('@@');
          year = array5[0].trim();
          customCode = array5[1].trim();
          qty = (int.parse(boxQty) * noOfBoxes);
        }
        if (partNo != '' &&
            qty != '' &&
            qty > 0 &&
            month != '' &&
            year != '' &&
            customCode != '' &&
            boxQty != '' &&
            noOfBoxes != '' &&
            customCode.length >= 6 &&
            customCode.length <= 16 &&
            !array1[1].contains(''
                '\$')) {
          if (month == "99999999" && year == "99999999") {
            oldQrIsValid = true;
          } else {
            if (checkMonthNameIsValidOrNot(month) && year >= 21 && year <= 25) {
              qRIsValid = true;
            }
          }
        }
      } else {
        if (!isValidQrPattern && isOldQrCode) {
          array1 = txt.split('\$\$');
          partNo = array1[0].trim();
          qty = array1[1].trim();
          boxQty = qty;
          month = "99999999";
          year = int.parse("99999999");
          customCode = "zzzzzzzz";
          noOfBoxes = int.parse("1");
        } else {
          array1 = txt.split('\$\$');
          partNo = array1[0].trim();
          array2 = array1[1].split('%%');
          qty = int.parse(array2[0].trim());
          boxQty = qty;
          array3 = array2[1].split('&&');
          month = array3[0].trim();
          array4 = array3[1].split('@@');
          year = int.parse(array4[0].trim());
          customCode = array4[1].trim();
          noOfBoxes = int.parse("1");
        }
        if (partNo != '' &&
            qty != '' &&
            qty > 0 &&
            month != '' &&
            year != '' &&
            customCode != '' &&
            boxQty != '' &&
            noOfBoxes != '' &&
            customCode.length >= 6 &&
            customCode.length <= 16 &&
            !array1[1].contains('\$')) {
          if (month == "99999999" && year == "99999999") {
            oldQrIsValid = true;
          } else {
            if (checkMonthNameIsValidOrNot(month) && year >= 21 && year <= 25) {
              qRIsValid = true;
            }
          }
        }
      }
      if (qRIsValid || oldQrIsValid) {
        if (partNo != provider.lineItemRes?.data?.data?.pickOrderSoDetail?.itemName) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(backgroundColor: Colors.red, content: Text("Scanned incorrect Item For this Line Item")));
        } else {
          setState(() {
            isLoading = true;
          });
          await provider.getScanPartList(
              pickOrderId: provider.lineItemRes?.data?.data?.pickOrder?.pickOrderID ?? 0,
              palletNo: widget.pickOrder.palletNo ?? '',
              pickOrderSODetailID: provider.lineItemRes?.data?.data?.pickOrderSoDetail?.pickOrderSODetailID ?? 0,
              itemID: provider.lineItemRes?.data?.data?.pickOrderSoDetail?.itemID ?? 0,
              itemName: provider.lineItemRes?.data?.data?.pickOrderSoDetail?.itemName ?? "",
              requestedQty: provider.lineItemRes?.data?.data?.pickOrderSoDetail?.requestedQty ?? 0,
              actualPicked: qty,
              year: year,
              month: month,
              boxQty: boxQty,
              companyId: provider.lineItemRes?.data?.data?.pickOrderSoDetail?.companyID ?? 0,
              customCode: customCode,
              locationID: provider.locationData?.data?.data?.locationId ?? 0,
              locationTypeTerm: provider.locationData?.data?.data?.locationTypeTerm ?? "",
              numberOfBoxes: noOfBoxes,
              pONumber: provider.lineItemRes?.data?.data?.pickOrderSoDetail?.poNumber ?? "",
              pOPalletID: widget.pickOrder.poPalletId ?? 0,
              sODetailID: provider.lineItemRes?.data?.data?.pickOrderSoDetail?.sODetailID ?? 0,
              warehouseID: provider.locationData?.data?.data?.warehouseId ?? 0);
          if (provider.scanPartList?.state == Status.COMPLETED) {
            setState(() {
              isLoading = false;
            });
          } else {
            setState(() {
              isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(backgroundColor: Colors.red, content: Text("Something went wrong, please try again")));
          }
        }
      }
    }
  }

  void checkScanLocation() async {
    final provider = context.read<PalletProviderImpl>();
    if (locationTextController?.text != null && locationTextController?.text.replaceAll(" ", "") != "") {
      setState(() {
        isLoading = true;
      });
      await provider.getLocationData(
          locationTitle: locationTextController?.text ?? " ",
          isTotePart: provider.lineItemRes?.data?.data?.pickOrderSoDetail?.isTotePart == true);
      if (provider.locationData?.state == Status.COMPLETED) {
        setState(() {
          Future.delayed(const Duration(milliseconds: 10), () {
            FocusScope.of(context).requestFocus(_focusNode);
          });
          isLoading = false;
          isFirstCompleted = true;
        });
      } else if (provider.locationData?.state == Status.ERROR) {
        var txt = "Please scan valid location";
        isLoading = false;
        locationTextController?.text = "";
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              txt,
            )));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(backgroundColor: Colors.red, content: Text("Please Scan/Enter valid location")));
    }
  }

  Widget table({List<PickOrderdetailList>? pallets}) {
    Widget header(String text) => Container(
          child: Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
            textAlign: TextAlign.center,
          ),
          color: kBorderColor,
          padding: const EdgeInsets.all(10),
        );
    Widget value(String text) => Container(
          child: Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
            textAlign: TextAlign.center,
          ),
          padding: const EdgeInsets.all(10),
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
                value(pallet?.itemName ?? ''),
                value(pallet?.palletNo ?? ''),
                value(pallet?.locationTitle ?? ''),
                value(pallet?.monthName ?? ''),
                value(pallet?.year ?? ''),
                value('${pallet?.actualPicked ?? 0.0}'),
                value('${pallet?.numberOfBoxes ?? 0}'),
              ],
            );
          })),
    );
  }

  bool checkMonthNameIsValidOrNot(monthName) {
    if (monthName.trim() != '') {
      if (monthName.toLowerCase() == 'jan' ||
          monthName.toLowerCase() == 'feb' ||
          monthName.toLowerCase() == 'mar' ||
          monthName.toLowerCase() == 'apr' ||
          monthName.toLowerCase() == 'may' ||
          monthName.toLowerCase() == 'jun' ||
          monthName.toLowerCase() == 'jul' ||
          monthName.toLowerCase() == 'aug' ||
          monthName.toLowerCase() == 'sep' ||
          monthName.toLowerCase() == 'oct' ||
          monthName.toLowerCase() == 'nov' ||
          monthName.toLowerCase() == 'dec') {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  completePallet(BuildContext context) async {
    final provider = context.read<PalletProviderImpl>();

    setState(() {
      isLoading = true;
    });
    provider.selectedPickOrderSODetailID =
        provider.lineItemRes?.data?.data?.pickOrderSoDetail?.pickOrderSODetailID ?? 0;
    provider.selectedPickOrderID = provider.lineItemRes?.data?.data?.pickOrder?.pickOrderID ?? 0;
    await provider.completePallet(
        pOPalletId: widget.pickOrder.poPalletId ?? 0,
        warehouseId: widget.pickOrder.warehouseID ?? 0,
        updateLog: widget.pickOrder.updatelog ?? '');
  }

  bindLocation(BuildContext context) async {
    final provider = context.read<PalletProviderImpl>();

    setState(() {
      isLoading = true;
    });
    provider.selectedPickOrderID = provider.lineItemRes?.data?.data?.pickOrder?.pickOrderID ?? 0;
    await provider.bindLocationToPallet(pOPalletID: widget.pickOrder.poPalletId ?? 0);
    setState(() {
      isLoading = false;
    });

    if (provider.bindLocation?.state == Status.ERROR) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(backgroundColor: Colors.red, content: Text("${provider.bindLocation?.msg}")));
    }

    if (provider.bindLocation?.state == Status.COMPLETED) {
      CustomPopUpForLocationBinding(context,
          list: provider.bindLocation?.data?.data?.bindLocationListData, primaryBtnTxt: 'Close');
    }
  }

// void updatePallet(BuildContext context) {}
}
