import 'package:demo_win_wms/app/data/entity/res/res_pickorder_link_user_list.dart';
import 'package:demo_win_wms/app/screens/base_components/sidemenu_column.dart';
import 'package:demo_win_wms/app/screens/pick_order/components/pick_order_link_user_dropdown.dart';
import 'package:demo_win_wms/app/views/custom_pop_up_with_dropdown.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:demo_win_wms/app/data/data_service/web_service.dart';
import 'package:demo_win_wms/app/data/entity/Res/res_pick_order_list_filter.dart';
import 'package:demo_win_wms/app/data/entity/res/res_pick_order_list_get.dart';
import 'package:demo_win_wms/app/providers/auth_provider.dart';
import 'package:demo_win_wms/app/providers/home_provider.dart';
import 'package:demo_win_wms/app/providers/pick_order_provider.dart';
import 'package:demo_win_wms/app/providers/service_provider.dart';
import 'package:demo_win_wms/app/screens/base_components/common_app_bar.dart';
import 'package:demo_win_wms/app/screens/pick_order/components/pick_order_home_listview.dart';
import 'package:demo_win_wms/app/screens/pick_order/components/pickup_filter_drop_down.dart';
import 'package:demo_win_wms/app/utils/constants.dart';
import 'package:demo_win_wms/app/utils/enums.dart';
import 'package:demo_win_wms/app/utils/responsive.dart';
import 'package:demo_win_wms/app/views/custom_popup_view.dart';
import 'package:demo_win_wms/app/views/custom_popup_with_text_field.dart';
import 'package:demo_win_wms/app/views/date_pick_view.dart';
import 'package:demo_win_wms/app/views/loading_small.dart';
import 'package:demo_win_wms/app/views/no_data_found.dart';
import 'package:demo_win_wms/app/utils/extension.dart';
import '../base_components/side_drawer.dart';
import 'components/pick_order_filter_button.dart';
import 'components/header_view.dart';
import 'package:provider/provider.dart';

class PickedLineItem extends StatefulWidget {
  const PickedLineItem({Key? key}) : super(key: key);

  @override
  State<PickedLineItem> createState() => _PickedLineItemState();
}

