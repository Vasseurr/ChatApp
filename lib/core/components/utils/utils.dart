import 'package:chat_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/colors.dart';
import '../../constants/padding_values.dart';

enum SnackbarType {
  success,
  error,
  info,
}

class Utils {
  static final Utils _instance = Utils._init();
  static Utils get instance => _instance;
  Utils._init();

  void showAlert(
    BuildContext context, {
    required String title,
    required String content,
    Widget? contentWidget,
    Color? backgroundColor,
  }) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          title,
          textAlign: TextAlign.center,
        ),
        content: contentWidget ?? Text(content),
        backgroundColor: backgroundColor,
      ),
    );
  }

  void showSnackBar(BuildContext context, {required String content}) {
    final snackBar = SnackBar(
        backgroundColor: context.colors.primary,
        content: Text(content.toString()));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showCustomSnackbar(String title, String message,
      {required SnackbarType snackbarType,
      Function(GetSnackBar)? onTap,
      Color? messageColor,
      Duration? duration = const Duration(seconds: 3)}) {
    Color? primaryColor;
    Color backgroundColor = Colors.white;
    late IconData icon;

    switch (snackbarType) {
      case SnackbarType.success:
        primaryColor = MyColors.snackBar_success;
        backgroundColor = MyColors.snackBar_success_background;
        icon = Icons.check_circle;
        break;
      case SnackbarType.error:
        primaryColor = MyColors.snackBar_error;
        backgroundColor = MyColors.snackBar_error_background;
        icon = Icons.error;
        break;
      case SnackbarType.info:
        primaryColor = MyColors.snackBar_info;
        backgroundColor = MyColors.snackBar_info_background;
        icon = Icons.info;
        break;
    }

    Get.snackbar(
      title,
      message,
      duration: duration,
      padding: EdgeInsets.only(
          left: CustomPaddingValues.horizontalPadding,
          top: CustomPaddingValues.smallH,
          bottom: CustomPaddingValues.smallH,
          right: CustomPaddingValues.xSmallW),
      icon: Icon(
        icon,
        color: primaryColor,
        size: 30,
      ),
      titleText: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, color: primaryColor),
      ),
      //  snackPosition: SnackPosition.BOTTOM,
      messageText: Text(
        message,
        maxLines: 6,
        style: TextStyle(
            fontWeight: FontWeight.w500, color: messageColor ?? Colors.black),
      ),
      onTap: onTap,
      backgroundColor: backgroundColor,
    );
  }

  void showCustomDialog(
      {required String title,
      required String content,
      Widget? contentWidget,
      String? cancelButtonText,
      VoidCallback? cancelButtonOnTap,
      String? confirmButtonText,
      Widget? cancelButton,
      VoidCallback? confirmButtonOnTap}) async {
    Get.defaultDialog(
      title: title,
      titleStyle: GoogleFonts.poppins(
          color: MyColors.dialog_title,
          fontSize: 20,
          fontWeight: FontWeight.w700),
      titlePadding: EdgeInsets.only(
          left: CustomPaddingValues.largeW,
          right: CustomPaddingValues.largeW,
          top: CustomPaddingValues.largeH),
      contentPadding: EdgeInsets.symmetric(
          horizontal: CustomPaddingValues.mediumW,
          vertical: CustomPaddingValues.mediumH),
      content: contentWidget ??
          Column(
            children: [
              Text(
                content,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    color: MyColors.dialog_content,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: CustomPaddingValues.mediumH),
            ],
          ),
      actions: [
        cancelButton ??
            Padding(
              padding: EdgeInsets.only(right: Get.width * .2),
              child: InkWell(
                onTap: cancelButtonOnTap,
                child: Container(
                  height: Get.height * .05,
                  width: Get.width * .2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      cancelButtonText ?? "Cancel",
                      style: GoogleFonts.poppins(
                          color: MyColors.dialog_cancel_text,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ),
        InkWell(
          onTap: confirmButtonOnTap,
          child: Container(
              height: Get.height * .05,
              width: Get.width * .2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: MyColors.dialog_confirm_button_background,
              ),
              child: Center(
                child: Text(
                  confirmButtonText ?? "Confirm",
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
              )),
        ),
      ],
    );
  }
}
