import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class SideMenuColumnWidget extends StatelessWidget {
   SideMenuColumnWidget(this.ctx, {Key? key}) : super(key: key);

  final BuildContext ctx;
  static List items({Color? color,double? size}) => [

    {
      'title': 'Warehouse Associates',
      'icon': Icon(
        Icons.menu,
        color: color ?? Colors.white,
        size: size ?? 15,
      )
    },

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
    }
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

  List<String> listOfWidgets = [kInitialRoute, kPickOrderHomeRoute, kVerifyShippingHomeScreen];
  @override
  Widget build(BuildContext context) {
    return Container(
          height: MediaQuery.of(context).size.height - kToolbarHeight,
          width: 60,
          color: const Color(0xff5E6672),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 17,
              ),
              Builder(
                  builder: (context) {
                    return InkWell(onTap: () {
                      Scaffold.of(context).openDrawer();
                    }, child:
                    items(size: 24)[0]["icon"]);
                    // Icon(Icons.menu,size: 24,color: Colors.white,));
                  }
              ),
              for(int i = 1; i< items().length; i++)
                InkWell(
                  onTap: () {
                    var route = ModalRoute.of(context);
                    bool isSameRoute = false;
                    if (route != null) {
                      route.settings.name == listOfWidgets[i-1] ? isSameRoute = true : isSameRoute = false;
                    }
                    if(!isSameRoute) Navigator.pushNamed(context, listOfWidgets[i - 1]);
                  },
                  child: {
                  Container(
                    padding: const EdgeInsets.only(top: 21),
                    child: items(size: 24)[i]["icon"],
                  )
                }.first,
              ),

              // SizedBox(
              //   height: 20,
              // ),
              // Icon(Icons.add,size: 24,color: Colors.white,),
              // SizedBox(
              //   height: 20,
              // ),
              // Icon(Icons.access_time_outlined,size: 24,color: Colors.white,)
            ],
          )
    );
  }
}
