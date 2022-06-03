import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demo_win_wms/providers_list.dart';

import 'app.dart';

void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return multiProvider();
  }
}

Widget multiProvider(){
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => authProvider),
      ChangeNotifierProvider(create: (_) => homeProvider),
      ChangeNotifierProvider(create: (_) => serviceProvider),
      ChangeNotifierProvider(create: (_) => pickOrder),
      ChangeNotifierProvider(create: (_) => palletProvider),
      ChangeNotifierProvider(create: (_) => shippingverificationProvider),
      ChangeNotifierProvider(create: (context) => containerListProvider,),
      ChangeNotifierProvider(create: (context) => receiveProcessProvider,)
    ],
    child: app(),
  );
}