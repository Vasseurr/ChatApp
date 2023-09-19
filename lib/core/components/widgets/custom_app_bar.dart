import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar(
      {Key? key, required this.title, this.actionButton, this.deleteButton})
      : super(key: key);
  String title;
  Widget? actionButton;
  Widget? deleteButton;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.normal)),
      centerTitle: true,
      actions: [
        deleteButton ?? const SizedBox(),
        actionButton != null ? actionButton! : const SizedBox()
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
