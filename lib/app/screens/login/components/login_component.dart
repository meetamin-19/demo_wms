import 'package:flutter/material.dart';
import 'package:demo_win_wms/app/data/data_service/web_service.dart';
import 'package:demo_win_wms/app/providers/auth_provider.dart';
import 'package:demo_win_wms/app/screens/inventory_audit/inventory_audit_screen.dart';
import 'package:demo_win_wms/app/utils/constants.dart';
import 'package:demo_win_wms/app/utils/enums.dart';
import 'package:demo_win_wms/app/utils/responsive.dart';
import 'package:demo_win_wms/app/views/base_button.dart';

import 'login_text_field.dart';
import 'package:provider/provider.dart';

class LoginComponent extends StatefulWidget {
  LoginComponent({Key? key}) : super(key: key);

  @override
  State<LoginComponent> createState() => _LoginComponentState();
}

class _LoginComponentState extends State<LoginComponent> {
  TextEditingController? userName;

  TextEditingController? password;

  @override
  void initState() {
    super.initState();
    userName = TextEditingController();
    password = TextEditingController();
  }

  loginUser(BuildContext context) async {

    try {

      if(userName?.text.isEmpty == true){
        throw 'Please Enter User Name';
      }else if(password?.text.isEmpty == true){
        throw 'Please Enter Password';
      }

      await context.read<AuthProviderImpl>().logInUser(userName: userName?.text ?? '',password: password?.text ?? '');

    }on UnAuthorised catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        kFlexibleSizedBox(height: 30),
        SizedBox(child: kImgAppIconBig,width: kFlexibleSize(116)),
        kFlexibleSizedBox(height: 25),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text('Warehouse Management System',
            textAlign: TextAlign.center, style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: kFlexibleSize(25)
            ),),
        ),
        kFlexibleSizedBox(height: 30),

        LayoutBuilder(
            builder: (BuildContext context,
                BoxConstraints constraints) {
              bool isScreenWide = Responsive.isDesktop(context);
              return SizedBox(
                width: constraints.maxWidth * 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ThemeTextField(hint: 'Username',controller: userName),
                    kFlexibleSizedBox(height: 20),
                    ThemeTextField(hint: 'Password',controller: password,secureText: true,),
                    kFlexibleSizedBox(height: 32),
                    loginButton(context),
                    kFlexibleSizedBox(height: 20),
                    Flex(
                      direction: isScreenWide ? Axis.horizontal : Axis
                          .vertical,
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment
                              .start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: kLightFontColor),
                                  borderRadius: BorderRadius.circular(
                                      2)
                              ),
                              margin: const EdgeInsets.only(
                                  right: 10),
                              height: kFlexibleSize(16),
                              width: kFlexibleSize(16),
                            ),
                            Text('Remember Me',
                              style: TextStyle(
                                  color: kLightFontColor,fontSize: kFlexibleSize(14),fontWeight: FontWeight.w500),)
                          ],
                        ),
                        const SizedBox(height: 10, width: 10),
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: TextButton(onPressed: (){}, child: Text('Forgate password?',style: TextStyle(
                              color: kLightFontColor,
                              fontSize: kFlexibleSize(14),
                              fontWeight: FontWeight.w500
                          ),)),
                        ),

                      ],
                    )
                  ],
                ),
              );
            }
        ),
        kFlexibleSizedBox(height: 30),
      ],
    );
  }

  ButtonFill loginButton(BuildContext context) {

    final isLoading = context.watch<AuthProviderImpl>().res?.state == Status.LOADING;

    return ButtonFill(
      text: 'Login',
      isLoading: isLoading,
      onTap: () {
        loginUser(context);
      },
    );
  }
}
