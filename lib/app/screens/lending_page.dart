import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:demo_win_wms/app/providers/auth_provider.dart';
import 'package:demo_win_wms/app/screens/home_screen/home_screen.dart';

import 'package:demo_win_wms/app/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:demo_win_wms/app/utils/enums.dart';

import 'package:demo_win_wms/app/views/loading_small.dart';
import 'base_screens/base_state_less.dart';
import 'container_screen/container_list_screen.dart';
import 'login/login_screen.dart';

class LendingPage extends BaseStateLess{

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;


    // if(size.width / 1440 > 0.65){
    //   kFontRatio = size.width / 1440;//375 will de designer's width
    // }else{
    //   kFontRatio = 1.0;
    // }

    // if(Responsive.isMobile(context)){
    //   kFontRatio = size.width / 450;
    // }else if(Responsive.isTablet(context)){
    //   print('cool');
    //   kFontRatio = size.width / 850;
    // }else if(Responsive.isDesktop(context)){
    //   kFontRatio = size.width / 1440;
    // }else{
    //   kFontRatio = 1.0;
    // }

    // return PalletScreenEdit();

    print('${size.width / 1440} $kFontRatio ${size.width} ${size.height}');

    final auth = context.watch<AuthProviderImpl>();

    final isLogin = auth.isLogin;

    return ContainerListScreen();

    if (isLogin == null){
      return Container(color: Colors.white);
    }

    if (isLogin){

      if (auth.profileRes?.state == Status.LOADING){
        return Container(color: Colors.white,child: Center(child: LoadingSmall(),),);
      }

      return HomeScreen();
    }else{
      return LoginScreen();
    }
  }
}
