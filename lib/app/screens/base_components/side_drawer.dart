import 'package:flutter/material.dart';
import 'package:demo_win_wms/app/providers/auth_provider.dart';
import 'package:demo_win_wms/app/screens/shipping_verification/shipping_verification_screen.dart';
import 'package:provider/provider.dart';
import 'package:demo_win_wms/app/utils/constants.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  static List items({Color? color,double? size}) => [
    {
      'title': 'Dashboard',
      'icon': Icon(
        Icons.dashboard,
        color: color ?? Colors.white,
        size: size ?? 15,
      )
    },
    {
      'title': 'Pick order',
      'icon': Icon(
        Icons.palette,
        color: color ?? Colors.white,
        size: size ?? 15,
      )
    },
    {
      'title': 'Shipping Verification',
      'icon': Icon(
        Icons.verified,
        color: color ?? Colors.white,
        size: size ?? 15,
      )
    },
    // {
    //   'title': 'Tote order with label generation',
    //   'icon': Icon(
    //     Icons.label,
    //     color: color ?? Colors.white,
    //     size: size ?? 15,
    //   )
    // },
    // {
    //   'title': 'Container and Air receiving',
    //   'icon': Icon(
    //     Icons.add_shopping_cart,
    //     color: color ?? Colors.white,
    //     size: size ?? 15,
    //   )
    // },
    // {
    //   'title': 'Move',
    //   'icon': Icon(
    //     Icons.drive_file_move,
    //     color: color ?? Colors.white,
    //     size: size ?? 15,
    //   )
    // },
    // {
    //   'title': 'inventory Audit',
    //   'icon': Icon(
    //     Icons.description,
    //     color: color ?? Colors.white,
    //     size: size ?? 15,
    //   )
    // },
    // {
    //   'title': 'quality orders',
    //   'icon': Icon(
    //     Icons.high_quality,
    //     color: color ?? Colors.white,
    //     size: size ?? 15,
    //   )
    // },
  ];

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    return DrawerTheme(
      data: const DrawerThemeData(
          backgroundColor: Color(0xff5E6672),
          scrimColor: Colors.transparent,
          elevation: 0.5),
      child: Drawer(
        child: ListView(
          children: [
            ListTile(
                onTap: () {
                  Navigator.pop(context);
                },
                leading: const Text(
                  "WareHouse Associates",
                  style: TextStyle(color: Colors.white),
                ),
                trailing: const Icon(
                  Icons.menu, color: Colors.white, size: 24,)
            ),
            // DrawerHeader(
            //   margin: EdgeInsets.all(0),
            //   padding: EdgeInsets.all(0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         "WareHouse Associates",
            //         style: TextStyle(color: Colors.white),
            //       ),
            //       InkWell(
            //         onTap: () {
            //           Navigator.pop(context);
            //         },
            //         child: Icon(
            //           Icons.menu,
            //           color: Colors.white,
            //         ),
            //       )
            //     ],
            //   ),
            // )),
            for(int i = 0; i< items().length; i++) {
              ListTile(

                onTap: () {
                  Navigator.pop(context);
                },
                leading: items(size: 24)[i]["icon"],
                title: Text(
                  items()[i]["title"],
                  style: TextStyle(color: Colors.white),
                ),
              )
            }.first,
            // ListTile(
            //   onTap: () {
            //     Navigator.pop(context);
            //   },
            //   leading: Icon(
            //     Icons.file_present,
            //     color: Colors.white,
            //   ),
            //   title: Text(
            //     "Sales",
            //     style: TextStyle(color: Colors.white),
            //   ),
            // ),
            // ListTile(
            //   onTap: () {
            //     Navigator.pop(context);
            //   },
            //   leading: Icon(
            //     Icons.file_present,
            //     color: Colors.white,
            //   ),
            //   title: Text(
            //     "Sales",
            //     style: TextStyle(color: Colors.white),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
