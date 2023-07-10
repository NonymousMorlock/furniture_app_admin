import 'package:benaiah_admin_app/core/extensions/context_extensions.dart';
import 'package:benaiah_admin_app/src/dashboard/presentation/app/dashboard_controller.dart';
import 'package:benaiah_admin_app/src/dashboard/presentation/widgets/dashboard_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardController>(
      builder: (_, controller, __) {
        return Scaffold(
          body: context.currentBreakpoint.largerOrEqualTo(DESKTOP)
              ? Row(
                  children: [
                    MouseRegion(
                      onEnter: (_) => controller.extend(),
                      onExit: (_) => controller.retract(),
                      child: NavigationRail(
                        backgroundColor: Colors.black,
                        extended: controller.extended,
                        useIndicator: true,
                        minWidth: 115,
                        indicatorColor: Colors.transparent,
                        indicatorShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: Colors.white, width: 2),
                        ),
                        destinations: [
                          NavigationRailDestination(
                            icon: Icon(
                              controller.currentIndex == 0
                                  ? IconlyBold.category
                                  : IconlyLight.category,
                              color: Colors.white,
                            ),
                            label: const Text(
                              'Dashboard',
                              style: TextStyle(color: Colors.white),
                            ),
                            indicatorColor: Colors.red,
                            indicatorShape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                          ),
                          NavigationRailDestination(
                            icon: Icon(
                              controller.currentIndex == 1
                                  ? IconlyBold.activity
                                  : IconlyLight.activity,
                              color: Colors.white,
                            ),
                            label: const Text(
                              'Activity',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          NavigationRailDestination(
                            icon: Icon(
                              controller.currentIndex == 2
                                  ? IconlyBold.setting
                                  : IconlyLight.setting,
                              color: Colors.white,
                            ),
                            label: const Text(
                              'Settings',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                        selectedIndex: controller.currentIndex,
                        onDestinationSelected: (index) {
                          controller.changeIndex(index);
                          // show licence page with the name BENAIAH OKWUKWE
                          // ANUKEM
                          if (index == 2) {
                            showAboutDialog(
                              context: context,
                              applicationName: 'BENAIAH OKWUKWE ANUKEM',
                              applicationVersion: '1.0.0',
                              applicationIcon: const Text(
                                'ATHE',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              children: [
                                const Text(
                                  'Benaiah Okwukwe Anukem is a student at '
                                  'Central University College Ghana, '
                                  'Miotso Campus.\n\nATHE Level 3 Diploma',
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Contact',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Email: bennagams@gmail.com',
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Phone: +233 57 526 3359',
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ),
                    Expanded(
                      flex: controller.extended
                          ? (context.width >= 900 ? 5 : 2)
                          : context.width >= 1370
                              ? 8
                              : 4,
                      child: const DashboardScaffold(),
                    ),
                  ],
                )
              : Column(
                  children: [
                    const Expanded(
                      flex: 8,
                      child: DashboardScaffold(),
                    ),
                    Expanded(
                      child: BottomNavigationBar(
                        backgroundColor: Colors.black,
                        showSelectedLabels: false,
                        showUnselectedLabels: false,
                        items: const [
                          BottomNavigationBarItem(
                            icon:
                                Icon(IconlyLight.category, color: Colors.white),
                            activeIcon: Icon(
                              IconlyBold.category,
                              color: Colors.white,
                            ),
                            label: 'Dashboard',
                            backgroundColor: Colors.black,
                          ),
                          BottomNavigationBarItem(
                            icon:
                                Icon(IconlyLight.activity, color: Colors.white),
                            activeIcon: Icon(
                              IconlyBold.activity,
                              color: Colors.white,
                            ),
                            label: 'Activity',
                            backgroundColor: Colors.black,
                          ),
                          BottomNavigationBarItem(
                            icon:
                                Icon(IconlyLight.setting, color: Colors.white),
                            activeIcon: Icon(
                              IconlyBold.setting,
                              color: Colors.white,
                            ),
                            label: 'Settings',
                            backgroundColor: Colors.black,
                          ),
                        ],
                        currentIndex: controller.currentIndex,
                        onTap: controller.changeIndex,
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
