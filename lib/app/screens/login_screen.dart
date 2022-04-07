
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demo_win_wms/app/providers/auth_provider.dart';
import 'package:demo_win_wms/app/utils/constants.dart';

import 'base_screens/base_state_less.dart';

class LoginScreen extends BaseStateLess {
  LoginScreen();

  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {

    Future loginUser() async {
      await context.read<AuthProviderImpl>().logInUser(userName: userName.text,password: password.text);
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: kFlexibleSize(16)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: kFlexibleSize(104),
                ),
                Text(
                  'Register',
                  style: TextStyle(fontSize: kBigFonts),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: kFlexibleSize(32),
                ),
                Container(
                  width: double.infinity,
                  height: kFlexibleSize(52),
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: Colors.black, width: kFlexibleSize(2))),
                  child: Center(
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: kFlexibleSize(17)),
                      child: Text('jane@example.com',style: TextStyle(
                        fontSize: kFlexibleSize(15)
                      ),),
                    ),
                  ),
                ),
                SizedBox(
                  height: kFlexibleSize(16),
                ),
                Container(
                  width: double.infinity,
                  height: kFlexibleSize(52),
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: Colors.black, width: kFlexibleSize(2))),
                ),
                SizedBox(
                  height: kFlexibleSize(16),
                ),
                InkWell(
                  onTap: (){
                    loginUser();
                  },
                  child: Container(
                    width: double.infinity,
                    height: kFlexibleSize(52),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(kFlexibleSize(6))),
                    child: Center(
                      child: Text('NEXT',style: TextStyle(
                          color: Colors.white,
                          fontSize: kFlexibleSize(13),
                          fontWeight: FontWeight.bold
                      ),),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
