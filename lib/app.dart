
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:demo_win_wms/app/screens/inventory_audit/inventory_audit_screen.dart';
import 'package:demo_win_wms/app/screens/pick_order/picked_line_items.dart';
import 'package:demo_win_wms/app/screens/pallet_screen_edit/pallet_screen_edit.dart';
import 'package:demo_win_wms/app/screens/pallet_screen_view//pallet_screen.dart';
import 'package:demo_win_wms/app/screens/pick_order_list/pick_order_list_screen.dart';
import 'package:demo_win_wms/app/screens/shipping_verification/components/camera_pop_up.dart';
import 'package:demo_win_wms/app/screens/shipping_verification/shipping_verification_screen.dart';
import 'package:demo_win_wms/app/screens/shipping_verification/shipping_verify_edit_screen.dart';
import 'app/screens/login/login_screen.dart';
import 'app/screens/lending_page.dart';
import 'app/utils/constants.dart';

Widget app(){
  return MaterialApp(
    title: 'WMS',
    debugShowCheckedModeBanner: false,
    debugShowMaterialGrid: false,
    theme: ThemeData(
      fontFamily: 'kRegularFonts',
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          foregroundColor: Colors.black,
          // centerTitle: true,
          titleTextStyle: const TextStyle(
            // fontFamily: kRegularFonts,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black
          ),
      ),
      scaffoldBackgroundColor: Color(0XffE5E5E5),
      primarySwatch: Colors.teal,
    ),
    initialRoute: kInitialRoute,
    routes: {
      kInitialRoute: (context) => LendingPage(),
      kLoginRoute: (context) => LoginScreen(),
      kPickOrderHomeRoute: (context) => PickedLineItem(),
      kPickOrderListRoute: (context) => PickOrderListScreen(),
      kPalletViewScreenRoute: (context) => PalletScreenView(),
      kPalletScreenEditRoute: (context) => PalletScreenEdit(),
      KVerifyShippingHomeScreen: (context) => ShippingVerificationScreen(),
      KVerifyEditRoute: (context) => ShippingVerifyEditScreen(),
      kInventoryAudit : (context) => InventoryAuditScreen(),
      // kCamera : (context) => MyAppCamera(),
    },
  );
}