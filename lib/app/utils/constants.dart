import 'package:flutter/material.dart';

Color kPrimaryColor = const Color(0xff0097A5);
Color kLightFontColor = const Color(0xff767676);
Color kDarkFontColor = const Color(0xff5E6672);
Color kThemeGreenFontColor = const Color(0xff31C7B2);
Color kThemeBlueFontColor = const Color(0xff32C5D2);
Color kBorderColor = Colors.black.withOpacity(0.3);

//Base URL
String kBaseURL = 'http://wmsqa.softcube.in/api/';
String kBaseURLForPath = 'http://wmsqa.softcube.in';

//Error messages
String kErrorWithRes = 'Error With Response.';

//Routes
String kInitialRoute = '/';
String kLoginRoute = '/LoginScreen';
String kPickOrderHomeRoute = '/PickItemScreen';
String kPickOrderListRoute = '/PickOrderListScreen';
String kPalletViewScreenRoute = '/PalletViewScreen';
String kPalletScreenEditRoute = '/PalletScreenEdit';
String kVerifyShippingHomeScreen = '/ShippingVerificationScreen';
String kVerifyEditRoute = '/VerifyScreen';
String kInventoryAudit = '/InventoryAudit';
String kCamera = '/Camera';

const kImagePath = 'assets/images/';

final Image kImgAppIconSmall = Image.asset(kImagePath + 'app-icon-small.png',fit: BoxFit.contain);
final Image kImgAppIconBig = Image.asset(kImagePath + 'app-icon-big.png',fit: BoxFit.contain);
final Image kImgDropDown = Image.asset(kImagePath + 'drop-down-icon.png',fit: BoxFit.contain);
final Image kImgNotification = Image.asset(kImagePath + 'notification-icon.png',fit: BoxFit.contain);
final Image kImgBannerBG = Image.asset(kImagePath + 'banner-bg.png',fit: BoxFit.contain);

final Image kImgCompanyIcon = Image.asset(kImagePath + 'company-icon.png',fit: BoxFit.contain);
final Image kImgCustomerIcon = Image.asset(kImagePath + 'customer-icon.png',fit: BoxFit.contain);
final Image kImgCustomerLocationIcon = Image.asset(kImagePath + 'customer-location-icon.png',fit: BoxFit.contain);
final Image kImgDateIcon = Image.asset(kImagePath + 'date-icon.png',fit: BoxFit.contain);
final Image kImgStatusIcon = Image.asset(kImagePath + 'status-icon.png',fit: BoxFit.contain);
final Image kImgWarehouseIcon = Image.asset(kImagePath + 'warehouse-icon.png',fit: BoxFit.contain);
final Image kImgMenuListIcon = Image.asset(kImagePath + 'menu-list.png',fit: BoxFit.contain);

final Image kImgPopupViewIcon = Image.asset(kImagePath + 'view-popup-icon.png',fit: BoxFit.contain);
final Image kImgPopupPickOrderNoteIcon = Image.asset(kImagePath + 'pick-order-note-popup-icon.png',fit: BoxFit.contain);
final Image kImgPopupPickOrderPopup = Image.asset(kImagePath + 'pick-order-unlink-popup-icon.png',fit: BoxFit.contain);
final Image kImgPopupPick = Image.asset(kImagePath + 'pick-popup-icon.png.png',fit: BoxFit.contain);
final Image kImgPopupDelete = Image.asset(kImagePath + 'delete-popup-icon.png',fit: BoxFit.fitHeight);

final Image kImgPopupPickWhite = Image.asset(kImagePath + 'pick-popup-icon.png.png',fit: BoxFit.contain,color: Colors.white,);
final Image kImgPopupViewIconWhite = Image.asset(kImagePath + 'view-popup-icon.png',fit: BoxFit.contain,color: Colors.white,);

final Image kShippingEditIcon = Image.asset(kImagePath + 'edit-shiping-verificaiton-icon.png',fit: BoxFit.contain);
final Image kShippingInvoiceIcon = Image.asset(kImagePath + 'invoice-shiping-verificaiton-icon.png',fit: BoxFit.contain,color: Colors.white,);
final Image kCommonAppBarScanImage = Image.asset(kImagePath + 'scan-image.png');
final Image kImgAddIcon = Image.asset(kImagePath + 'add-icon.png',fit: BoxFit.contain);

double kFontRatio = 1.0;

double kBigFonts = 36 * kFontRatio;

double kFlexibleSize(double size){
  return size * kFontRatio;
}

 Widget kFlexibleSizedBox({double? width,double? height}){
  return SizedBox(height: kFlexibleSize(height ?? 0.0),width: kFlexibleSize(width ?? 0.0),);
}