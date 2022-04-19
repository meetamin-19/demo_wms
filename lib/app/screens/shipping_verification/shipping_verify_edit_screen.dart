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
  State<ShippingVerifyEditScreen> createState() =>
      _ShippingVerifyEditScreenState();
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
            style: TextStyle(
                fontWeight: FontWeight.w400, fontSize: 14, color: col),
          )),
      constraints: BoxConstraints(minHeight: kFlexibleSize(50)),
    );
  }


  @override
  Widget build(BuildContext context) {
    final home = context.read<ShippingVerificationProvider>();
    final list = home.editScreen?.data?.data?.pickOrderPalletList;
    message = (ModalRoute
        .of(context)
        ?.settings
        .arguments ?? "") as String?;
    return Scaffold(
      appBar: CommonAppBar(
        // title: 'Verify Order',
        hasLeading: true,
        hasBackButton : true
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30,),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                    padding: EdgeInsets.only(left: 5, top: 5, bottom: 10),
                    child: Text("VERIFY ORDER", style: TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w700))),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        LayoutBuilder(
                          builder: (context, constraints) {
                            final width = constraints.maxWidth;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                InkWell(
                                  onTap: () {
                                    toggleContainerVisibility();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    height: 40,
                                    decoration: const BoxDecoration(
                                      color: Color(0xff5E6672),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        const Text("Order Details"),
                                        isContainerVisible == true ? const Icon(
                                            Icons.arrow_drop_up_sharp) : const Icon(
                                            Icons.arrow_drop_down_sharp),
                                      ],
                                    ),
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
                                      keyValueBox(
                                          width: width / 4.2,
                                          key: 'Order Date :',
                                          value:
                                          '${data?.data?.salesOrder
                                              ?.dateOfSoStr}'),
                                      keyValueBox(
                                          width: width / 4.2,
                                          key: 'SO Number :',
                                          value:
                                          '${data?.data?.salesOrder
                                              ?.soNumber}'),
                                      keyValueBox(
                                          width: width / 4.2,
                                          key: 'Customer Name :',
                                          value:
                                          '${data?.data?.salesOrder
                                              ?.customerName}'),
                                      keyValueBox(
                                          width: width / 4.2,
                                          key: 'Account No :',
                                          value:
                                          '${data?.data?.salesOrder
                                              ?.accountNumber ?? ""}'),
                                      keyValueBox(
                                          width: width / 4.2,
                                          key: 'Ship Date :',
                                          value:
                                          '${data?.data?.salesOrder
                                              ?.shipDateStr}'),
                                      keyValueBox(
                                          width: width / 4.2,
                                          key: 'Ship Via :',
                                          value:
                                          '${data?.data?.salesOrder
                                              ?.shipperName}'),
                                      keyValueBoxForWidget(
                                          width: width / 2.1,
                                          key: 'Pallet Location :',
                                          value: Wrap(
                                            runSpacing: 5.0,
                                            spacing: 5.0,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets
                                                    .symmetric(
                                                    vertical: 5),
                                                child: Text(
                                                    '${data?.data
                                                        ?.pickOrderPalletList
                                                        ?.first
                                                        .palletLocationStr}'),
                                              ),
                                              const SizedBox(width: 5),
                                              ColoredBGText(
                                                  text:
                                                  '${data?.data
                                                      ?.pickOrderPalletList
                                                      ?.first.warehouseName}',
                                                  color:
                                                  Color(0xffFF5555)),
                                              ColoredBGText(
                                                  text:
                                                  '${data?.data
                                                      ?.pickOrderPalletList
                                                      ?.first.sectionName}',
                                                  color:
                                                  Color(0xffB981FF)),
                                              ColoredBGText(
                                                  text:
                                                  'C :${data?.data
                                                      ?.pickOrderPalletList
                                                      ?.first.companyName}',
                                                  color:
                                                  Color(0xffB981FF)),
                                            ],
                                          )),
                                      keyValueBoxWithHtml(
                                          width: width / 2.1,
                                          key: 'Billing Address :',
                                          value: HtmlWidget(
                                              "${data?.data?.salesOrder
                                                  ?.billingAddress}")),
                                      keyValueBoxWithHtml(
                                          width: width / 2.1,
                                          key: 'Ship To Address :',
                                          value: HtmlWidget(
                                              "${data?.data?.salesOrder
                                                  ?.shippingOrToteAddress}")),
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
                                  Text(
                                    'Scan BOL Number',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(height: 5),
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
                                            color: firstCompleted == true
                                                ? Color(0xffeef1f5)
                                                : Colors.transparent,
                                            child: data?.data?.salesOrder
                                                ?.isAllPalletsVerifiedOrNot ==
                                                false
                                                ? TextField(
                                              enabled:
                                              firstCompleted == true
                                                  ? false
                                                  : true,
                                              onEditingComplete: () {
                                                setState(() {
                                                  Future.delayed(
                                                      const Duration(
                                                          milliseconds:
                                                          10), () {
                                                    FocusScope.of(context)
                                                        .requestFocus(
                                                        _focusNode1);
                                                  });
                                                  firstCompleted = true;
                                                  secondDisabled = false;
                                                });
                                              },
                                              focusNode: _focusNode,
                                              style:
                                              TextStyle(fontSize: 15),
                                              decoration:
                                              const InputDecoration(
                                                  border: InputBorder
                                                      .none,
                                                  hintText:
                                                  'Scan BOL Number',
                                                  contentPadding:
                                                  EdgeInsets.only(
                                                      left: 10,
                                                      bottom:
                                                      10)),
                                            )
                                                : DisabledTextField(data
                                                ?.data
                                                ?.salesOrder
                                                ?.bolNumber ??
                                                "1234"),
                                          ),
                                        ),
                                        (data?.data?.salesOrder
                                            ?.isAllPalletsVerifiedOrNot ??
                                            false)
                                            ? InkWell(
                                          child: message == "Edit"
                                              ? Container(
                                            child: const Center(
                                                child: Text(
                                                  'Reset BOL Number',
                                                  style: TextStyle(
                                                      color:
                                                      Colors.white,
                                                      fontWeight:
                                                      FontWeight
                                                          .w500,
                                                      fontSize: 16),
                                                )),
                                            color: Color(0xff32C5D2),
                                            height: double.infinity,
                                            padding:
                                            EdgeInsets.all(5),
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
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Scan Location',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(height: 5),
                                  Container(
                                    width: 300,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: kBorderColor),
                                        color: secondDisabled == true
                                            ? Color(0xffeef1f5)
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: TextField(
                                      enabled:
                                      secondDisabled == true ? false : true,
                                      focusNode: _focusNode1,
                                      controller: _scanLocationController,
                                      onEditingComplete: () {
                                        if (_scanLocationController?.text !=
                                            data?.data?.pickOrderPalletList
                                                ?.first.palletLocation) {
                                          setState(() {
                                            _scanLocationController?.text = "";
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                  "Incorrect Pallet Location"),
                                            ));
                                            return;
                                          });
                                        } else {
                                          setState(() {
                                            Future.delayed(
                                                const Duration(
                                                    milliseconds: 10), () {
                                              FocusScope.of(context)
                                                  .requestFocus(_focusNode2);
                                              // print(FocusScope.of(context)
                                              //     .focusedChild
                                              //     .toString());
                                            });
                                            secondCompleted = true;
                                            if ((firstCompleted == true &&
                                                secondCompleted == true) ||
                                                firstCompleted == true) {
                                              secondDisabled = true;
                                            }
                                          });
                                        }
                                      },
                                      style: TextStyle(fontSize: 15),
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Scan Location',
                                          contentPadding: EdgeInsets.only(
                                              left: 10, bottom: 10)),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Attachment',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  attachmentContainer(context),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          padding: const EdgeInsets.all(10),
                          height: 40,
                          decoration: const BoxDecoration(
                            color: Color(0xff5E6672),
                          ),
                          child: const Text("Pallet Verification"),
                        ),
                        SizedBox(height: 10),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20, top: 10, right: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Scan Pallet',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(height: 5),
                                    Container(
                                      width: 300,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          border:
                                          Border.all(color: kBorderColor),
                                          color: (secondDisabled == true &&
                                              secondCompleted == true)
                                              ? Colors.transparent
                                              : Color(0xffeef1f5),
                                          borderRadius:
                                          BorderRadius.circular(5)),
                                      child: TextField(
                                        enabled: (secondDisabled == true &&
                                            secondCompleted == true)
                                            ? true
                                            : false,
                                        focusNode: _focusNode2,
                                        controller: _scanPartController,
                                        onEditingComplete: () {
                                          // print(data?.data?.pickOrderPalletList?.first
                                          //     .poPalletId);
                                          String? txt =
                                              _scanPartController?.text;
                                          if (txt != null
                                              ? txt.contains(
                                              '${data?.data?.salesOrder
                                                  ?.soNumber}')
                                              : false) {
                                            txt = txt.replaceAll(
                                                '${data?.data?.salesOrder
                                                    ?.soNumber}',
                                                "");
                                            if (txt == "") {
                                              _scanPartController?.text = "";
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                  content: Text(
                                                      "Please Scan Valid Pallet")));
                                            } else {
                                              if (data?.data
                                                  ?.pickOrderPalletList
                                                  ?.any((element) =>
                                              element.palletNo ==
                                                  txt) ==
                                                  true) {
                                                PickOrderPalletList?
                                                verifiedPallet = data?.data
                                                    ?.pickOrderPalletList
                                                    ?.firstWhere(
                                                        (element) =>
                                                    element
                                                        .palletNo ==
                                                        txt);
                                                setState(() {
                                                  verifiedPallet
                                                      ?.isPalletVerified = true;
                                                  verifiedPallet
                                                      ?.timeOfVerification =
                                                      DateTime.now()
                                                          .toStrCommonFormat();
                                                  verifiedPallet?.statusTerm =
                                                  "Verified";
                                                  verifiedPallet
                                                      ?.scanDateTimeStr =
                                                      DateTime.now()
                                                          .toStrCommonFormat();
                                                });
                                              } else {
                                                _scanPartController?.text = "";
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text(
                                                      "Please Scan Valid Pallet"),
                                                ));
                                              }
                                            }
                                            // print(txt);
                                          } else {
                                            _scanPartController?.text = "";
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                  "Please Scan Valid Pallet"),
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
                                            contentPadding: EdgeInsets.only(
                                                left: 10, bottom: 10)),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: dataTable(context, dataRow1(list))),
                                const SizedBox(width: 10,),
                                Expanded(
                                    child: dataTable(context, dataRow2(list)))
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 20,
                        ),
                        buildSubmitSection()
                      ],
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
          (message == "Edit" ||
              data?.data?.salesOrder?.isAllPalletsVerifiedOrNot == false)
              ? TextButton(
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all<Color>(Color(0xff32C5D2)),
                overlayColor: MaterialStateProperty.all<Color>(
                    Colors.white.withOpacity(0.3)),
                foregroundColor:
                MaterialStateProperty.all<Color>(Colors.white),
              ),
              onPressed: () {
                CustomPopupWith3Fields(context,
                    title: 'Hi There',
                    message: 'Choose how you want to upload photo',
                    primaryBtnTxt: 'close',
                    secondaryBtnTxt: 'Files',
                    thirdBtnTxt: 'Camera',
                    thirdBtnAction: () {
                      Navigator.pushNamed(context, kCamera);
                    },
                    secondaryAction: _getPhotoFromGallery);
              },
              child: Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: (data?.data?.salesOrder?.attachment != null)
                      ? Text("${data?.data?.salesOrder?.attachmentStr}")
                      : const Icon(Icons.insert_drive_file_outlined)))
              : Container(),
          isPath
              ? Container(
            margin: EdgeInsets.only(left: 5),
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
              style: TextStyle(
                  fontSize: 12,
                  color: kPrimaryColor,
                  overflow: TextOverflow.ellipsis),
            ),
          )
              : Container()
        ],
      ),
    );
  }

  Container DisabledTextField(String? txt) {
    return Container(
      color: Color(0xffeef1f5),
      child: TextField(
        controller: _bolNumberController,
        enabled: enableBolNumberField,
        style: TextStyle(fontSize: 15),
        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(left: 10, bottom: 10)),
      ),
    );
  }

  Widget buildSubmitSection() {
    var d = data?.data?.pickOrderPalletList
        ?.map((e) => e.isPalletVerified)
        .toList();
    showSubmitButton = (d?.contains(false) == false || message == "Edit");

    final submitData =
        context
            .watch<ShippingVerificationProvider>()
            .submitUnverifiedDataGet;

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
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.green),
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
                  child: Text("Cancel"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget dataTable(BuildContext context, List<DataRow> dataRowList) {
    final home = context.read<ShippingVerificationProvider>();
    Widget headerWidget(String text, {Widget? leading}) {
      return Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: leading,
                padding: EdgeInsets.only(right: 2),
              ),
              Text(
                text,
                style: const TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.black.withOpacity(0.1))),
        child: DataTable(columns: [
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
                leading: Icon(
                  Icons.date_range_sharp,
                  size: 20,
                )),
          ),
          // DataColumn(label: headerWidget('Pallet Location')),
        ], rows: dataRowList),
      ),
    );
  }


  List<DataRow> dataRow1(List<PickOrderPalletList>? list) {
    int len = list?.length ?? 0;
    int lenByHalf = (len / 2).round();
    List<DataRow> d = [];
    for (int i = 0; i < (lenByHalf); i++) {
      d.add(DataRow(cells: [
        DataCell(Center(
          child: SizedBox(
            width: kFlexibleSize(50),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
              child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: const Color(0xff67809F)),
                  onPressed: () {},
                  child: childText(
                      '${data?.data?.pickOrderPalletList?[i].palletNo}',
                      Colors.black)),
            ),
          ),
        )),
        data?.data?.pickOrderPalletList?[i].statusTerm == "Verified"
            ? DataCell(Center(
          child: Container(
            width: kFlexibleSize(120),
            child: Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
              child: TextButton(
                  style:
                  TextButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () {},
                  child: childText('verified', Colors.white)),
            ),
          ),
        ))
            : DataCell(Container()),
        data?.data?.pickOrderPalletList?[i].statusTerm == "Verified"
            ? DataCell(childText(
            '${(data?.data?.pickOrderPalletList?[i].scanDateTimeStr) ??
                'Right Now'} ',
            Colors.black))
            : DataCell(Container()),
        // DataCell(Center(
        //   child: Container(
        //     width: kFlexibleSize(150),
        //     child: Padding(
        //       padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        //       child: TextButton(
        //           style:
        //               TextButton.styleFrom(backgroundColor: Colors.redAccent),
        //           onPressed: () {},
        //           child: childText(
        //               '${data?.data?.pickOrderPalletList?.first.palletLocationStr}',
        //               Colors.white)),
        //     ),
        //   ),
        // )),
      ]));
    }
    return d;

    //
    //   return DataRow(cells: [
    //               DataCell(Center(
    //                 child: Container(
    //                   width: kFlexibleSize(100),
    //                   child: Padding(
    //                     padding: const EdgeInsets.symmetric(
    //                         vertical: 8, horizontal: 5),
    //                     child: TextButton(
    //                         style: TextButton.styleFrom(
    //                             backgroundColor: Colors.deepOrangeAccent),
    //                         onPressed: () {},
    //                         child: childText('${e.poPalletId}', Colors.black)),
    //                   ),
    //                 ),
    //               )),
    //               DataCell(Center(
    //                 child: Container(
    //                   width: kFlexibleSize(150),
    //                   child: Padding(
    //                     padding: const EdgeInsets.symmetric(
    //                         vertical: 8, horizontal: 5),
    //                     child: TextButton(
    //                         style: TextButton.styleFrom(
    //                             backgroundColor: Colors.grey),
    //                         onPressed: () {},
    //                         child: childText('verify', Colors.white)),
    //                   ),
    //                 ),
    //               )),
    //               DataCell(childText('12 /03/2022 19:25:45 ', Colors.black)),
    //               DataCell(Center(
    //                 child: Container(
    //                   width: kFlexibleSize(150),
    //                   child: Padding(
    //                     padding: const EdgeInsets.symmetric(
    //                         vertical: 8, horizontal: 5),
    //                     child: TextButton(
    //                         style: TextButton.styleFrom(
    //                             backgroundColor: Colors.redAccent),
    //                         onPressed: () {},
    //                         child: childText('Truck1', Colors.white)),
    //                   ),
    //                 ),
    //               )),
    //             ]);
  }

  List<DataRow> dataRow2(List<PickOrderPalletList>? list) {
    int len = list?.length ?? 0;
    int lenByHalf = (len / 2).round();
    List<DataRow> d = [];
    for (int i = lenByHalf; i < (list?.length ?? 0); i++) {
      print(i);
      d.add(DataRow(cells: [
        DataCell(Center(
          child: SizedBox(
            width: kFlexibleSize(50),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
              child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: const Color(0xff67809F)),
                  onPressed: () {},
                  child: childText(
                      '${data?.data?.pickOrderPalletList?[i].palletNo}',
                      Colors.black)),
            ),
          ),
        )),
        data?.data?.pickOrderPalletList?[i].statusTerm == "Verified"
            ? DataCell(Center(
          child: Container(
            width: kFlexibleSize(120),
            child: Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
              child: TextButton(
                  style:
                  TextButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () {},
                  child: childText('verified', Colors.white)),
            ),
          ),
        ))
            : DataCell(Container()),
        data?.data?.pickOrderPalletList?[i].statusTerm == "Verified"
            ? DataCell(childText(
            '${(data?.data?.pickOrderPalletList?[i].scanDateTimeStr) ??
                'Right Now'} ',
            Colors.black))
            : DataCell(Container()),
        // DataCell(Center(
        //   child: Container(
        //     width: kFlexibleSize(150),
        //     child: Padding(
        //       padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        //       child: TextButton(
        //           style:
        //               TextButton.styleFrom(backgroundColor: Colors.redAccent),
        //           onPressed: () {},
        //           child: childText(
        //               '${data?.data?.pickOrderPalletList?.first.palletLocationStr}',
        //               Colors.white)),
        //     ),
        //   ),
        // )),
      ]));
    }
    return d;
    //
    //   return DataRow(cells: [
    //               DataCell(Center(
    //                 child: Container(
    //                   width: kFlexibleSize(100),
    //                   child: Padding(
    //                     padding: const EdgeInsets.symmetric(
    //                         vertical: 8, horizontal: 5),
    //                     child: TextButton(
    //                         style: TextButton.styleFrom(
    //                             backgroundColor: Colors.deepOrangeAccent),
    //                         onPressed: () {},
    //                         child: childText('${e.poPalletId}', Colors.black)),
    //                   ),
    //                 ),
    //               )),
    //               DataCell(Center(
    //                 child: Container(
    //                   width: kFlexibleSize(150),
    //                   child: Padding(
    //                     padding: const EdgeInsets.symmetric(
    //                         vertical: 8, horizontal: 5),
    //                     child: TextButton(
    //                         style: TextButton.styleFrom(
    //                             backgroundColor: Colors.grey),
    //                         onPressed: () {},
    //                         child: childText('verify', Colors.white)),
    //                   ),
    //                 ),
    //               )),
    //               DataCell(childText('12 /03/2022 19:25:45 ', Colors.black)),
    //               DataCell(Center(
    //                 child: Container(
    //                   width: kFlexibleSize(150),
    //                   child: Padding(
    //                     padding: const EdgeInsets.symmetric(
    //                         vertical: 8, horizontal: 5),
    //                     child: TextButton(
    //                         style: TextButton.styleFrom(
    //                             backgroundColor: Colors.redAccent),
    //                         onPressed: () {},
    //                         child: childText('Truck1', Colors.white)),
    //                   ),
    //                 ),
    //               )),
    //             ]);
  }

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

  Widget keyValueBox(
      {required double width, required String key, required String value}) {
    return Container(
      width: (width - 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            key,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            child: Text(
              value,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black.withOpacity(0.1))),
            width: double.infinity,
          )
        ],
      ),
    );
  }

  Widget keyValueBoxWithHtml(
      {required double width, required String key, required HtmlWidget value}) {
    return Container(
      width: (width - 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            key,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            child: value,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black.withOpacity(0.1))),
            width: double.infinity,
          )
        ],
      ),
    );
  }

  Widget keyValueBoxForWidget(
      {required double width, required String key, required Widget value}) {
    return Container(
      width: (width - 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            key,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            child: value,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black.withOpacity(0.1))),
            width: double.infinity,
          )
        ],
      ),
    );
  }

  _submitUnverifiedData() async {
    final home = context.read<ShippingVerificationProvider>();
    print(_bolNumberController?.text);
    print(file?.path);
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
