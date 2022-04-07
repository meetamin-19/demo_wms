import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:demo_win_wms/app/utils/constants.dart';

class CustomPopupWith3Fields {

  final String title;
  final String message;
  final String primaryBtnTxt;
  final String? secondaryBtnTxt;
  final Function? primaryAction;
  final Function? secondaryAction;
  final String? thirdBtnTxt;
  final Function? thirdBtnAction;

  CustomPopupWith3Fields(BuildContext context,{required this.title,required this.message,required this.primaryBtnTxt, this.secondaryBtnTxt, this.primaryAction, this.secondaryAction,this.thirdBtnAction,this.thirdBtnTxt}){
    final size = MediaQuery.of(context).size;

    showCupertinoDialog(context: context,
        builder: (context){
          return Scaffold(
            backgroundColor: Colors.black.withOpacity(0.3),
            body: Center(
              child: Container(
                constraints: BoxConstraints(minWidth: 100, maxWidth: size.width > 650 ? 650 : size.width * 0.9,minHeight: 100,maxHeight: size.height * 0.9),
                padding: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Icon(Icons.close,color: Colors.transparent,),
                        Expanded(
                          child: Text(title,style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                          ),textAlign: TextAlign.center,),
                        ),
                        // IconButton(icon: Icon(Icons.close), onPressed: (){
                        //   Navigator.of(context).pop();
                        // })
                      ],
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 1,
                      color: Colors.black12,
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        constraints: BoxConstraints(minWidth: 100, maxWidth: size.width > 650 ? 650 : size.width * 0.9,minHeight: 10,maxHeight: size.height * 0.5),
                        child: SingleChildScrollView(
                          child: Text(message,
                            softWrap: true,
                            style: TextStyle(
                                fontSize: 16
                            ),textAlign: TextAlign.center,),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 1,
                      color: Colors.black12,
                    ),
                    SizedBox(height: 15),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if(thirdBtnTxt != null)
                              Container(
                                height: 40,
                                decoration: BoxDecoration(
                                    color: kPrimaryColor,
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                child: TextButton(
                                  onPressed: (){
                                    Navigator.of(context).pop();
                                    if(thirdBtnAction != null ){
                                      thirdBtnAction!();
                                    }
                                  },
                                  child: Text(thirdBtnTxt ?? "",style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16
                                  ),),
                                ),

                              ),
                            if(thirdBtnTxt != null)
                              SizedBox(width: 10,),
                            if(secondaryBtnTxt != null)
                              Container(
                                height: 40,
                                decoration: BoxDecoration(
                                    color: kPrimaryColor,
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                child: TextButton(
                                  onPressed: (){
                                    Navigator.of(context).pop();
                                    if(secondaryAction != null ){
                                      secondaryAction!();
                                    }
                                  },
                                  child: Text(secondaryBtnTxt ?? "",style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16
                                  ),),
                                ),
                              ),
                            if(secondaryBtnTxt != null)
                              SizedBox(width: 10,),
                            Container(
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: kPrimaryColor),
                                  borderRadius: BorderRadius.circular(5)

                              ),
                              child: TextButton(
                                onPressed: (){
                                  Navigator.of(context).pop();
                                  if(primaryAction != null){
                                    primaryAction!();
                                  }
                                },
                                child: Text(primaryBtnTxt,style: TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                ),),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}
