import 'package:flutter/material.dart';
import 'package:demo_win_wms/app/utils/constants.dart';

class HeaderCardView extends StatelessWidget {
  const HeaderCardView({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {

      final flexibleSize = constraints.maxWidth / 329;

      return ClipRRect(
        borderRadius: BorderRadius.circular(5 * flexibleSize),
        child: Container(
          color: Color(index % 2 == 0 ? 0Xff31C7B2 : 0Xff32C5D2),
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Container(
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.only(left: 10 * flexibleSize,bottom: 20 * flexibleSize),
                child: kImgBannerBG,height: 70 * flexibleSize,),
              Column(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.black.withOpacity(index < 2 ? 0 : 0.25),
                      padding: EdgeInsets.all(flexibleSize * 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Past Dues',style: TextStyle(fontSize: flexibleSize * 25,fontWeight: FontWeight.w700,color: Colors.white)),
                          Text('2',style: TextStyle(fontSize: flexibleSize * 40,fontWeight: FontWeight.w700,color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.black.withOpacity(index < 2 ? 0.25 : 0),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Open',style: TextStyle(fontSize: flexibleSize * 14,fontWeight: FontWeight.w500,color: Colors.white)),
                                  Text('2',style: TextStyle(fontSize: flexibleSize * 20,fontWeight: FontWeight.w600,color: Colors.white),),
                                ],
                              ),
                            ),
                          ),
                          Container(width: 2,color: Colors.white,height: flexibleSize * 30,margin: EdgeInsets.symmetric(horizontal: 11),),
                          Expanded(
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Completed',style: TextStyle(fontSize: flexibleSize * 14,fontWeight: FontWeight.w500,color: Colors.white)),
                                  Text('2',style: TextStyle(fontSize: flexibleSize * 20,fontWeight: FontWeight.w600,color: Colors.white),),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      );
    },);
  }
}
