import 'package:benaiah_admin_app/src/dashboard/presentation/views/home_view.dart';
import 'package:benaiah_admin_app/src/inventory_management/presentation/app/providers/category_controller.dart';
import 'package:benaiah_admin_app/src/inventory_management/presentation/app/providers/images_controller.dart';
import 'package:benaiah_admin_app/src/inventory_management/presentation/views/add_product_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeView.routeName:
      return const HomeView();
    case AddProductView.routeName:
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CategoryController()),
          ChangeNotifierProvider(create: (_) => ImagesController()),
        ],
        child: const AddProductView(),
      );
    default:
      return Center(child: Text('${settings.name} not found'));
  }
}
