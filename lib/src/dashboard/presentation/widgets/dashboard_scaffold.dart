import 'package:benaiah_admin_app/core/res/media_res.dart';
import 'package:benaiah_admin_app/core/widgets/desktop_back_button.dart';
import 'package:benaiah_admin_app/src/dashboard/presentation/app/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScaffold extends StatelessWidget {
  const DashboardScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardController>(
      builder: (_, controller, __) {
        return Scaffold(
          backgroundColor: const Color(0xFFF5F5F5),
          appBar: AppBar(
            title: Text(
              controller.pageTitle,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                letterSpacing: 0.5,
              ),
            ),
            toolbarHeight: 64,
            titleSpacing: 0,
            backgroundColor: Colors.white,
            leading: const DesktopBackButton(),
            actions: const [],
          ),
          body: controller.currentScreen,
        );
      },
    );
  }
}
