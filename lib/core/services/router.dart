import 'package:benaiah_admin_app/core/services/injection_container.dart';
import 'package:benaiah_admin_app/src/dashboard/presentation/views/home_view.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/add_product/presentation/app/providers/category_controller.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/add_product/presentation/app/providers/images_controller.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/add_product/presentation/views/add_product_view.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/entities/order.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/presentation/app/providers/allocate_stock_provider.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/presentation/views/allocate_stock_view.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/presentation/views/fulfill_order_view.dart';
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
    case AllocateStockView.routeName:
      return const AllocateStockView();
    case FulfillOrderView.routeName:
      return ChangeNotifierProvider(
        create: (_) => sl<AllocateStockProvider>(),
        child: FulfillOrderView(settings.arguments! as Order),
      );
    default:
      return Center(child: Text('${settings.name} not found'));
  }
}
