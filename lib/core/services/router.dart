import 'package:benaiah_admin_app/core/services/injection_container.dart';
import 'package:benaiah_admin_app/src/dashboard/presentation/views/home_view.dart';
import 'package:benaiah_admin_app/src/inventory_management/core/app/providers/product_provider.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/add_product/presentation/app/providers/add_product_controller.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/add_product/presentation/app/providers/category_controller.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/add_product/presentation/app/providers/images_controller.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/add_product/presentation/views/add_product_view.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/entities/order.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/presentation/views/allocate_stock_view.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/presentation/views/fulfill_order_view.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/generate_report/presentation/views/stock_reports_view.dart';
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
          ChangeNotifierProvider(create: (_) => sl<ProductProvider>()),
          ChangeNotifierProvider(create: (_) => AddProductController()),
        ],
        child: const AddProductView(),
      );
    case AllocateStockView.routeName:
      return const AllocateStockView();
    case FulfillOrderView.routeName:
      return FulfillOrderView(settings.arguments! as Order);
    case StockReportsView.routeName:
      return ChangeNotifierProvider(
        create: (_) => sl<ProductProvider>(),
        child: const StockReportsView(),
      );
    default:
      return Center(child: Text('${settings.name} not found'));
  }
}
