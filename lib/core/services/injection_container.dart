import 'package:benaiah_admin_app/src/inventory_management/core/app/providers/product_provider.dart';
import 'package:benaiah_admin_app/src/inventory_management/core/controller/product_controller.dart';
import 'package:benaiah_admin_app/src/inventory_management/core/repository/product_repository.dart';
import 'package:furniture_store_server_client/furniture_store_server_client.dart';
import 'package:get_it/get_it.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await _initProduct();
}

Future<void> _initProduct() async {
  final client = Client('http://localhost:8080/')
    ..connectivityMonitor = FlutterConnectivityMonitor();
  sl
    ..registerFactory(() => ProductProvider(sl()))
    ..registerLazySingleton(() => ProductController(sl()))
    ..registerLazySingleton(() => ProductRepository(sl()))
    ..registerLazySingleton<Client>(() => client);
}
