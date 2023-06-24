import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/controller/allocate_stock_controller.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/presentation/app/providers/allocate_stock_provider.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/repository/allocate_stock_repository.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/utils/allocate_stock_dummy_database.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  sl
    ..registerFactory(() => AllocateStockProvider(sl()))
    ..registerLazySingleton(() => AllocateStockController(sl()))
    ..registerLazySingleton(() => AllocateStockRepository(sl()))
    ..registerLazySingleton(() => AllocateStockDummyDatabase(sl()))
    ..registerLazySingleton<http.Client>(http.Client.new);
}
