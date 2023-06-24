import 'package:benaiah_admin_app/src/dashboard/presentation/app/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DesktopBackButton extends StatelessWidget {
  const DesktopBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    // Generic desktop style back button
    return Consumer<DashboardController>(
      builder: (_, controller, __) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return RotationTransition(
              turns: animation,
              child: child,
            );
          },
          child: controller.canPop
              ? IconButton(
                  key: const ValueKey('back_button'),
                  icon: const Icon(Icons.arrow_back_ios_new),
                  onPressed: context.read<DashboardController>().pop,
                  color: Colors.black,
                )
              : const SizedBox.shrink(),
        );
      },
    );
  }
}
