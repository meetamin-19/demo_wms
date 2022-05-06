import 'package:demo_win_wms/app/data/entity/res/res_bind_location_list.dart';
import 'package:demo_win_wms/app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colored_bg_text.dart';

class CustomPopUpForLocationBinding {
  final List<BindLocationListData>? list;
  final String? title;
  final String? primaryBtnTxt;
  final Function? primaryAction;
  bool isFirstCompleted = false;
  final TextEditingController _scanPalletController = TextEditingController();

  CustomPopUpForLocationBinding(BuildContext context,
      {required this.list, this.title, this.primaryBtnTxt, this.primaryAction}) {
    final size = MediaQuery.of(context).size;

    showCupertinoDialog(
        context: context,
        builder: (context) {
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
                    Expanded(child: body(size)),
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
  }

  Widget body(Size size) {
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
                          // color: secondDisabled == true ? const Color(0xffeef1f5) : Colors.transparent,
                          borderRadius: BorderRadius.circular(5)),
                      child: TextField(
                        // enabled: secondDisabled == true ? false : true,
                        // focusNode: _focusNode1,
                        controller: _scanPalletController,
                        onEditingComplete: () {
                          // if (_scanPalletController.text !=
                          //     data?.data?.pickOrderPalletList?.first.palletLocation) {
                          //   setState(() {
                          //     _scanLocationController?.text = "";
                          //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          //       content: Text("Incorrect Pallet Location"),
                          //     ));
                          //     return;
                          //   });
                          // } else {
                          //   setState(() {
                          //     Future.delayed(const Duration(milliseconds: 10), () {
                          //       FocusScope.of(context).requestFocus(_focusNode2);
                          //       // print(FocusScope.of(context)
                          //       //     .focusedChild
                          //       //     .toString());
                          //     });
                          //     secondCompleted = true;
                          //     if ((firstCompleted == true && secondCompleted == true) ||
                          //         firstCompleted == true) {
                          //       secondDisabled = true;
                          //     }
                          //   });
                          // }
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
                          // color: secondDisabled == true ? const Color(0xffeef1f5) : Colors.transparent,
                          borderRadius: BorderRadius.circular(5)),
                      child: TextField(
                        // enabled: secondDisabled == true ? false : true,
                        // focusNode: _focusNode1,
                        // controller: _scanLocationController,
                        onEditingComplete: () {
                          // if (_scanLocationController?.text !=
                          //     data?.data?.pickOrderPalletList?.first.palletLocation) {
                          //   setState(() {
                          //     _scanLocationController?.text = "";
                          //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          //       content: Text("Incorrect Pallet Location"),
                          //     ));
                          //     return;
                          //   });
                          // } else {
                          //   setState(() {
                          //     Future.delayed(const Duration(milliseconds: 10), () {
                          //       FocusScope.of(context).requestFocus(_focusNode2);
                          //       // print(FocusScope.of(context)
                          //       //     .focusedChild
                          //       //     .toString());
                          //     });
                          //     secondCompleted = true;
                          //     if ((firstCompleted == true && secondCompleted == true) ||
                          //         firstCompleted == true) {
                          //       secondDisabled = true;
                          //     }
                          //   });
                          // }
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
              children: List.generate(list?.length ?? 0, (index) {
                if (index == 0) {
                  return TableRow(children: [
                    header('#'),
                    header('Location'),
                  ]);
                }

                final data = list?[index - index];

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
}
