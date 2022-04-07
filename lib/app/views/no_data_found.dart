import 'package:flutter/material.dart';
import 'package:demo_win_wms/app/views/base_button.dart';

class NoDataFoundView extends StatelessWidget {
  const NoDataFoundView({Key? key,this.retryCall, this.title}) : super(key: key);

  final Function? retryCall;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 10),
          child: Text(title ?? 'No Data Found',style: TextStyle(
              color: Colors.grey,
              fontSize: 15
          ),),
        ),
        if(retryCall != null)
          ButtonBorder(text: 'RETRY',onTap: (){
            retryCall!();
          },)
      ],
    );
  }
}