import 'package:demo_win_wms/app/screens/base_components/common_data_showing_component.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:provider/provider.dart';
import 'package:demo_win_wms/app/data/entity/res/res_shopping_verification_edit_screen.dart';
import 'package:demo_win_wms/app/providers/shipping_verification_provider.dart';
import 'package:demo_win_wms/app/screens/base_components/common_app_bar.dart';
import 'package:demo_win_wms/app/utils/constants.dart';
import 'package:demo_win_wms/app/utils/enums.dart';
import 'package:demo_win_wms/app/views/colored_bg_text.dart';
import 'package:demo_win_wms/app/views/custom_popup_with_three_fields.dart';
import 'package:demo_win_wms/app/views/loading_small.dart';

import '../../utils/extension.dart';

class ShippingVerifyEditScreen extends StatefulWidget {
  const ShippingVerifyEditScreen({Key? key}) : super(key: key);

  @override
  State<ShippingVerifyEditScreen> createState() => _ShippingVerifyEditScreenState();
}

class _ShippingVerifyEditScreenState extends State<ShippingVerifyEditScreen> {
  bool? isContainerVisible = false;
  PlatformFile? file;
  FilePickerResult? result;
  ResShoppingVerificationEditScreen? data;
  TextEditingController? _scanLocationController;
  TextEditingController? _scanPartController;
  TextEditingController? _bolNumberController;
  FocusNode? _focusNode;
  FocusNode? _focusNode1;
  bool? firstCompleted;
  bool? secondCompleted;
  bool? secondDisabled;
  FocusNode? _focusNode2;
  bool showSubmitButton = false;
  bool enableBolNumberField = false;
  String? message;

  bool loading = false;

  @override
  void initState() {
    super.initState();
    final home = context.read<ShippingVerificationProvider>();
    data = home.editScreen?.data;
    _focusNode = FocusNode();
    _focusNode?.requestFocus();
    _focusNode1 = FocusNode();
    _scanLocationController = TextEditingController();
    _scanPartController = TextEditingController();
    _bolNumberController = TextEditingController();
    _bolNumberController?.text = "${data?.data?.salesOrder?.bolNumber}";
    _focusNode2 = FocusNode();
    firstCompleted = false;
    secondCompleted = false;
    secondDisabled = true;
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode?.dispose();
    _focusNode1?.dispose();
    _focusNode2?.dispose();
    _scanLocationController?.dispose();
    _scanPartController?.dispose();
    _bolNumberController?.dispose();
  }

