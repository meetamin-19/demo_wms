import 'package:flutter/material.dart';
import 'package:demo_win_wms/app/providers/auth_provider.dart';
import 'package:demo_win_wms/app/providers/home_provider.dart';
import 'package:demo_win_wms/app/screens/pick_order//leading_text_field.dart';
import 'package:demo_win_wms/app/utils/constants.dart';
import 'package:demo_win_wms/app/utils/responsive.dart';
import 'package:provider/provider.dart';
import 'package:demo_win_wms/app/views/network_image.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  CommonAppBar({Key? key, this.hasLeading, this.title, this.isTitleSearch, this.hasBackButton}) : super(key: key);

  bool? hasBackButton;
  bool? hasLeading;
  String? title;
  bool? isTitleSearch = false;

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    final isMobile = Responsive.isMobile(context);

    final auth = context.watch<AuthProviderImpl>();

    final user = auth.profileRes?.data;



    return AppBar(
      toolbarHeight: 80,
      leading: hasLeading == true || hasBackButton == true ? Container(
        child: Row(
          children: [
            hasBackButton == true ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back,size: 30,),
              ),
            ) : SizedBox(),
            hasLeading == true ? InkWell(
              child: Center(child: SizedBox(width: 48, child: kImgAppIconSmall)),onTap: (){

                context.read<HomeProvider>().getPickerList();

              Navigator.of(context).popUntil((route) => route.isFirst);
            },)  : const SizedBox(),
          ],
        ),
      ) : null,
      leadingWidth: hasLeading == false ? null : 120,
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: false,
      title: isTitleSearch == null ? Text(title ?? "") : Container(
        alignment: Alignment.centerLeft,
        width: _size.width < kFlexibleSize(200) ? kFlexibleSize(200) : _size.width * 0.4,
        child: SizedBox(
          height: kFlexibleSize(45),
          child: LeadingTextField(
            leading: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Icon(
                Icons.search,
                color: const Color(0xff202842).withOpacity(0.2),
              ),
            ),
            hint: 'Search',
          ),
        ),
      ),
      // title: title == null ? null : Text(title ?? ''),
      actions: [
        IconButton(onPressed: (){

        }, icon: SizedBox(
          height: 25,
          child: kImgNotification,
        )),
        const SizedBox(width: 15),
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: 40,
                height: 40,
                color: Colors.grey,
                child: CustomNetWorkImage(url: user?.profilePic ?? '',fit: BoxFit.cover,),
              ),
            ),
            if(!isMobile)
            const SizedBox(width: 8),
            if(!isMobile)
            Text('${user?.userName ?? ''}',
              style: TextStyle(color: Colors.black, fontSize: 14,fontWeight: FontWeight.w400),
            ),
            PopupMenuButton(
              padding: EdgeInsets.only(right: 10),
              offset: Offset(0, 44),
              icon: Icon(Icons.arrow_drop_down,size: 35,),
                itemBuilder: (_) => const<PopupMenuItem<String>>[
                  PopupMenuItem<String>(
                      child: Text('Logout'), value: 'logout'),
                ],
                onSelected: (String result) {
                if(result == 'logout'){
                  context.read<AuthProviderImpl>().logOutUser();
                  Navigator.of(context).popUntil((route) => route.isFirst);
                }
                })
          ],
        )
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => new Size.fromHeight(80);
}
