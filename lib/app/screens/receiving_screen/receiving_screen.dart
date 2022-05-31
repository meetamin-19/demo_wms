import 'package:demo_win_wms/app/data/entity/res/res_get_pallet_list_data_by_id.dart';
import 'package:demo_win_wms/app/providers/service_provider.dart';
import 'package:demo_win_wms/app/providers/shipping_verification_provider.dart';
import 'package:demo_win_wms/app/screens/base_components/common_app_bar.dart';
import 'package:demo_win_wms/app/screens/base_components/sidemenu_column.dart';
import 'package:demo_win_wms/app/screens/receiving_screen/components/receive_data_component.dart';
import 'package:demo_win_wms/app/utils/constants.dart';
import 'package:demo_win_wms/app/utils/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';


class ReceivingScreen extends StatefulWidget {
  const ReceivingScreen({Key? key}) : super(key: key);

  @override
  State<ReceivingScreen> createState() => _ReceivingScreenState();
}

class _ReceivingScreenState extends State<ReceivingScreen> {
  FocusNode? _focusNode;
  TextEditingController? _scanPartController;
  bool state = false;
  List<bool> _isSelected = [false, true];
  int pageLimit = 100;
  String? selectedRange = "100";
  String? selectedStartPoint = "0";
  int? itemCount = 1;
  bool? loading = false;
  int startingIndex = 1;
  int selectedIndex = 1;
  int length = 20;

  BoxDecoration unselectedBox =
  BoxDecoration(color: const Color(0xffE5E5E5).withOpacity(0.5), borderRadius: const BorderRadius.all(const Radius.circular(3)));

  BoxDecoration selectedBox =
  const BoxDecoration(color: Color(0xff7F849A), borderRadius: BorderRadius.all(Radius.circular(3)));

