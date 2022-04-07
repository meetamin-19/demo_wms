import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:demo_win_wms/app/utils/constants.dart';

class ThemeTextField extends StatelessWidget {
  const ThemeTextField(
      {Key? key,
        this.controller,
        required this.hint,
        this.keyboardType,
        this.secureText,
        this.isLast,
        this.enabled,
        this.onChanged,
        this.autoFocus,
        this.leading
      })
      : super(key: key);

  final TextEditingController? controller;
  final String hint;
  final TextInputType? keyboardType;
  final bool? secureText;
  final bool? isLast;
  final bool? enabled;
  final bool? autoFocus;
  final Widget? leading;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(hint,style: TextStyle(fontWeight: FontWeight.w400,fontSize: kFlexibleSize(14)),),
        SizedBox(height: 5),
        Container(
          height: kFlexibleSize(50),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: kLightFontColor)
            // boxShadow: kCommonShadow,
          ),
          // padding: EdgeInsets.symmetric(horizontal: kFlexibleSize(15.0)),
          child: SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                if(leading != null)
                  leading!,
                Expanded(
                  child: Center(
                    child: TextField(
                      autofocus: autoFocus ?? false,
                      enabled: enabled,
                      obscureText: secureText ?? false,
                      controller: controller,
                      onChanged: onChanged,
                      inputFormatters: [
                        if (keyboardType == TextInputType.number ||
                            keyboardType == const TextInputType.numberWithOptions() ||
                            keyboardType == TextInputType.phone)
                          FilteringTextInputFormatter.digitsOnly
                      ],
                      style: TextStyle(fontWeight: FontWeight.w400,fontSize: kFlexibleSize(14)),
                      // cursorColor: kPrimaryColor,
                      keyboardType: keyboardType,
                      textInputAction:
                      isLast == true ? TextInputAction.done : TextInputAction.next,
                      decoration: InputDecoration(
                        // focusColor: kPrimaryColor,
                        // hintText: hint,
                        contentPadding:
                        const EdgeInsets.symmetric(horizontal: 15.0),
                        border: const OutlineInputBorder(borderSide: BorderSide.none),
                        hintStyle: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}