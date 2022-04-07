import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';

class CustomNetWorkImage extends StatelessWidget {

  final String url;
  final String? assetName;
  final BoxFit? fit;

  const CustomNetWorkImage({Key? key, required this.url, this.assetName, this.fit}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    if (url.isEmpty){
      return Image.asset('assets/images/place-holder.jpeg',fit: fit,);
    }

    try {
      final image = NetworkImage(url);
      return FadeInImage(
        fit: fit ?? BoxFit.cover,
        placeholder: AssetImage(assetName ?? "assets/images/place-holder.jpeg"),
        image: image,
        imageErrorBuilder: (context, error, stackTrace) {

          return Image.asset(
            assetName ?? "assets/images/place-holder.jpeg",
            fit: fit ?? BoxFit.cover,
          );
        },
        placeholderErrorBuilder: (context, error, stackTrace) {

          return Image.asset(
            assetName ?? "assets/images/place-holder.jpeg",
            fit: fit ?? BoxFit.cover,
          );
        },
      );
    } catch (e) {
      return Container();
    }

  }
}
