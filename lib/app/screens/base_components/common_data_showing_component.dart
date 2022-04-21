import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class CommonDataViewComponent extends StatelessWidget {
  CommonDataViewComponent({Key? key, required this.width, required this.title, required this.value, this.isHtml})
      : super(key: key);

  bool? isHtml = false;
  final String title;
  final double width;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (width - 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: isHtml == true
                ? HtmlWidget(value)
                : Text(
                    value,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.black.withOpacity(0.1))),
            width: double.infinity,
          )
        ],
      ),
    );
  }
}
