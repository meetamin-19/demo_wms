import 'package:flutter/material.dart';
import 'package:demo_win_wms/app/providers/auth_provider.dart';
import 'package:demo_win_wms/app/screens/shipping_verification/shipping_verification_screen.dart';
import 'package:provider/provider.dart';
import 'package:demo_win_wms/app/utils/constants.dart';

class Menu extends StatelessWidget {
   Menu({Key? key}) : super(key: key);

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
      'title': 'Pick order line items',
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
    {
      'title': 'Tote order with label generation',
      'icon': Icon(
        Icons.label,
        color: color ?? Colors.white,
        size: size ?? 15,
      )
    },
    {
      'title': 'Container and Air receiving',
      'icon': Icon(
        Icons.add_shopping_cart,
        color: color ?? Colors.white,
        size: size ?? 15,
      )
    },
    {
      'title': 'Move',
      'icon': Icon(
        Icons.drive_file_move,
        color: color ?? Colors.white,
        size: size ?? 15,
      )
    },
    {
      'title': 'inventory Audit',
      'icon': Icon(
        Icons.description,
        color: color ?? Colors.white,
        size: size ?? 15,
      )
    },
    {
      'title': 'quality orders',
      'icon': Icon(
        Icons.high_quality,
        color: color ?? Colors.white,
        size: size ?? 15,
      )
    },
  ];

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    return Container(
      width: _width * 0.25,
      height: double.infinity,
      color: kPrimaryColor,
      child: ListView.builder(
        itemCount: Menu.items().length + 1,
        itemBuilder: (context, index) {

          if (index == Menu.items().length){
            return InkWell(
              onTap: (){
                context.read<AuthProviderImpl>().logOutUser();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 5),
                child: Row(
                  children: [
                    SizedBox(width: 10),
                    Icon(Icons.logout,color: Colors.white,),
                    SizedBox(width: 10),
                    Expanded(child: Text('Logout',style: TextStyle(color: Colors.white),)),
                  ],
                ),
              ),
            );
          }

          return InkWell(
            onTap: (){
              if (index == 1){
                Navigator.of(context).pushNamed(kPickOrderHomeRoute);
              }else if (index == 2){
                Navigator.of(context).pushNamed(KVerifyShippingHomeScreen);
              }else if(index == 6) {
                Navigator.pushNamed(context, kInventoryAudit);
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 5),
              child: Row(
                children: [
                  SizedBox(width: 10),
                  Menu.items(size: 20)[index]['icon'],
                  SizedBox(width: 10),
                  Expanded(child: Text(Menu.items()[index]['title'],style: TextStyle(color: Colors.white),)),
                ],
              ),
            ),
          );
        },),
    );
  }
}
