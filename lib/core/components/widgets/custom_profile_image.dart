import 'package:chat_app/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../constants/app_constants.dart';

import 'package:cached_network_image/cached_network_image.dart';

// ignore: must_be_immutable
class CustomProfileImage extends StatelessWidget {
  CustomProfileImage({
    Key? key,
    this.profilePhotoLink,
    this.fit,
    this.isCircle = true,
    this.userCardColor,
  }) : super(key: key);
  String? profilePhotoLink;
  bool isCircle;
  BoxFit? fit;
  Color? userCardColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: isCircle ? _circleBoxDecoration() : _rectangleBoxDecoration(),
      child: Padding(
        padding: EdgeInsets.all(1.sp),
        child: CachedNetworkImage(
            imageBuilder: (context, imageProvider) {
              return Container(
                height: 5.h,
                width: 5.h,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: imageProvider,

                        /*NetworkImage(photoLink ??
                          "AppConstants.defaultProfileImageUrl"),*/
                        fit: fit ?? BoxFit.cover),
                    shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
                    color: userCardColor ?? Colors.black),
              );
            },
            imageUrl: profilePhotoLink ?? AppConstants.avatarMaleURL,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(
                    color: MyColors.primaryBlueColor,
                    value: downloadProgress.progress),
            errorWidget: (context, url, error) => SizedBox(
                  height: 5.h,
                  width: 5.h,
                  child: const CircleAvatar(
                    backgroundImage: NetworkImage(AppConstants.avatarMaleURL),
                  ),
                )),
      ),
    );
  }

  BoxDecoration _rectangleBoxDecoration() => BoxDecoration(
      // gradient: const LinearGradient(colors: ColorRes.primaryColorList),
      border: Border.all(
        color: Colors.transparent,
      ),
      shape: BoxShape.rectangle);

  BoxDecoration _circleBoxDecoration() {
    return BoxDecoration(
        // gradient: const LinearGradient(colors: ColorRes.primaryColorList),
        border: Border.all(
          color: Colors.transparent,
        ),
        shape: BoxShape.circle);
  }
}


/*
class CustomProfileImage extends StatelessWidget {
  CustomProfileImage(
      {Key? key, required this.profilePhotoLink, this.paddingValue = 3})
      : super(key: key);

  String? profilePhotoLink;
  double paddingValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(paddingValue.sp),
      child: CircleAvatar(
        radius: AppConstants.midRadius,
        backgroundImage:
            NetworkImage(profilePhotoLink ?? AppConstants.avatarMaleURL),
      ),
    );
  }
}*/
