import 'package:benaiah_admin_app/core/extensions/context_extensions.dart';
import 'package:benaiah_admin_app/core/res/media_res.dart';
import 'package:benaiah_admin_app/src/dashboard/presentation/app/dashboard_controller.dart';
import 'package:benaiah_admin_app/src/dashboard/presentation/widgets/dash_tile.dart';
import 'package:benaiah_admin_app/src/inventory_management/presentation/views/add_product_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardController>(
      builder: (_, controller, __) {
        return Center(
          child: GridView(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.5,
            ),
            shrinkWrap: true,
            padding: const EdgeInsets.all(30).copyWith(
              left: context.width * .05,
            ),
            children: [
              DashTile(
                tileMedia: MediaRes.addProduct,
                backgroundImage: MediaRes.inventory,
                tileTitle: 'Add Product',
                tileDescription: 'Add new product to the inventory',
                onTap: () => controller.push(AddProductView.routeName),
              ),
              DashTile(
                tileMedia: MediaRes.allocate,
                backgroundImage: MediaRes.order,
                tileTitle: 'Allocate',
                tileDescription: 'Handle Pending Orders & Stock',
                onTap: () {},
              ),
              DashTile(
                tileMedia: MediaRes.generateReport,
                backgroundImage: MediaRes.report,
                tileTitle: 'Stock Reports',
                tileDescription: 'Generate Stock Reports',
                onTap: () {},
              ),
            ],
          ),
        );
      },
    );
  }
}
