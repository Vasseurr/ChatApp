import 'package:chat_app/core/components/buttons/vasseurr_button.dart';
import 'package:chat_app/core/init/navigation/navigation_route.dart';
import 'package:flutter/material.dart';

import '../../core/routes/app_routes.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Setup")),
      body: Center(
        child: VasseurrBttn(
            buttonText: "Chats",
            onPressed: (() => NavigationRoute.instance.toNamed(Routes.chats))),
      ),
    );
  }
}
