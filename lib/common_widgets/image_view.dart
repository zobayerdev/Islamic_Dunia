// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:islamic_dunia/assets_helper/app_colors.dart';
import 'package:flutter/cupertino.dart';

final class ImageView extends StatelessWidget {
  final String? url;
  double height;
  double width;
  ImageView({super.key, this.url, this.width = 0.0, this.height = 0.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height != 0.0 ? height : null,
      width: width != 0.0 ? width : null,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(
          color: AppColors.cEDBB43,
          width: 1.5,
        ),
      ),
      child: FadeInImage(
          placeholder: const AssetImage('assets/icons/placeHolder.png'),
          image: FileImage(
            File(url ?? ""),
          ), //NetworkImage(url ?? ''),
          imageErrorBuilder: (context, error, stackTrace) {
            return Image.asset('assets/icons/placeHolder.png',
                width: width != 0.0 ? width : null, height: height != 0.0 ? height : null);
          },
          fit: BoxFit.cover,
          width: width != 0.0 ? width : null,
          height: height != 0.0 ? height : null),
    );
  }
}
