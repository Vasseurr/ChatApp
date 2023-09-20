import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../constants/app_constants.dart';

class CustomProfileImage extends StatelessWidget {
  CustomProfileImage({Key? key, required this.profilePhotoLink})
      : super(key: key);

  String? profilePhotoLink;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(3.sp),
      child: CircleAvatar(
        radius: AppConstants.midRadius,
        backgroundImage:
            NetworkImage(profilePhotoLink ?? AppConstants.avatarMaleURL),
      ),
    );
  }
}