class _PickedLineItemState extends State<PickedLineItem> {
  GlobalKey scaffoldKey = GlobalKey();
  var focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Add Your Code here.
      await fetchFilters();
      fetchPickList();
    });
  }

  fetchFilters() async {
    try {
      final home = context.read<ServiceProviderImpl>();
      await home.getPickupFilters();
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
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0XffE5E5E5),
      appBar: CommonAppBar(hasLeading: true, hasBackButton: false),
      body: Scaffold(
        body: body(context),
        drawer: DrawerWidget(),
      ),
    );
  }

  Company? selectedCompany;
  Company? selectedCustomer;
  Company? selectedWarehouse;
  Company? selectedCustomerLocation;
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  Company? selectedShipVia;
  Company? selectedStatus;

  int? totalCount;
  int itemCount = 1;
  int pageLimit = 100;
  bool isScreenLoading = false;

  String? dropdownValue;

  void getTotalCount() async {
    final home = context.read<HomeProvider>();

    try {
      setState(() {
        totalCount = home.pickOrderList?.data?.data?.first.totalCount ?? 0;
        itemCount = (totalCount == null || totalCount == 0) ? 1 : (totalCount! / pageLimit).ceil();
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  fetchPickList() async {
    try {
      final home = context.read<HomeProvider>();
      await home.getPickerList(
          company: selectedCompany,
          cusLoc: selectedCustomerLocation,
          customer: selectedCustomer,
          warehouse: selectedWarehouse,
          shipVia: selectedShipVia,
          status: dropdownValue == "Complete / Closed"
              ? dropdownValue = "Completed / Short, Completed / Over, Completed / Exact, Pick Order Completed"
              : dropdownValue,
          startDate: selectedStartDate,
          endDate: selectedEndDate,
          listStartAt: selectedStartPoint,
          numOfResults: pageLimit.toString());
      filterData(context, searchText!);
      getTotalCount();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  getLinkOrderUsers({required ResPickOrderListGetData data}) async {
    setState(() {
      isScreenLoading = true;
    });

    try {
      final home = context.read<HomeProvider>();
      await home.getPickOrderLinkUserList(id: data.pickOrderId ?? 0);

      // gotSearchList(data: data);

      setState(() {
        isScreenLoading = false;
      });
    } catch (e) {
      setState(() {
        isScreenLoading = false;
      });
    }
  }

  // gotSearchList({ResPickOrderListGetData? data}) {
  //   final home = context.read<HomeProvider>();
  //
  //   final searchList = home.assignedToUserList?.data?.data
  //       ?.map((e) => SearchModel(id: int.parse(e.value ?? '0'), title: e.text ?? ''))
  //       .toList();
  //
  //   callSearchList(
  //       context: context,
  //       searchList: searchList!,
  //       selectedObject: (obj) async {
  //         try {
  //           CustomPopup(context,
  //               title: 'Link Pick Order',
  //               message: 'Are you sure you want to link pick order for ${obj.title} ?',
  //               primaryBtnTxt: 'Yes',
  //               primaryAction: () async {
  //                 linkOrder(assignToId: obj.id.toString(), data: data);
  //               },
  //               secondaryBtnTxt: 'Close',
  //               secondaryAction: () {
  //                 gotSearchList(data: data);
  //               });
  //         } catch (e) {
  //           setState(() {
  //             isScreenLoading = false;
  //           });
  //         }
  //       });
  // }

  Future linkOrder({ResPickOrderListGetData? data, required String assignToId}) async {
    final home = context.read<HomeProvider>();

    setState(() {
      isScreenLoading = true;
    });

    await home.pickorderInsertUpdateLinkPickOrder(data: data, assignToId: assignToId);

    if (home.linkUser?.state == Status.COMPLETED) {
      fetchPickList();
    }
    setState(() {
      isScreenLoading = false;
    });
  }

  unLinkOrder({required ResPickOrderListGetData data}) async {
    setState(() {
      isScreenLoading = true;
    });

    try {
      final home = context.read<HomeProvider>();
      await home.pickorderInsertUpdateUnlinkPickOrder(data: data);

      if (home.unLinkUser?.state == Status.COMPLETED) {
        fetchPickList();
      }

      setState(() {
        isScreenLoading = false;
      });
    } catch (e) {
      setState(() {
        isScreenLoading = false;
      });
    }
  }

  deletePickOrder({required ResPickOrderListGetData data}) async {
    setState(() {
      isScreenLoading = true;
    });

    try {
      final home = context.read<HomeProvider>();
      await home.deletePickOrder(data: data);

      setState(() {
        isScreenLoading = false;
      });
    } catch (e) {
      setState(() {
        isScreenLoading = false;
      });
    }
  }

  getPickOrderNoteText({required ResPickOrderListGetData data}) async {
    setState(() {
      isScreenLoading = true;
    });

    try {
      final home = context.read<HomeProvider>();
      await home.getPickOrderNoteText(pickOrderId: data.pickOrderId);
      setState(() {
        isScreenLoading = false;
      });
    } catch (e) {
      setState(() {
        isScreenLoading = false;
      });
    }
  }

  savePickOrderNoteText({required ResPickOrderListGetData data, required String pickOrderNote}) async {
    setState(() {
      isScreenLoading = true;
    });

    try {
      final home = context.read<HomeProvider>();
      await home.savePickOrderNote(
          pickOrderNote: pickOrderNote, updateLog: data.updatelog, pickOrderId: data.pickOrderId);

      if (home.savePickOrderNoteVar?.state == Status.ERROR) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Pick Order note was not saved . Please refresh and try again.")));
      }

      if(home.savePickOrderNoteVar?.state == Status.COMPLETED){
        fetchPickList();
      }


      setState(() {
        isScreenLoading = false;
      });
    } catch (e) {
      setState(() {
        isScreenLoading = false;
      });
    }
  }

  String? searchText = "";
  int startingIndex = 1;
  int selectedIndex = 1;
  String? selectedRange = "100";
  String? selectedStartPoint = "0";

  BoxDecoration unselectedBox =
  BoxDecoration(color: const Color(0xffE5E5E5).withOpacity(0.5), borderRadius: const BorderRadius.all(const Radius.circular(3)));

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
                    fetchPickList();
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

                        if (index == 5 && startingIndex != itemCount- 6) {
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
                                startingIndex = itemCount- 6;
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
                      itemCount: itemCount>= 7 ? 7 : itemCount,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          if(itemCount <= 7) {
                            startingIndex = 1;
                          }
                          else{
                            if (startingIndex + 8 < itemCount) {
                              startingIndex += 1;
                            } else {
                              if (itemCount- 7 > 0) {
                                startingIndex = itemCount- 6;
                              } else {
                                startingIndex = itemCount - 7;
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
    fetchPickList();
  }

  Widget body(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return Stack(
      fit: StackFit.expand,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SideMenuColumnWidget(context),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(_size.width * 0.015),
                  child: Column(
                    children: [
                      //Tpo Headers
                      const Responsive(
                        mobile: HeaderView(
                          crossAxisCount: 2,
                          childAspectRatio: 2.75,
                        ),
                        tablet: HeaderView(
                          childAspectRatio: 2.752,
                          crossAxisCount: 4,
                        ),
                        desktop: HeaderView(
                          childAspectRatio: 2.75,
                          crossAxisCount: 4,
                        ),
                      ),
                      const SizedBox(height: 10),

                      //Filters
                      filters(context),
                      pages(context),

                      listView(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        if (isScreenLoading)
          Container(
            color: Colors.black12,
            child: Center(
              child: Container(
                  height: 50,
                  width: 50,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                  child: LoadingSmall()),
            ),
          ),
      ],
    );
  }

  Widget listView() {
    final home = context.watch<HomeProvider>();

    final isLoading = home.pickOrderList?.state == Status.LOADING;
    final isStatusLoading = home.statusChange?.state == Status.LOADING;
    final hasError = home.pickOrderList?.state == Status.ERROR;

    if (isLoading || isStatusLoading) {
      return Container(
        width: double.infinity,
        height: 400,
        color: Colors.white,
        child: LoadingSmall(),
      );
    }

    if (hasError || home.pickOrderList?.data?.data?.isEmpty == true) {
      return Container(
        width: double.infinity,
        height: 400,
        color: Colors.white,
        child: NoDataFoundView(
          title: 'No Data Found',
          retryCall: () {
            setState(() {
              selectedCompany = null;
              selectedCustomer = null;
              selectedCustomerLocation = null;
              selectedStartDate = null;
              selectedEndDate = null;
              selectedShipVia = null;
              selectedStatus = null;
            });
            fetchPickList();
          },
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: home.filteredPickOrderList?.length ?? 0,
      // itemCount: home.pickOrderList?.data?.data?.length ?? 0,
      itemBuilder: (context, index) {
        return PickOrderListView(
          data: home.filteredPickOrderList?[index],
          changeStatus: () async {
            try {
              await home.changePickOrderStatus(id: home.pickOrderList?.data?.data?[index].pickOrderId ?? 0);
            } catch (e) {
              if (scaffoldKey.currentState?.context != null) {
                ScaffoldMessenger.of(scaffoldKey.currentState!.context)
                    .showSnackBar(SnackBar(content: Text(e.toString())));
              }
            }
            fetchPickList();
          },
          unLinkOrder: () {
            CustomPopup(context,
                title: 'Unlink Pick Order',
                message: 'Are you sure you want to Unlink Pick Order?',
                primaryBtnTxt: 'Yes', primaryAction: () {
              if (home.pickOrderList?.data?.data?[index] != null) {
                unLinkOrder(data: home.pickOrderList!.data!.data![index]);
              }
            }, secondaryBtnTxt: 'Close');
          },
          linkOrder: () async {
            PickOrderLinkUser? selectedUser;
            await getLinkOrderUsers(data: home.pickOrderList!.data!.data![index]);

            if (kDebugMode) {
              print(home.assignedToUserList?.data?.data?.userList);
            }
            CustomPopUpWithDropDown(context, primaryBtnTxt: 'Save', secondaryBtnTxt: 'Cancel', primaryAction: () {
              if (selectedUser != null) {
                linkOrder(data: home.pickOrderList!.data!.data![index], assignToId: selectedUser!.value!);
              } else {
                if (kDebugMode) {
                  print("selected User null");
                }
              }
            },
                title: 'Pick Order Acknowledge',
                message: 'Acknowledge to',
                dropdownWidget: home.assignedToUserList?.data?.data?.userList != null
                    ? PickOrderLinkUserDropDown(
                        data: home.assignedToUserList!.data!.data!.userList!,
                        onChange: (user) {
                          setState(() {
                            selectedUser = user;
                            if (kDebugMode) {
                              print(selectedUser?.value);
                            }
                          });
                        },
                        hint: 'Select User',
                      )
                    : const Text("Something went wrong in getting user list"));
          },
          deleteOrder: () {
            CustomPopup(context, title: 'Delete', message: 'Are you sure you want to delete ?', primaryBtnTxt: 'Yes',
                primaryAction: () {
              if (home.pickOrderList?.data?.data?[index] != null) {
                deletePickOrder(data: home.pickOrderList!.data!.data![index]);
              }
            }, secondaryBtnTxt: 'Close');
          },
          addNote: () async {
            if (home.pickOrderList?.data?.data?[index] != null) {
              await getPickOrderNoteText(data: home.pickOrderList!.data!.data![index]);
            }

            if (home.getPickOrderNote?.state == Status.COMPLETED) {
              CustomPopupWithTextField(context,
                  text: home.getPickOrderNote?.data?.data?.pickOrder?.pickOrderNote ?? '',
                  title: 'Pick Order Note',
                  message: 'View or Edit Pick Order Note',
                  primaryBtnTxt: 'Save',
                  hint: 'Enter Pick Order Note',
                  secondaryBtnTxt: 'Close', primaryAction: (pickOrderNote) {
                savePickOrderNoteText(data: home.pickOrderList!.data!.data![index], pickOrderNote: pickOrderNote);
              });
            }
          },
          pick: () {
            final pickOrder = this.context.read<PickOrderProviderImpl>();

            pickOrder.isInEditingMode = true;

            if (home.pickOrderList?.data?.data?[index] != null) {
              final data = home.pickOrderList?.data?.data?[index];

              pickOrder.pickOrderID = data?.pickOrderId ?? 0;
              pickOrder.salesOrderID = data?.salesOrderId ?? 0;

              pickOrder.getPickOrderData();
              pickOrder.getSalesOrderList();
            }

            Navigator.of(context).pushNamed(kPickOrderListRoute, arguments: true);
          },
          view: () {
            final pickOrder = this.context.read<PickOrderProviderImpl>();

            pickOrder.isInEditingMode = false;

            if (home.pickOrderList?.data?.data?[index] != null) {
              final data = home.pickOrderList?.data?.data?[index];

              pickOrder.pickOrderID = data?.pickOrderId ?? 0;
              pickOrder.salesOrderID = data?.salesOrderId ?? 0;

              pickOrder.getPickOrderData();
              pickOrder.getSalesOrderList();
            }

            Navigator.of(context).pushNamed(kPickOrderListRoute, arguments: false);
          },
        );
      },
    );
  }

  Widget filters(BuildContext context) {
    final service = context.watch<ServiceProviderImpl>();

    final isLoading = service.pickOrderFilters?.state == Status.LOADING;

    final hasError = service.pickOrderFilters?.state == Status.ERROR;

    if (isLoading) {
      return Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          height: 50,
          color: Colors.white,
          child: Center(child: LoadingSmall()));
    }

    if (hasError) {
      return NoDataFoundView(
        title: service.pickOrderFilters?.msg ?? '',
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
            if (service.pickOrderFilters?.data?.data?.company != null)
              PickUpFilterDropDown(
                  data: service.pickOrderFilters!.data!.data!.company!,
                  selectedValue: selectedCompany,
                  hint: 'Company',
                  onChange: (company) {
                    selectedCompany = company;
                  },
                  icon: kImgCompanyIcon),
            if (service.pickOrderFilters?.data?.data?.customer != null)
              PickUpFilterDropDown(
                  data: service.pickOrderFilters!.data!.data!.customer!,
                  selectedValue: selectedCustomer,
                  hint: 'Customer',
                  onChange: (company) {
                    selectedCustomer = company;
                  },
                  icon: kImgCustomerIcon),
            if (service.pickOrderFilters?.data?.data?.warehouse != null)
              PickUpFilterDropDown(
                  data: service.pickOrderFilters!.data!.data!.warehouse!,
                  selectedValue: selectedWarehouse,
                  hint: 'Warehouse',
                  onChange: (company) {
                    selectedWarehouse = company;
                  },
                  icon: kImgWarehouseIcon),
            if (service.pickOrderFilters?.data?.data?.customerLocation != null)
              PickUpFilterDropDown(
                  data: service.pickOrderFilters!.data!.data!.customerLocation!,
                  selectedValue: selectedCustomerLocation,
                  hint: 'Customer Location',
                  onChange: (company) {
                    selectedCustomerLocation = company;
                  },
                  icon: kImgCustomerLocationIcon),
            DatePickView(
                passedDate: selectedStartDate,
                title: selectedStartDate != null ? (selectedStartDate?.toStrCommonFormat() ?? '') : 'Ship Date Start',
                selectedDate: (date) {
                  setState(() {
                    selectedStartDate = date;
                  });
                }),
            DatePickView(
                passedDate: selectedEndDate,
                title: selectedEndDate != null ? (selectedEndDate?.toStrCommonFormat() ?? '') : 'Ship Date End',
                selectedDate: (date) {
                  setState(() {
                    selectedEndDate = date;
                  });
                }),
            if (service.pickOrderFilters?.data?.data?.shipVia != null)
              PickUpFilterDropDown(
                  data: service.pickOrderFilters!.data!.data!.shipVia!,
                  selectedValue: selectedShipVia,
                  hint: 'Ship Via',
                  onChange: (company) {
                    selectedShipVia = company;
                  },
                  icon: kImgDateIcon),

            dropdownForStatus(),

            //
            // if (service.pickOrderFilters?.data?.data?.status != null)
            //   PickUpFilterDropDown(
            //       data: service.pickOrderFilters!.data!.data!.status!,
            //       selectedValue: selectedStatus,
            //       hint: 'Status',
            //       onChange: (company) {
            //         selectedStatus = company;
            //       },
            //       icon: kImgStatusIcon),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black.withOpacity(0.1)),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white),
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
              bgColor: Colors.white,
              text: 'Apply',
              onTap: () {
                fetchPickList();
              },
            ),
            const SizedBox(
              width: 10,
              height: 10,
            ),
            PickOrderFilterButton(
              bgColor: Colors.white,
              text: 'Clear',
              onTap: () {
                setState(() {
                  dropdownValue = null;
                  selectedCompany = null;
                  selectedCustomer = null;
                  selectedCustomerLocation = null;
                  selectedStartDate = null;
                  selectedEndDate = null;
                  selectedShipVia = null;
                  selectedStatus = null;
                });
                fetchPickList();
              },
            ),
          ],
        )
      ],
    );
  }

  Container dropdownForStatus() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black.withOpacity(0.1)),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: Colors.white),
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.only(top: 1, bottom: 1, left: 10, right: 10),
      height: 44,
      width: kFlexibleSize(290),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(child: kImgStatusIcon, height: kFlexibleSize(20), width: kFlexibleSize(20)),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: DropdownButton<String>(
                hint: const Text("Status"),
                isExpanded: true,
                value: dropdownValue,
                elevation: 16,
                iconSize: 30,
                underline: const SizedBox(),
                onChanged: (String? newValue) {
                  setState(() {
                    if (dropdownValue != newValue) {
                      dropdownValue = newValue!;
                      if (kDebugMode) {
                        print(newValue);
                      }
                      // fetchList();
                    }
                  });
                },
                items: <String>[
                  'Pick Order Issued',
                  'Pick Order Acknowledged',
                  'Pick In Progress',
                  'Completed / Closed',
                  'Dispatched'
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

  Widget listUIS({required String key, required String value}) {
    return SizedBox(
      width: 180,
      child: Column(
        children: [Text(key), Text(value)],
      ),
    );
  }

  filterData(BuildContext context, String str) {
    context.read<HomeProvider>().searchFromPickOrderList(str: str);
  }
}
