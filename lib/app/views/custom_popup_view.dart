import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:demo_win_wms/app/utils/constants.dart';

class CustomPopup {

  final String title;
  final String message;
  final String primaryBtnTxt;
  final String? secondaryBtnTxt;
  final Function? primaryAction;
  final Function? secondaryAction;

  CustomPopup(BuildContext context,{required this.title,required this.message,required this.primaryBtnTxt, this.secondaryBtnTxt, this.primaryAction, this.secondaryAction}){
    final size = MediaQuery.of(context).size;

    showCupertinoDialog(context: context,
        builder: (context){
          return Scaffold(
            backgroundColor: Colors.black.withOpacity(0.3),
            body: Center(
              child: Container(
                constraints: BoxConstraints(minWidth: 100, maxWidth: size.width > 650 ? 650 : size.width * 0.9,minHeight: 100,maxHeight: size.height * 0.9),
                padding: const EdgeInsets.symmetric(vertical: 15),
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
                          child: Text(title,style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                          ),textAlign: TextAlign.center,),
                        ),
                        // IconButton(icon: Icon(Icons.close), onPressed: (){
                        //   Navigator.of(context).pop();
                        // })
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Container(
                      height: 1,
                      color: Colors.black12,
                    ),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        constraints: BoxConstraints(minWidth: 100, maxWidth: size.width > 650 ? 650 : size.width * 0.9,minHeight: 10,maxHeight: size.height * 0.5),
                        child: SingleChildScrollView(
                          child: Text(message,
                            softWrap: true,
                            style: const TextStyle(
                                fontSize: 16
                            ),textAlign: TextAlign.center,),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Container(
                      height: 1,
                      color: Colors.black12,
                    ),
                    const SizedBox(height: 15),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
                                  child: Text(secondaryBtnTxt ?? "",style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16
                                  ),),
                                ),
                              ),
                            if(secondaryBtnTxt != null)
                              const SizedBox(width: 10,),
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