  Widget childText(String text, Color col) {
    return ConstrainedBox(
      child: Center(
          child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: col),
      )),
      constraints: BoxConstraints(minHeight: kFlexibleSize(50)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final home = context.read<ShippingVerificationProvider>();
    final list = home.editScreen?.data?.data?.pickOrderPalletList;
    message = (ModalRoute.of(context)?.settings.arguments ?? "") as String?;
    return Scaffold(
      appBar: CommonAppBar(hasLeading: true),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                    padding: EdgeInsets.only(left: 5, top: 5, bottom: 10),
                    child: Text("VERIFY ORDER", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700))),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(2)),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          LayoutBuilder(
                            builder: (context, constraints) {
                              final width = constraints.maxWidth;
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.only(topRight: Radius.circular(5), topLeft: Radius.circular(5)),
                                      color: Color(0xff5E6672),
                                    ),
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Icon(
                                            Icons.arrow_back_outlined,
                                            size: 24,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                            child: InkWell(
                                          onTap: () {
                                            toggleContainerVisibility();
                                          },
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                "Order Details",
                                                style: TextStyle(color: Colors.white, fontSize: 20),
                                              ),
                                              isContainerVisible == true
                                                  ? const Icon(
                                                      Icons.arrow_drop_up_sharp,
                                                      color: Colors.white,
                                                    )
                                                  : const Icon(Icons.arrow_drop_down_sharp, color: Colors.white),
                                            ],
                                          ),
                                        )),
                                      ],
                                    ),
                                  ),
                                  isContainerVisible!
                                      ? Container(
                                          margin: const EdgeInsets.all(20),
                                          width: width,
                                          child: Wrap(
                                            spacing: 10.0,
                                            runSpacing: 10.0,
                                            direction: Axis.horizontal,
                                            children: [
                                              CommonDataViewComponent(
                                                  width: width / 4.2,
                                                  title: 'Order Date :',
                                                  value: '${data?.data?.salesOrder?.dateOfSoStr}'),
                                              CommonDataViewComponent(
                                                  width: width / 4.2,
                                                  title: 'SO Number :',
                                                  value: '${data?.data?.salesOrder?.soNumber}'),
                                              CommonDataViewComponent(
                                                  width: width / 4.2,
                                                  title: 'Customer Name :',
                                                  value: '${data?.data?.salesOrder?.customerName}'),
                                              CommonDataViewComponent(
                                                  width: width / 4.2,
                                                  title: 'Account No :',
                                                  value: '${data?.data?.salesOrder?.accountNumber ?? ""}'),
                                              CommonDataViewComponent(
                                                  width: width / 4.2,
                                                  title: 'Ship Date :',
                                                  value: '${data?.data?.salesOrder?.shipDateStr}'),
                                              CommonDataViewComponent(
                                                  width: width / 4.2,
                                                  title: 'Ship Via :',
                                                  value: '${data?.data?.salesOrder?.shipperName}'),
                                              keyValueBoxForWidget(
                                                  width: width / 2.1,
                                                  key: 'Pallet Location :',
                                                  value: Wrap(
                                                    runSpacing: 5.0,
                                                    spacing: 5.0,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(vertical: 5),
                                                        child: Text(
                                                            '${data?.data?.pickOrderPalletList?.first.palletLocationStr}'),
                                                      ),
                                                      const SizedBox(width: 5),
                                                      ColoredBGText(
                                                          text: '${data?.data?.pickOrderPalletList?.first.warehouseName}',
                                                          color: const Color(0xffFF5555)),
                                                      ColoredBGText(
                                                          text: '${data?.data?.pickOrderPalletList?.first.sectionName}',
                                                          color: const Color(0xffB981FF)),
                                                      ColoredBGText(
                                                          text:
                                                              '${data?.data?.pickOrderPalletList?.first.companyName}',
                                                          color: const Color(0xffB981FF)),
                                                    ],
                                                  )),
                                              commonBoxWithHtml(
                                                  width: width / 2.1,
                                                  key: 'Billing Address :',
                                                  value: "${data?.data?.salesOrder?.billingAddress}"),
                                              commonBoxWithHtml(
                                                  width: width / 2.1,
                                                  key: 'Ship To Address :',
                                                  value:"${data?.data?.salesOrder?.shippingOrToteAddress}"),
                                            ],
                                          ),
                                        )
                                      : Container()
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Wrap(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Scan BOL Number',
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(height: 5),
                                    Container(
                                      width: 350,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          border: Border.all(color: kBorderColor),
                                          borderRadius: BorderRadius.circular(5)),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              color:
                                                  firstCompleted == true ? const Color(0xffeef1f5) : Colors.transparent,
                                              child: data?.data?.salesOrder?.isAllPalletsVerifiedOrNot == false
                                                  ? TextField(
                                                      enabled: firstCompleted == true ? false : true,
                                                      onEditingComplete: () {
                                                        setState(() {
                                                          Future.delayed(const Duration(milliseconds: 10), () {
                                                            FocusScope.of(context).requestFocus(_focusNode1);
                                                          });
                                                          firstCompleted = true;
                                                          secondDisabled = false;
                                                        });
                                                      },
                                                      focusNode: _focusNode,
                                                      style: const TextStyle(fontSize: 15),
                                                      decoration: const InputDecoration(
                                                          border: InputBorder.none,
                                                          hintText: 'Scan BOL Number',
                                                          contentPadding: EdgeInsets.only(left: 10, bottom: 10)),
                                                    )
                                                  : DisabledTextField(data?.data?.salesOrder?.bolNumber ?? "1234"),
                                            ),
                                          ),
                                          (data?.data?.salesOrder?.isAllPalletsVerifiedOrNot ?? false)
                                              ? InkWell(
                                                  child: message == "Edit"
                                                      ? Container(
                                                          child: const Center(
                                                              child: Text(
                                                            'Reset BOL Number',
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 16),
                                                          )),
                                                          color: const Color(0xff32C5D2),
                                                          height: double.infinity,
                                                          padding: const EdgeInsets.all(5),
                                                        )
                                                      : Container(),
                                                  onTap: () {
                                                    setState(() {
                                                      enableBolNumberField = true;
                                                    });
                                                  },
                                                )
                                              : Container()
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Scan Location',
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(height: 5),
                                    Container(
                                      width: 300,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          border: Border.all(color: kBorderColor),
                                          color: secondDisabled == true ? const Color(0xffeef1f5) : Colors.transparent,
                                          borderRadius: BorderRadius.circular(5)),
                                      child: TextField(
                                        enabled: secondDisabled == true ? false : true,
                                        focusNode: _focusNode1,
                                        controller: _scanLocationController,
                                        onEditingComplete: () {
                                          if (_scanLocationController?.text !=
                                              data?.data?.pickOrderPalletList?.first.palletLocation) {
                                            setState(() {
                                              _scanLocationController?.text = "";
                                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                content: Text("Incorrect Pallet Location"),
                                              ));
                                              return;
                                            });
                                          } else {
                                            setState(() {
                                              Future.delayed(const Duration(milliseconds: 10), () {
                                                FocusScope.of(context).requestFocus(_focusNode2);
                                                // print(FocusScope.of(context)
                                                //     .focusedChild
                                                //     .toString());
                                              });
                                              secondCompleted = true;
                                              if ((firstCompleted == true && secondCompleted == true) ||
                                                  firstCompleted == true) {
                                                secondDisabled = true;
                                              }
                                            });
                                          }
                                        },
                                        style: const TextStyle(fontSize: 15),
                                        decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Scan Location',
                                            contentPadding: EdgeInsets.only(left: 10, bottom: 10)),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Attachment',
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    attachmentContainer(context),
                                  ],
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(5), topLeft: Radius.circular(5)),
                              color: Color(0xff5E6672),
                            ),
                            child: const Text(
                              "Pallet Verification",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 10, right: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Scan Pallet',
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(height: 5),
                                    Container(
                                      width: 300,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          border: Border.all(color: kBorderColor),
                                          color: (secondDisabled == true && secondCompleted == true)
                                              ? Colors.transparent
                                              : const Color(0xffeef1f5),
                                          borderRadius: BorderRadius.circular(5)),
                                      child: TextField(
                                        enabled: (secondDisabled == true && secondCompleted == true) ? true : false,
                                        focusNode: _focusNode2,
                                        controller: _scanPartController,
                                        onEditingComplete: () {
                                          // print(data?.data?.pickOrderPalletList?.first
                                          //     .poPalletId);
                                          String? txt = _scanPartController?.text;
                                          if (txt != null
                                              ? txt.contains('${data?.data?.salesOrder?.soNumber}')
                                              : false) {
                                            txt = txt.replaceAll('${data?.data?.salesOrder?.soNumber}', "");
                                            if (txt == "") {
                                              _scanPartController?.text = "";
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(content: Text("Please Scan Valid Pallet")));
                                            } else {
                                              if (data?.data?.pickOrderPalletList
                                                      ?.any((element) => element.palletNo == txt) ==
                                                  true) {
                                                PickOrderPalletList? verifiedPallet = data?.data?.pickOrderPalletList
                                                    ?.firstWhere((element) => element.palletNo == txt);
                                                setState(() {
                                                  verifiedPallet?.isPalletVerified = true;
                                                  verifiedPallet?.timeOfVerification =
                                                      DateTime.now().toStrCommonFormat();
                                                  verifiedPallet?.statusTerm = "Verified";
                                                  verifiedPallet?.scanDateTimeStr = DateTime.now().toStrCommonFormat();
                                                  var ele = list
                                                      ?.where((element) => element.statusTerm == "Verified")
                                                      .toList();
                                                  list?.removeWhere((element) => element.statusTerm == "Verified");
                                                  list?.addAll(ele!.toList());
                                                });
                                              } else {
                                                _scanPartController?.text = "";
                                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                  content: Text("Please Scan Valid Pallet"),
                                                ));
                                              }
                                            }
                                            // print(txt);
                                          } else {
                                            _scanPartController?.text = "";
                                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                              content: Text("Please Scan Valid Pallet"),
                                            ));
                                          }
                                          // print(txt);
                                          // print(_scanPartController?.text);
                                          setState(() {
                                            _scanPartController?.text = "";
                                          });
                                        },
                                        style: const TextStyle(fontSize: 15),
                                        decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Scan Part',
                                            contentPadding: EdgeInsets.only(left: 10, bottom: 10)),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                if (list!.length < 10)
                                  {
                                    Expanded(
                                      child: dataTable(context, dataRow(list)),
                                    ),
                                  }.first
                                else
                                  Expanded(
                                    child: {
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(child: dataTable(context, dataRow1(list))),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(child: dataTable(context, dataRow2(list))),
                                        ],
                                      ),
                                    }.first,
                                  )
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          const SizedBox(
                            height: 20,
                          ),
                          buildSubmitSection()
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (loading)
            Center(
                child: LoadingSmall(
              color: kPrimaryColor,
            ))
        ],
      ),
    );
  }

  Widget attachmentContainer(BuildContext context) {
    final home = context.watch<ShippingVerificationProvider>();
    bool isPath = home.imagePath != "";
    return SizedBox(
      width: 300,
      height: 40,
      child: Wrap(
        children: [
          (message == "Edit" || data?.data?.salesOrder?.isAllPalletsVerifiedOrNot == false)
              ? TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(const Color(0xff32C5D2)),
                    overlayColor: MaterialStateProperty.all<Color>(Colors.white.withOpacity(0.3)),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  onPressed: () {
                    CustomPopupWith3Fields(context,
                        title: 'Hi There',
                        message: 'Choose how you want to upload photo',
                        primaryBtnTxt: 'close',
                        secondaryBtnTxt: 'Files',
                        thirdBtnTxt: 'Camera', thirdBtnAction: () {
                      Navigator.pushNamed(context, kCamera);
                    }, secondaryAction: _getPhotoFromGallery);
                  },
                  child: Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: (data?.data?.salesOrder?.attachment != null)
                          ? Text("${data?.data?.salesOrder?.attachmentStr}")
                          : const Icon(Icons.insert_drive_file_outlined)))
              : Container(),
          isPath
              ? Container(
                  margin: const EdgeInsets.only(left: 5),
                  height: 40,
                  width: 200,
                  color: Colors.white,
                  child: ListTile(
                    title: Text(
                      home.imageName ?? " No name found",
                      style: const TextStyle(fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: InkWell(
                      child: Icon(
                        Icons.cancel,
                        color: kPrimaryColor,
                      ),
                      onTap: () {
                        setState(() {
                          file = null;
                          home.removeCameraImagePath();
                        });
                      },
                    ),
                  ),
                )
              : Container(),
          (data?.data?.salesOrder?.attachmentStr != null && isPath == false)
              ? Container(
                  margin: const EdgeInsets.only(left: 5),
                  color: Colors.white,
                  child: Text(
                    "${data?.data?.salesOrder?.attachmentStr}",
                    style: TextStyle(fontSize: 12, color: kPrimaryColor, overflow: TextOverflow.ellipsis),
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  Container DisabledTextField(String? txt) {
    return Container(
      color: const Color(0xffeef1f5),
      child: TextField(
        controller: _bolNumberController,
        enabled: enableBolNumberField,
        style: const TextStyle(fontSize: 15),
        decoration:
            const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.only(left: 10, bottom: 10)),
      ),
    );
  }

  Widget buildSubmitSection() {
    var d = data?.data?.pickOrderPalletList?.map((e) => e.isPalletVerified).toList();
    showSubmitButton = (d?.contains(false) == false || message == "Edit");

    final submitData = context.watch<ShippingVerificationProvider>().submitUnverifiedDataGet;

    final isLoading = submitData?.state == Status.LOADING;

    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            showSubmitButton
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height: kFlexibleSize(40),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              loading = true;
                            });
                            _submitUnverifiedData();
                          },
                          child: isLoading
                              ? LoadingSmall(
                                  color: Colors.white,
                                )
                              : const Text(
                                  "SUBMIT",
                                  style: TextStyle(color: Colors.white),
                                ),
                          style: TextButton.styleFrom(backgroundColor: Colors.green),
                        )),
                  )
                : Container(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: kFlexibleSize(40),
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget dataTable(BuildContext context, List<DataRow> dataRowList) {
    Widget headerWidget(String text, {Widget? leading}) {
      return Expanded(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: leading,
              padding: const EdgeInsets.only(right: 2),
            ),
            Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.black.withOpacity(0.1))),
      child:
      DataTable(
          border: TableBorder.all(color: Colors.transparent),
          columnSpacing: 5,
          // showBottomBorder: false,
          headingRowHeight: 50,
          headingRowColor: MaterialStateProperty.all<Color>(Colors.grey.withOpacity(0.1)),
          columns: [
            DataColumn(label: headerWidget('Pallet')),
            DataColumn(
              label: headerWidget('Scan Status',
                  leading: const Icon(
                    Icons.check_circle_outline_outlined,
                    size: 20,
                  )),
            ),
            DataColumn(
              label: headerWidget('Scan Date-Time',
                  leading: const Icon(
                    Icons.date_range_sharp,
                    size: 20,
                  )),
            ),
            // DataColumn(label: headerWidget('Pallet Location')),
          ],
          rows: dataRowList),
    );
  }

  // Data Row for Single Table
  List<DataRow> dataRow(List<PickOrderPalletList>? list) {
    int len = list?.length ?? 0;
    Color? color ;
    // int lenByHalf = (len / 2).round();
    List<DataRow> d = [];
    for (int i = 0; i < len; i++) {
      color = Colors.white;

      if(i % 2 == 0) {
        color = const Color(0xffF9F9F9);
      }

      d.add(DataRow(
        color: MaterialStateProperty.all(color),
          cells: [
        DataCell(Center(
          child: SizedBox(
            width: kFlexibleSize(50),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
              child: TextButton(
                  style: TextButton.styleFrom(backgroundColor: const Color(0xff67809F)),
                  onPressed: () {},
                  child: childText('${data?.data?.pickOrderPalletList?[i].palletNo}', Colors.black)),
            ),
          ),
        )),
        data?.data?.pickOrderPalletList?[i].statusTerm == "Verified"
            ? DataCell(Center(
                child: SizedBox(
                  width: kFlexibleSize(100),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(2)), color: Color(0xff26C281)),
                    child: childText('verified', Colors.white),
                  ),
                ),
              ))
            : DataCell(Center(

              )),
        data?.data?.pickOrderPalletList?[i].statusTerm == "Verified"
            ? DataCell(
                childText('${(data?.data?.pickOrderPalletList?[i].scanDateTimeStr) ?? 'Right Now'} ', Colors.black))
            : DataCell(
                childText('${(data?.data?.pickOrderPalletList?[i].scanDateTimeStr) ?? 'Right Now'} ', Colors.white)),
      ]));
    }
    return d;
  }

  // DataRow for First Table of two tables
  List<DataRow> dataRow1(List<PickOrderPalletList>? list) {
    int len = list?.length ?? 0;
    int lenByHalf = (len / 2).round();
    Color? color;
    List<DataRow> d = [];
    for (int i = 0; i < (lenByHalf); i++) {
      color = Colors.white;
      if(i % 2 == 0) {
        color = Color(0xffF9F9F9);
      }
      d.add(DataRow(
          color: MaterialStateProperty.all(color),
          cells: [
        DataCell(Center(
          child: SizedBox(
            width: kFlexibleSize(50),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
              child: TextButton(
                  style: TextButton.styleFrom(backgroundColor: const Color(0xff67809F)),
                  onPressed: () {},
                  child: childText('${data?.data?.pickOrderPalletList?[i].palletNo}', Colors.black)),
            ),
          ),
        )),
        data?.data?.pickOrderPalletList?[i].statusTerm == "Verified"
            ? DataCell(Center(
                child: SizedBox(
                    width: kFlexibleSize(100),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(2)), color: Color(0xff26C281)),
                      child: childText('verified', Colors.white),
                    )),
              ))
            : DataCell(Center(

              )),
        data?.data?.pickOrderPalletList?[i].statusTerm == "Verified"
            ? DataCell(
                childText('${(data?.data?.pickOrderPalletList?[i].scanDateTimeStr) ?? 'Right Now'} ', Colors.black))
            : DataCell(
                childText('${(data?.data?.pickOrderPalletList?[i].scanDateTimeStr) ?? 'Right Now'} ', Colors.white)),
      ]));
    }
    return d;
  }

  // DataRow for second Table of two tables
  List<DataRow> dataRow2(List<PickOrderPalletList>? list) {
    int len = list?.length ?? 0;
    Color? color;
    int lenByHalf = (len / 2).round();
    List<DataRow> d = [];
    for (int i = lenByHalf; i < (list?.length ?? 0); i++) {

      if(i % 2 != 0){
        color = Colors.white;
      }
      else{
        color = Color(0xffF9F9F9);
      }
      d.add(DataRow(
          color: MaterialStateProperty.all(color),
          cells: [
        DataCell(Center(
          child: SizedBox(
            width: kFlexibleSize(50),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
              child: TextButton(
                  style: TextButton.styleFrom(backgroundColor: const Color(0xff67809F)),
                  onPressed: () {},
                  child: childText('${data?.data?.pickOrderPalletList?[i].palletNo}', Colors.black)),
            ),
          ),
        )),
        data?.data?.pickOrderPalletList?[i].statusTerm == "Verified"
            ? DataCell(Center(
                child: SizedBox(
                  width: kFlexibleSize(100),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(2)), color: Color(0xff26C281)),
                    child: childText('verified', Colors.white),
                  ),
                ),
              ))
            : DataCell(Center(
              )),
        data?.data?.pickOrderPalletList?[i].statusTerm == "Verified"
            ? DataCell(
                childText('${(data?.data?.pickOrderPalletList?[i].scanDateTimeStr) ?? 'Right Now'} ', Colors.black))
            : DataCell(
                childText('${(data?.data?.pickOrderPalletList?[i].scanDateTimeStr) ?? 'Right Now'} ', Colors.white)),
      ]));
    }
    return d;
  }

  // Function to get photo From gallery in windows
  Future<void> _getPhotoFromGallery() async {
    final home = context.read<ShippingVerificationProvider>();
    result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'jpeg', 'png'],
    );
    if (result != null) {
      setState(() {
        file = result?.files.first;
        home.setCameraImagePath(file?.path, file?.name);
      });
    }
  }


  Widget keyValueBox({required double width, required String key, required String value}) {
    return Container(
      width: (width - 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            key,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: Text(
              value,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.black.withOpacity(0.1))),
            width: double.infinity,
          )
        ],
      ),
    );
  }

  Widget commonBoxWithHtml({required double width, required String key, required String value}) {
    return SizedBox(
      width: (width - 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            key,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: HtmlWidget(value),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.black.withOpacity(0.1))),
            width: double.infinity,
          )
        ],
      ),
    );
  }

  Widget keyValueBoxForWidget({required double width, required String key, required Widget value}) {
    return Container(
      width: (width - 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            key,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: value,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.black.withOpacity(0.1))),
            width: double.infinity,
          )
        ],
      ),
    );
  }

  _submitUnverifiedData() async {
    final home = context.read<ShippingVerificationProvider>();
    if (message == "Edit") {
      await home.editVerifiedOrder(
        pickOrderID: data?.data?.salesOrder?.pickOrderId,
        salesOrderId: data?.data?.salesOrder?.salesOrderId,
        bolNumber: _bolNumberController?.text,
        filePath: home.imagePath ?? "",
      );
      final edited = home.editVerifiedOrderGet?.state == Status.COMPLETED;
      if (edited) {
        home.removeCameraImagePath();
        Navigator.pop(context);
      }
    } else {
      await home.submitUnVerifiedData(
        pickOrderID: data?.data?.salesOrder?.pickOrderId,
        salesOrderId: data?.data?.salesOrder?.salesOrderId,
        soNumber: data?.data?.salesOrder?.soNumber,
        bolNumber: data?.data?.salesOrder?.bolNumber,
        filePath: home.imagePath ?? "",
        list: data?.data?.pickOrderPalletList,
      );
    }
    final completed = home.submitUnverifiedDataGet?.state == Status.COMPLETED;
    if (completed) {
      Navigator.pop(context, true);
    }
    setState(() {
      loading = false;
    });
  }

  void toggleContainerVisibility() {
    setState(() {
      isContainerVisible = !isContainerVisible!;
    });
  }
}
