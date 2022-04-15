import 'package:flutter/material.dart';
import 'package:demo_win_wms/app/screens/base_components/menu.dart';
import 'package:demo_win_wms/app/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final itemNames = [
    'Dashboard',
    'Pick order ',
    'Shipping Verification',
    // 'Tote order with label generation',
    // 'Container and Air receiving',
    // 'Move',
    // 'inventory Audit',
    // 'quality orders'
  ];

  final itemIcons = [
    Icon(
      Icons.dashboard,
      color: Colors.white,
    ),
    Icon(
      Icons.palette,
      color: Colors.white,
    ),
    Icon(
      Icons.verified,
      color: Colors.white,
    ),
    // Icon(
    //   Icons.label,
    //   color: Colors.white,
    // ),
    // Icon(
    //   Icons.add_shopping_cart,
    //   color: Colors.white,
    // ),
    // Icon(
    //   Icons.drive_file_move,
    //   color: Colors.white,
    // ),
    // Icon(
    //   Icons.description,
    //   color: Colors.white,
    // ),
    // Icon(
    //   Icons.high_quality,
    //   color: Colors.white,
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    final _width = MediaQuery.of(context).size.width;

    return Row(
      children: [
        Menu(),
        Expanded(
          child: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;

                return Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // TODO add Center Widget
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Wrap(
                          // crossAxisAlignment: WrapCrossAlignment.start,
                          spacing: 10.0,
                          runSpacing: 10.0,
                          children: List.generate(Menu.items().length, (index) {
                            return InkWell(
                              onTap: () {
                                if (index == 1) {
                                  Navigator.of(context)
                                      .pushNamed(kPickOrderHomeRoute);
                                } else if (index == 2) {
                                  Navigator.of(context)
                                      .pushNamed(KVerifyShippingHomeScreen);
                                } else if (index == 6) {
                                  Navigator.of(context)
                                      .pushNamed(kInventoryAudit);
                                }
                              },
                              child: Container(
                                width: (width - 60) / 4,
                                height: 100,
                                color: index.isEven
                                    ? kThemeBlueFontColor
                                    : kThemeGreenFontColor,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 5),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(),
                                      Menu.items(size: 30)[index]['icon'],
                                      Text(
                                        '${Menu.items()[index]['title']}',
                                        style: TextStyle(color: Colors.white),
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
