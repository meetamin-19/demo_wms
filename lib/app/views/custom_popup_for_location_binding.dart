import 'package:demo_win_wms/app/data/entity/res/res_bind_location_list.dart';
import 'package:demo_win_wms/app/providers/pallet_provider.dart';
import 'package:demo_win_wms/app/utils/constants.dart';
import 'package:demo_win_wms/app/utils/enums.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'colored_bg_text.dart';

class CustomPopUpForLocationBinding {
  final List<BindLocationListData>? list;
  final String? title;
  final String? primaryBtnTxt;
  final Function? primaryAction;
  bool isFirstCompleted = false;
  final TextEditingController _scanLocationController = TextEditingController();
  final TextEditingController _scanPalletController = TextEditingController();
  final FocusNode _focusNode1 = FocusNode();

  CustomPopUpForLocationBinding(BuildContext context,
      {required this.list, this.title, this.primaryBtnTxt, this.primaryAction}) {
    final size = MediaQuery.of(context).size;

    showCupertinoDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Scaffold(
              backgroundColor: Colors.black.withOpacity(0.3),
              body: Center(
                child: Container(
                  constraints: BoxConstraints(
                      minWidth: 100,
                      maxWidth: size.width > 650 ? 650 : size.width * 0.9,
                      minHeight: 100,
                      maxHeight: size.height * 0.9),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Icon(Icons.close,color: Colors.transparent,),
                          Expanded(
                            child: Text(
                              title ?? "",
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          // IconButton(icon: Icon(Icons.close), onPressed: (){
                          //   Navigator.of(context).pop();
                          // })
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 1,
                        color: Colors.black12,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(child: body(size, context, setState)),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 1,
                        color: Colors.black12,
                      ),
                      const SizedBox(height: 15),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.blue),
                                borderRadius: BorderRadius.circular(5)),
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                if (primaryAction != null) {
                                  primaryAction!();
                                  _scanPalletController.dispose();
                                  _scanLocationController.dispose();
                                  _focusNode1.dispose();
                                }
                              },
                              child: Text(
                                primaryBtnTxt ?? "",
                                style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }

  Widget body(Size size, BuildContext context, void Function(void Function()) setState) {
    int len = (list?.length ?? 0) + 1;

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
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        constraints: BoxConstraints(
            minWidth: 100,
            maxWidth: size.width > 2000 ? 2000 : size.width * 0.9,
            minHeight: 10,
            maxHeight: size.height * 0.8),
        child: SingleChildScrollView(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Wrap(
              spacing: 20,
              runSpacing: 10,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                          color: isFirstCompleted == true ? const Color(0xffeef1f5) : Colors.transparent,
                          borderRadius: BorderRadius.circular(5)),
                      child: TextField(
                        autofocus: true,
                        enabled: !isFirstCompleted,
                        controller: _scanPalletController,
                        onEditingComplete: () {
                          checkScanPart(context, setState);
                        },
                        style: const TextStyle(fontSize: 15),
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Scan Pallet',
                            contentPadding: EdgeInsets.only(left: 10, bottom: 10)),
                      ),
                    ),
                  ],
                ),
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
                          color: isFirstCompleted == false ? const Color(0xffeef1f5) : Colors.transparent,
                          borderRadius: BorderRadius.circular(5)),
                      child: TextField(
                        enabled: isFirstCompleted,
                        focusNode: _focusNode1,
                        controller: _scanLocationController,
                        // autofocus: true,
                        onEditingComplete: () {
                          if (_scanLocationController.text != " " && _scanLocationController.text.isNotEmpty) {
                            checkLocation(context, setState);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                backgroundColor: Colors.red, content: Text("Please Scan/Enter Location")));
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
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text("Suggested Locations"),
                )),
            Table(
              border: TableBorder.all(color: Colors.black.withOpacity(0.3)),
              columnWidths: const {0: FlexColumnWidth(1), 1: FlexColumnWidth(10)},
              children: List.generate(len, (index) {
                if (index == 0) {
                  return TableRow(children: [
                    header('#'),
                    header('Location'),
                  ]);
                }

                final data = list?[index - 1];

                return TableRow(children: [
                  value('$index'),
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: Wrap(
                      runSpacing: 5.0,
                      spacing: 5.0,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
                          child: Text('${data?.text}'),
                        ),
                        // const SizedBox(width: 2),
                        ColoredBGText(text: '${data?.data1}', color: const Color(0xffFF5555)),
                        ColoredBGText(text: '${data?.data2}', color: const Color(0xffB981FF)),
                        ColoredBGText(text: '${data?.data3}', color: const Color(0xffB981FF)),
                      ],
                    ),
                  )
                ]);
              }),
            )
          ],
        )),
      ),
    );
  }

  checkScanPart(BuildContext context, void Function(void Function()) setState) async {
    final provider = context.read<PalletProviderImpl>();
    String txt = _scanPalletController.text;
    if (txt.contains(provider.selectedSoNumber)) {
      txt = txt.replaceAll(provider.selectedSoNumber, "");
      if (txt.isNotEmpty) {
        if (provider.selectedPallet == txt) {
          setState(() {
            isFirstCompleted = true;
            Future.delayed(const Duration(milliseconds: 10), () {
              FocusScope.of(context).requestFocus(_focusNode1);
            });
            _focusNode1.requestFocus();
          });
        }
      } else {
        _scanPalletController.text = "";
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(backgroundColor: Colors.red, content: Text("Incorrect Value")));
      }
    } else {
      _scanPalletController.text = "";
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(backgroundColor: Colors.red, content: Text("Incorrect Value")));
    }
  }

  checkLocation(BuildContext context, void Function(void Function()) setState) async {
    final provider = context.read<PalletProviderImpl>();
    int warehouseID = provider.lineItemRes?.data?.data?.pickOrderSoDetail?.warehouseId ?? 0;
    provider.warehouseID = warehouseID;
    await provider.updatePOPalletBindLocation(locationTitle: _scanLocationController.text);
    if (provider.updateBindLocation?.state == Status.COMPLETED) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.green,
        content: Text("Successfully updated location"),
      ));
      Navigator.pop(context);
    } else if (provider.updateBindLocation?.state == Status.ERROR) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text("${provider.updateBindLocation?.msg}"),
      ));
    }
  }
}
