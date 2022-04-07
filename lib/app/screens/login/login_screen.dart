import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:demo_win_wms/app/screens/base_screens/base_state_less.dart';
import 'package:demo_win_wms/app/screens/login/components/login_component.dart';
import 'package:demo_win_wms/app/screens/login/components/login_slider_component.dart';
import 'package:demo_win_wms/app/utils/responsive.dart';

class LoginScreen extends BaseStateLess {
  LoginScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(context),
    );
  }

  Widget body(BuildContext context) {

    return Row(
      children: [
        Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: LoginComponent(),
            )),
        Expanded(
            flex: Responsive.isDesktop(context) ? 1 : 0,
            child: !Responsive.isDesktop(context) ? Container() : LoginSliderComponent())
      ],
    );
  }
}
