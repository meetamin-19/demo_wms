import 'package:flutter/material.dart';
import 'package:demo_win_wms/app/screens/base_components/common_app_bar.dart';

class InventoryAuditScreen extends StatefulWidget {
  const InventoryAuditScreen({Key? key}) : super(key: key);

  @override
  State<InventoryAuditScreen> createState() => _InventoryAuditScreenState();
}

class _InventoryAuditScreenState extends State<InventoryAuditScreen> {
  late int fin;

  TextEditingController actualQuantityController = TextEditingController();

  TextEditingController commentsController = TextEditingController();

  bool isEditing = false;

  FocusNode _focus = FocusNode();

  @override
  void initState() {
    actualQuantityController.text = "0";
    commentsController.text = "Moved from A512 to B2345";
    _focus.addListener(_onFocusChange);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
  }

  void _onFocusChange() {
    print("Focus: ${_focus.hasFocus.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CommonAppBar(
          hasLeading: true,
          isTitleSearch: true,
          hasBackButton: true
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "INVENTORY AUDIT",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  Expanded(
                    child: Card(
                      elevation: 4,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 26, vertical: 20),
                        color: Colors.white,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 80,
                                    width: 550,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Part Number",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Container(
                                            height: 40,
                                            padding:
                                                EdgeInsets.only(right: 100),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.all(10),
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                    color: Colors.black,
                                                  ))),
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 80,
                                    width: 550,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Location",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Container(
                                          height: 40,
                                          child: TextField(
                                            decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(10),
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                  color: Colors.black,
                                                ))),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Expanded(
                              child: buildContainer(context),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ]),
          ),
        ));
  }

  Container buildContainer(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .63,
      width: double.infinity,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: DataTable(
                columnSpacing: 15,
                headingRowHeight: 70,
                dataRowHeight: 60,
                showBottomBorder: true,
                columns: [
                  DataColumn(
                      label: Expanded(
                          child: Text(
                    "Part No",
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ))),
                  DataColumn(
                      label: Expanded(
                          child: Text(
                    "Company",
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ))),
                  DataColumn(
                      label: Expanded(
                          child: Text(
                    "Location",
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ))),
                  DataColumn(
                      label: Expanded(
                          child: Text(
                    "Location Type",
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ))),
                  DataColumn(
                      label: Expanded(
                          child: Text(
                    "Month",
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ))),
                  DataColumn(
                      label: Expanded(
                          child: Text(
                    "Year",
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ))),
                  DataColumn(
                      label: Expanded(
                          child: Text(
                    "Displayed Quantity",
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ))),
                  DataColumn(
                      label: Expanded(
                          child: Text(
                    "Actual Quantity",
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ))),
                  DataColumn(
                      label: Expanded(
                          child: Text(
                    "Last Verified Date / Comment",
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ))),
                  DataColumn(
                      label: Expanded(
                          flex: 2,
                          child: Text(
                            "Comment",
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ))),
                  DataColumn(
                      label: Expanded(
                          child: Text(
                    "Action",
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ))),
                ],
                rows: List<DataRow>.generate(11, (index) {
                  return DataRow(
                      color: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        // Even rows will have a grey color.
                        if (index % 2 == 0) return Color(0xffF9F9F9);
                        return Colors.white;
                      }),
                      cells: [
                        DataCell(Center(
                            child: Text(
                          "100812",
                          softWrap: true,
                        ))),
                        DataCell(Center(
                          child: Text(
                            "Imperial AutoIndustries Ltd",
                            softWrap: true,
                          ),
                        )),
                        DataCell(Center(child: Text("AIR7A3"))),
                        DataCell(Center(child: Text("Active"))),
                        DataCell(Center(child: Text("AUG"))),
                        DataCell(Center(child: Text("2021"))),
                        DataCell(Center(child: Text("0"))),
                        DataCell(Center(
                            child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: actualQuantityController,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 14),
                                decoration: InputDecoration(
                                    // border: OutlineInputBorder(
                                    //     borderSide: BorderSide(color: Colors.black))
                                    ),
                              ),
                            ),
                          ],
                        ))),
                        DataCell(Center(child: Text("10/08/2021"))),
                        DataCell(Center(
                          child: Container(
                              child: TextField(
                            maxLines: 2,
                            textAlignVertical: TextAlignVertical.center,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14),
                            controller: commentsController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 5, top: 5),
                              // border:
                              // OutlineInputBorder(
                              //     borderSide:
                              //         BorderSide(color: Colors.black))
                            ),
                          )),
                        )),
                        DataCell(Row(
                          children: [
                            Container(
                              height: 30,
                              width: 52,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.green)),
                              child: Image.asset(
                                  'assets/images/inventory-accept.png'),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              height: 30,
                              width: 52,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xffFF5555))),
                              child: Image.asset(
                                  'assets/images/inventory-exit.png'),
                            )
                          ],
                        )),
                      ]);
                })),
          ),
        ],
      ),
    );
  }
}
