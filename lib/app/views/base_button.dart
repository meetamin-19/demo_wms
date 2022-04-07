import 'package:flutter/material.dart';
import 'package:demo_win_wms/app/utils/constants.dart';

import 'loading_small.dart';

class BaseButton extends StatelessWidget {
  final Widget? child;
  final GestureTapCallback? onTap;
  final bool? isLoading;

  const BaseButton(
      {required Widget? child, GestureTapCallback? onTap, bool? isLoading})
      : child = child,
        onTap = onTap,
        isLoading = isLoading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory: InkRipple.splashFactory,
      child: child,
      onTap: onTap,
    );
  }
}

class ThemeButton extends BaseButton {
  const ThemeButton(
      {required Widget? child, GestureTapCallback? onTap, bool? isLoading})
      : super(child: child, onTap: onTap, isLoading: isLoading);
}

class ButtonFill extends StatelessWidget {
  final String text;
  final GestureTapCallback? onTap;
  final bool? isLoading;
  final EdgeInsets? margin;

  const ButtonFill(
      {required String text, GestureTapCallback? onTap, bool? isLoading, EdgeInsets? margin})
      : text = text,
        onTap = onTap,
        isLoading = isLoading, margin = margin;

  @override
  Widget build(BuildContext context) {

    return ThemeButton(
      onTap: (isLoading == true) ? null : onTap,
      isLoading: isLoading,
      child: Container(
        margin: margin,
        height: 44,
        decoration: BoxDecoration(
            color: kPrimaryColor.withAlpha((isLoading == true) ? 80 : 1000),
            borderRadius:
            BorderRadius.circular(5.0)),
        child: Center(
          widthFactor: 1,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if(isLoading == true)
                  LoadingSmall(size: 15),
                if(isLoading == true)
                  SizedBox(width: 10),
                Text(
                  text,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                )
              ],
            )
          ),
        ),
      ),
    );
  }
}


class ButtonBorder extends StatelessWidget {
  final String text;
  final GestureTapCallback? onTap;
  final bool? isLoading;

  const ButtonBorder(
      {required String text, GestureTapCallback? onTap, bool? isLoading})
      : text = text,
        onTap = onTap,
        isLoading = isLoading;

  @override
  Widget build(BuildContext context) {

    return ThemeButton(
      onTap: (isLoading == true) ? null : onTap,
      isLoading: isLoading,
      child: Container(
        height: 35,
        decoration: BoxDecoration(
            border: Border.all(color: kPrimaryColor),
            borderRadius:
            BorderRadius.circular((isLoading == true) ? 22.0 : 5.0)),
        child: Center(
          widthFactor: 1,
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: (isLoading == true) ? LoadingSmall(color: kPrimaryColor,) : Text(
                text,
                style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold,fontSize: 13),
              )
          ),
        ),
      ),
    );
  }
}
