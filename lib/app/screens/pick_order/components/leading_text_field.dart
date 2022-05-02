import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LeadingTextField extends StatelessWidget {
  const LeadingTextField(
      {Key? key,
        this.controller,
        this.hint,
        this.keyboardType,
        this.secureText,
        this.isLast,
        this.enabled,
        this.onChanged,
        this.autoFocus,
        this.leading,
        this.onTap
      })
      : super(key: key);

  final TextEditingController? controller;
  final String? hint;
  final TextInputType? keyboardType;
  final bool? secureText;
  final bool? isLast;
  final bool? enabled;
  final bool? autoFocus;
  final Widget? leading;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.black.withOpacity(0.1))
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
                  onTap: onTap,
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
                  style: TextStyle(fontSize: 14,color: (enabled == false) ? Colors.black.withOpacity(0.5) : Colors.black),
                  // cursorColor: kPrimaryColor,
                  keyboardType: keyboardType,
                  textInputAction:
                  isLast == true ? TextInputAction.done : TextInputAction.next,
                  decoration: InputDecoration(
                    // focusColor: kPrimaryColor,
                    hintText: hint,
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal: 5.0),
                    border: const OutlineInputBorder(borderSide: BorderSide.none),
                    hintStyle: TextStyle(fontSize: 14,color: Color(0Xff202842).withOpacity(0.5)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}