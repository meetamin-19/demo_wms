import 'package:flutter/material.dart';
import 'package:demo_win_wms/app/utils/constants.dart';

class CommonThemeContainer extends StatelessWidget {
  const CommonThemeContainer({this.title,this.child});

  final String? title;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: Colors.black.withOpacity(0.25))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 50,
              color: kDarkFontColor,
              child: Row(
                children: [
                  IconButton(onPressed: (){
                    Navigator.of(context).pop();
                  }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
                  Expanded(child: Text('${title}',maxLines: 1,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: kFlexibleSize(20)),))
                ],
              ),
            ),
            SizedBox(height: kFlexibleSize(5),),
            if(child != null)
              Padding(
                padding: EdgeInsets.all(kFlexibleSize(15)),
                child: child!,
              )
          ],
        ),
      ),
    );
  }
}
