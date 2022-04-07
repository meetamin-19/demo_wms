import 'package:flutter/material.dart';
import 'package:demo_win_wms/app/utils/constants.dart';

class LoginSliderComponent extends StatefulWidget {
  const LoginSliderComponent({Key? key}) : super(key: key);

  @override
  State<LoginSliderComponent> createState() => _LoginSliderComponentState();
}

class _LoginSliderComponentState extends State<LoginSliderComponent> {

  int currentPage = 0;
  int totalPage = 3;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryColor,
      child: Stack(
        fit: StackFit.expand,
        children: [
          PageView.builder(
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            itemCount: totalPage,
            itemBuilder: (context, index) {
              return Container(color: Colors.black.withOpacity(0.1),
                margin: const EdgeInsets.all(80),
                child: const Center(
                  child: Icon(
                    Icons.computer, size: 100, color: Colors.white,),
                ),);
            },),
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(totalPage, (index) => Container(height: index == currentPage ? 10 : 8,width: index == currentPage ? 10 : 8,margin: EdgeInsets.only(right: 10),decoration: BoxDecoration(
                    color: index == currentPage ? Colors.white : Color(0xffCFCFCF),
                      borderRadius: BorderRadius.circular(20)
                  ),)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