  @override
  void initState() {
    super.initState();

    _focusNode = FocusNode();
    _scanPartController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    _focusNode?.dispose();
    _scanPartController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(hasLeading: true),
      body: Scaffold(
        body: Stack(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SideMenuColumnWidget(context),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                          padding: EdgeInsets.only(left: 8, top: 5, bottom: 10),
                          child:
                              Text("RECEIVING PROCESS", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700))),
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(2)),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                             crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisAlignment: MainAxisAlignment.start,
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
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(5), topLeft: Radius.circular(5)),
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
                                                // toggleContainerVisibility();
                                              },
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: const [
                                                  Text(
                                                    "Container : HLBU1605217",
                                                    style: TextStyle(color: Colors.white, fontSize: 20),
                                                  ),
                                                  Text(
                                                    "Receiving Location : REC1",
                                                    style: TextStyle(color: Colors.white, fontSize: 20),
                                                  ),
                                                ],
                                              ),
                                            )),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20, top: 10, right: 10),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Row(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        const Text(
                                                          'Scan Box',
                                                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                                        ),
                                                        const SizedBox(height: 5),
                                                        Container(
                                                          width: 200,
                                                          height: 40,
                                                          decoration: BoxDecoration(
                                                              border: Border.all(color: kBorderColor),
                                                              color: const Color(0xffeef1f5),
                                                              borderRadius: BorderRadius.circular(2)),
                                                          child: TextField(
                                                            // enabled: (secondDisabled == true && secondCompleted == true) ? true : false,
                                                            focusNode: _focusNode,
                                                            controller: _scanPartController,
                                                            onEditingComplete: () {},
                                                            style: const TextStyle(fontSize: 15),
                                                            decoration: const InputDecoration(
                                                                border: InputBorder.none,
                                                                hintText: 'Scan Box',
                                                                contentPadding: EdgeInsets.only(left: 10, bottom: 10)),
                                                          ),
                                                        ),
                                                        const SizedBox(height: 10),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.only(left: kFlexibleSize(8)),
                                                          child: const Text(
                                                            'Scan Mode',
                                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.only(left: kFlexibleSize(8),),
                                                          child: Container(
                                                              width: kFlexibleSize(101),
                                                              height: kFlexibleSize(40),
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(color: kBorderColor),
                                                                  color: const Color(0xffeef1f5),
                                                                  borderRadius: BorderRadius.circular(2)),
                                                              child: ToggleButtons(
                                                                isSelected: _isSelected,
                                                                onPressed: (int index) {
                                                                  setState(() {
                                                                    for (int i = 0; i < _isSelected.length; i++) {
                                                                      _isSelected[i] = i == index;
                                                                    }
                                                                    //_isSelected[index] = !_isSelected[index];
                                                                  });
                                                                },
                                                                color: Colors.black,
                                                                selectedColor: Colors.white,
                                                                fillColor: Colors.green,
                                                                children: [
                                                                  Container(
                                                                    child: Text('ON'),
                                                                  ),
                                                                  Container(
                                                                    child: Text('OFF'),
                                                                  )
                                                                ],
                                                              )),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Flexible(
                                                  fit: FlexFit.loose,
                                                  child: Container(
                                                    width: 300,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(2),
                                                        border: Border.all(color: Colors.black.withOpacity(0.1))
                                                    ),
                                                    // margin: const EdgeInsets.all(20),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            ReceiveDataViewComponent(
                                                              title: 'Part No:',
                                                              value: '25368',
                                                            ),
                                                            ReceiveDataViewComponent(
                                                              title: 'Month:',
                                                              value: 'December',
                                                            ),
                                                            ReceiveDataViewComponent(
                                                              title: 'Year:',
                                                              value: '2022',
                                                            ),
                                                            ReceiveDataViewComponent(
                                                              title: 'Qty:',
                                                              value: '253',
                                                            )
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding:  EdgeInsets.only(top: kFlexibleSize(8),left: kFlexibleSize(10)),
                                                          child: Row(
                                                            //crossAxisAlignment: CrossAxisAlignment.start,
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Padding(
                                                                padding:  EdgeInsets.only(left: kFlexibleSize(10)),
                                                                child: ReceiveDataViewComponent(
                                                                  title: 'Box Qty:',
                                                                  value: '253',
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 15,
                                                              ),
                                                              ReceiveDataViewComponent(
                                                                title: 'Total Box:',
                                                                value: '253',
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 15,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: dataTable(context, dataRow([])),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                              pages(context),
                              // const SizedBox(height: 10),
                              bindDataTable(context)
                              //if (!isLoading)
                            ],
                          ),
                        ),
                      ))
                    ],
                  ),
                ))
              ],
            )
          ],
        ),
      ),
    );
  }


  Widget dataTable(BuildContext context, List<DataRow> dataRowList) {
    Widget headerWidget(String text, {Widget? leading}) {
      return Expanded(
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.only(top: kFlexibleSize(5)),
      child: Container(
        margin: EdgeInsets.only(top: kFlexibleSize(15)),
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.black.withOpacity(0.1))),
        child: DataTable(
            border: TableBorder.all(color: Colors.transparent),
            columnSpacing: 0,
            horizontalMargin: 0,
            // showBottomBorder: false,
            headingRowHeight: 40,
            headingRowColor: MaterialStateProperty.all<Color>(Colors.grey.withOpacity(0.1)),
            columns: [
              DataColumn(
                label: headerWidget('Company'),
              ),
              DataColumn(
                label: headerWidget(
                  'Total Parts',
                ),
              ),
              DataColumn(
                label: headerWidget(
                  'Scanned Parts',
                ),
              ),
              DataColumn(
                label: headerWidget(
                  'Remaining Parts',
                ),
              ),
              // DataColumn(label: headerWidget('Pallet Location')),
            ],
            rows: dataRowList),
      ),
    );
  }

  Widget childText(String text, Color col) {
    return ConstrainedBox(
      child: Center(
          child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: col),
      )),
      constraints: BoxConstraints(minHeight: kFlexibleSize(50)),
    );
  }

  List<DataRow> dataRow(List<PickOrderPalletList>? list) {
    int len = 5;
    Color? color;
    // int lenByHalf = (len / 2).round();
    List<DataRow> d = [];
    for (int i = 0; i < len; i++) {
      color = Colors.white;

      if (i % 2 == 0) {
        color = const Color(0xffF9F9F9);
      }

      d.add(DataRow(color: MaterialStateProperty.all(color), cells: [
        DataCell(Container( child: childText('Imperial Auto Industries Ltd', Color(0xff337AB7)))),
        DataCell(childText('60', Colors.black)),
        DataCell(childText('45', Colors.black)),
        DataCell(childText('15', Colors.black)),
      ]));
    }
    return d;
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
                    // fetchList();
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
                        decoration: const BoxDecoration(borderRadius: BorderRadius.all( Radius.circular(3))),
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
                          if(itemCount! < 7) {
                            startingIndex = 1;
                          }
                          else{
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
                        decoration: const BoxDecoration(borderRadius: BorderRadius.all( Radius.circular(3))),
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
    //fetchList();
  }

  Widget bindDataTable(BuildContext context) {
    final home = context.watch<ShippingVerificationProvider>();
    final filters = context.watch<ServiceProviderImpl>();
    final filtersLoaded = filters.shippingverificationfilters?.state == Status.COMPLETED;
    final listloading = home.shippingVerificationList?.state == Status.COMPLETED;


    if (filtersLoaded) {
      // if (!listloading) {
      //   return Container(
      //       margin: const EdgeInsets.symmetric(vertical: 20),
      //       height: 50,
      //       color: Colors.white,
      //       child: Center(child: LoadingSmall()));
      // } else {
      return Container(
          width: MediaQuery.of(context).size.width ,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), /*border: Border.all(color: Colors.black.withOpacity(0.1))*/
          ),
          child: table());
      // }
    }
    // else {
    return Container(
        width: MediaQuery.of(context).size.width ,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), /*border: Border.all(color: Colors.black.withOpacity(0.1))*/
        ),
        child: table());
    // }
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

    // if (hasError) {
    //   return NoDataFoundView(
    //     retryCall: () {
    //       context.read<ShippingVerificationProvider>().getShippingVerificationList();
    //     },
    //   );
    // }
    //
    // if (emptyList == 0) {
    //   return const NoDataFoundView(
    //     title: "No Data Found ",
    //   );
    // }

    final list = home.filteredShippingVerificationData;


    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
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
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(4),
                2: FlexColumnWidth(4),
                3: FlexColumnWidth(4),
                4: FlexColumnWidth(4),
                5: FlexColumnWidth(4),
                6: FlexColumnWidth(4),
                7: FlexColumnWidth(4),
                8: FlexColumnWidth(5),
                9: FlexColumnWidth(5),
                10: FlexColumnWidth(5),
                11: FlexColumnWidth(5),
                12: FlexColumnWidth(5),
                13: FlexColumnWidth(5),

              },
              children: [
                TableRow(children: [
                  headerWidget('#'),
                  headerWidget('Action'),
                  headerWidget('Bind Location'),
                  headerWidget('Count'),
                  headerWidget('Invoice No'),
                  headerWidget('Box Qty'),
                  headerWidget('Qty'),
                  headerWidget('Location'),
                  headerWidget('Suggested Location'),
                  headerWidget('Receiving'),
                  headerWidget('Difference'),
                  headerWidget('Comments'),
                  headerWidget('Scanned by'),
                ])
              ],
            ),
          ),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(4),
              2: FlexColumnWidth(4),
              3: FlexColumnWidth(4),
              4: FlexColumnWidth(4),
              5: FlexColumnWidth(4),
              6: FlexColumnWidth(4),
              7: FlexColumnWidth(4),
              8: FlexColumnWidth(5),
              9: FlexColumnWidth(5),
              10: FlexColumnWidth(5),
              11: FlexColumnWidth(5),
              12: FlexColumnWidth(5),
              13: FlexColumnWidth(5),
            },
            // border: TableBorder.all(color: kBorderColor),
            children: List.generate((10), (index) {
              Color? colorForRow = Colors.white;

              if (index % 2 == 0) {
                colorForRow = const Color(0xffF9F9F9);
              }

              final data = list?[index];

              return TableRow(decoration: BoxDecoration(color: colorForRow), children: [
                Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: childText('1 ', Colors.black),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 8,top: 8,bottom: 8),
                    child: containerPart(),
                  ),
                ),
                Center(child: Padding(
                  padding: const EdgeInsets.only(left: 3,right: 3,top: 8,bottom: 8),
                  child: childText('3036 Indiana ', Color(0xff337AB7)),
                )),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 3,right: 3,top: 8,bottom: 8),
                    child: childText('5', Colors.black),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 3,right: 3,top: 8,bottom: 8),
                    child: childText('E212502239', Colors.black),
                  ),
                ),
                Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 3,right: 3,top: 8,bottom: 8),
                      child: childText(
                          '5687213-01', Colors.black),
                    )),
                Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 3,right: 3,top: 8,bottom: 8),
                      child: childText(
                          '3', Colors.black),
                    )),
                Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 3,right: 3,top: 8,bottom: 8),
                      child: childText(
                          '20', Colors.black),
                    )),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 3,right: 3,top: 8,bottom: 8),
                    child: childText('A8A1', Colors.black),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 3,right: 3,top: 8,bottom: 8),
                    child: childText('A8A5', Colors.black),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 3,right: 3,top: 8,bottom: 8),
                    child: childText('36', Colors.black),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 3,right: 3,top: 8,bottom: 8),
                    child: childText('108', Colors.black),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 3,right: 3,top: 8,bottom: 8),
                    child: childText('Lorem', Colors.black),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 3,right: 3,top: 8,bottom: 8),
                    child: childText('Brian'
                        '', Colors.black),
                  ),
                ),
              ]);
            }),
          ),
        ],
      ),
    );
  }

  Widget containerPart() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0,right: 8,top: 8,bottom: 8),
      child: Container(
        width: kFlexibleSize(25),
        height: kFlexibleSize(25),
        decoration: BoxDecoration(
            color: Color(0xff26C281),
            borderRadius: BorderRadius.circular(2)
        ),
        child: Center(
          child: kImgMsg,
        ),
      ),
    );
  }


}
