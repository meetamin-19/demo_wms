import 'package:demo_win_wms/app/utils/user_prefs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:demo_win_wms/app/data/entity/res/res_pick_order_list_get.dart';
import 'package:demo_win_wms/app/utils/constants.dart';
import 'package:demo_win_wms/app/utils/responsive.dart';
import 'package:demo_win_wms/app/views/custom_popup_view.dart';

class PickOrderListView extends StatelessWidget {
  PickOrderListView(
      {Key? key,
      this.data,
      required this.changeStatus,
      this.linkOrder,
      this.unLinkOrder,
      this.deleteOrder,
      this.addNote,
      this.view,
      this.pick})
      : super(key: key);

  final ResPickOrderListGetData? data;

  final Function changeStatus;
  final Function? linkOrder;
  final Function? unLinkOrder;
  final Function? deleteOrder;
  final Function? addNote;
  final Function? view;
  final Function? pick;
  LocalUser? userData;

  getUserData() async {
    userData = await UserPrefs.shared.getUser;
  }

  @override
  Widget build(BuildContext context) {
    // final isDesktop = Responsive.isDesktop(context);

    final isMobile = Responsive.isMobile(context);

    final _size = MediaQuery.of(context).size;

    final width = isMobile ? _size.width / 2.6 : kFlexibleSize(170);

    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      padding: EdgeInsets.all(kFlexibleSize(10)),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Wrap(
            children: [
              listElement(width: width, title: 'Sales Order No :', value: data?.soNumber ?? ''),
              listElement(width: width, title: 'Company :', value: data?.companyName ?? ''),
              listElement(width: width, title: 'Customer Location :', value: data?.customerLocation ?? ''),
              listElement(width: width, title: 'Ship Date :', value: data?.shippingDate ?? '', hasDateIcon: true),
              listElement(width: width, title: 'Created On :', value: data?.createdDate ?? '', hasDateIcon: true),
              listElement(
                  width: width, title: 'Completed On :', value: data?.completedOn ?? '-', hasDateIcon: true),
              listElement(width: width, title: 'Customer :', value: data?.customerName ?? ''),
              listElement(width: width, title: 'Warehouse :', value: data?.warehouseName ?? ''),
              listElement(width: width, title: 'Carrier (Ship Via) :', value: data?.shipperName ?? ''),
              pickOrderButton(context)
            ],
          )),
          popupButton(context, data)
        ],
      ),
    );
  }

  PopupMenuButton<dynamic> popupButton(BuildContext context, ResPickOrderListGetData? data) {
    final isPickInProgress = data?.statusTerm == 'Pick In Progress';
    // bool? isLinkBtn;
    getUserData();
    PopupMenuItem? linkUnlinkBtn() {
      if (data?.statusTerm != "" && data?.statusTerm!.toUpperCase() == "PICK ORDER ACKNOWLEDGED") {
        if (data?.isPickOrderLinkedOrNot == true &&
            (data?.isAbleToPickOrNot == true ||
                userData?.userType_Term == "Super Admin" ||
                data?.isPickOrderAcknowledegerOrNot == true)) {
          return menuBox(value: 'unlink', text: 'Pick Order Unlink', icon: kImgPopupPickOrderPopup);
        } else {
          if ((data?.isPickOrderAcknowledegerOrNot == true || userData?.userType_Term == "Super Admin") &&
              data?.isAbleToAcknowledge == true) {
            return menuBox(value: 'link', text: 'Pick Order Link', icon: kImgPopupPickOrderPopup);
          }
        }
      } else {
        if (kDebugMode) {
          print(userData?.userType_Term);
        }
        if (data?.isPickOrderLinkedOrNot == true &&
            (data?.isAbleToPickOrNot == true ||
                userData?.userType_Term == "Super Admin" ||
                data?.isPickOrderAcknowledegerOrNot == true) &&
            data?.isAbleToAcknowledge == true) {
          return menuBox(value: 'unlink', text: 'Pick Order Unlink', icon: kImgPopupPickOrderPopup);
        }
      }
      return null;

      // if (isLinkBtn == false) {
      //   menuBox(value: 'unlink', text: 'Pick Order Unlink', icon: kImgPopupPickOrderPopup);
      // } else if (isLinkBtn == true) {
      //   menuBox(value: 'link', text: 'Pick Order Link', icon: kImgPopupPickOrderPopup);
      // }
      // return null;
    }

    PopupMenuItem? pickBtn() {
      if (isPickInProgress) {
        if (data?.isPoAlreadyLinkOrNot == true) {
          if (data?.isPickOrderLinkedOrNot == true) {
            if (data?.isAbleToPickOrNot == true) {
              return menuBox(value: 'pick', text: 'Pick', icon: kImgPopupPick);
            }
          } else {
            if ((data?.isPickOrderAcknowledegerOrNot == true || userData?.userType_Term == "Super Admin") &&
                data?.isAbleToAcknowledge == true) {
              return menuBox(value: 'link', text: 'Pick Order Link', icon: kImgPopupPick);
            }
          }
        }
      }
      return null;
    }

    PopupMenuItem? pickOrderAcknowledge() {
      if ((data?.statusTerm != '') &&
          data?.statusTerm?.toUpperCase() == "PICK ORDER ISSUED" &&
          data?.isAbleToAcknowledge == true) {
        return menuBox(value: "pickOrderAcknowledge", text: "Pick Order Acknowledge", icon: kImgPopupPick);
      }
      return null;
    }


    return PopupMenuButton(
        padding: EdgeInsets.zero,
        offset: Offset.zero,
        child: SizedBox(
          child: kImgMenuListIcon,
          height: kFlexibleSize(20),
        ),
        onSelected: (value) async {
          if (kDebugMode) {
            print(value);
          }

          if (value == 'view') {
            if (view != null) {
              view!();
            }
          }

          if (value == 'pickOrderAcknowledge') {
            if (linkOrder != null) {
              linkOrder!();
            }
          }

          if (value == 'pick') {
            if (pick != null) {
              pick!();
            }
          }

          if (value == 'link') {
            if (linkOrder != null) {
              linkOrder!();
            }
          }

          if (value == 'unlink') {
            if (unLinkOrder != null) {
              unLinkOrder!();
            }
          }

          if (value == 'delete') {
            if (deleteOrder != null) {
              deleteOrder!();
            }
          }

          if (value == 'note') {
            if (addNote != null) {
              addNote!();
            }
          }
        },
        itemBuilder: (context) => [
              // if(data?.)
              menuBox(value: 'view', text: 'View', icon: kImgPopupViewIcon),

              if (data?.isInvoiceIsCreatedOrNot == false)
                menuBox(value: 'note', text: 'Pick Order Note', icon: kImgPopupPickOrderNoteIcon),

              if (linkUnlinkBtn() != null) linkUnlinkBtn()!,

              if (pickOrderAcknowledge() != null) pickOrderAcknowledge()!,

              if (pickBtn() != null) pickBtn()!,

              if (data?.isPickOrderIsPickedOrNot == false)
                menuBox(value: 'delete', text: 'Delete', icon: kImgPopupDelete),
            ]);
  }

  Column pickOrderButton(BuildContext context) {

    Widget clickableStatusTerm() {
      return InkWell(
          onTap: () {
            CustomPopup(context,
                title: 'Change Pick Order Status',
                message: 'Are you sure you want to change status of Pick Order Issued to Pick In Progress?',
                primaryBtnTxt: 'Yes',
                secondaryBtnTxt: 'Close', primaryAction: () {
              changeStatus();
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(20)),
            child: Text(
              '${data?.statusTerm} (${data?.pickedByUserName ?? ''}) ',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: kFlexibleSize(14),
                  color: Colors.white,
                  decoration: null),
            ),
          ));
    }

    Widget pickedStatusContainer() {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(20)),
        child: Text(
          '${data?.statusTerm} (${data?.pickedByUserName ?? ''}) ',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: kFlexibleSize(14),
              color: Colors.blue,
              decoration: null),
        ),
      );
    }

    Widget basicStatusText() {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(20)),
        child: Text(
          '${data?.statusTerm}',
          style:
              TextStyle(fontWeight: FontWeight.w600, fontSize: kFlexibleSize(14), color: Colors.blue, decoration: null),
        ),
      );
    }

    Widget statusText() {
      if (data?.statusTerm != '' && data?.statusTerm?.toUpperCase() == "PICK ORDER ACKNOWLEDGED") {
        if (data?.pickedByUserName != '' && data?.isAbleToPickOrNot == true) {
          return clickableStatusTerm();
        } else {
          if (data?.pickedByUserName != '' && data?.pickedByUserName != null) {
            return pickedStatusContainer();
          } else {
           return basicStatusText();
          }
        }
      } else if (data?.statusTerm != '' && data?.statusTerm?.toUpperCase() == "COMPLETED / SHORT" ||
          data?.statusTerm?.toUpperCase() == "COMPLETED / OVER" ||
          data?.statusTerm?.toUpperCase() == "COMPLETED / EXACT") {
        return clickableStatusTerm();
      } else if (data?.pickedByUserName != '' && data?.pickedByUserName != null) {
       return pickedStatusContainer();
      } else {
        return basicStatusText();
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pick Order Status :',
          maxLines: 1,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: kFlexibleSize(14)),
        ),
        SizedBox(height: kFlexibleSize(5)),
        statusText()
      ],
    );
  }

  PopupMenuItem menuBox({required String value, required String text, required Widget icon}) {
    return PopupMenuItem<String>(
      child: SizedBox(
        width: kFlexibleSize(150),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: kFlexibleSize(16), child: icon),
            const SizedBox(width: 10),
            Expanded(
                child: Text(
              text,
              maxLines: 2,
              style: TextStyle(fontSize: kFlexibleSize(14), fontWeight: FontWeight.w400),
            )),
          ],
        ),
      ),
      value: value,
    );
  }

  Widget listElement({required double width, required String title, required String value, bool? hasDateIcon}) {
    return Padding(
      padding: EdgeInsets.only(bottom: kFlexibleSize(15), right: kFlexibleSize(15)),
      child: SizedBox(
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              maxLines: 1,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: kFlexibleSize(14)),
            ),
            SizedBox(height: kFlexibleSize(5)),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (hasDateIcon == true)
                  SizedBox(
                    child: kImgDateIcon,
                    height: kFlexibleSize(18),
                  ),
                if (hasDateIcon == true) SizedBox(width: kFlexibleSize(5)),
                Expanded(
                  child: Text(value,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: kFlexibleSize(14))),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
