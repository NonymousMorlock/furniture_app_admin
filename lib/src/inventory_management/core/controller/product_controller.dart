import 'package:benaiah_admin_app/core/common/models/furniture_model.dart';
import 'package:benaiah_admin_app/core/errors/exceptions.dart';
import 'package:benaiah_admin_app/core/errors/failures.dart';
import 'package:benaiah_admin_app/core/utils/typedefs.dart';
import 'package:benaiah_admin_app/src/inventory_management/core/repository/product_repository.dart';
import 'package:dartz/dartz.dart';

class ProductController {
  const ProductController(this._repository);

  final ProductRepository _repository;

  ResultFuture<void> addProduct(FurnitureModel furniture) async {
    try {
      await _repository.addProduct(furniture);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  ResultFuture<List<FurnitureModel>> getStocks() async {
    try {
      final stock = await _repository.getStocks();
      return Right(stock);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  ResultFuture<FurnitureModel> getStockById(int id) async {
    try {
      final stock = await _repository.getStockById(id);
      return Right(stock);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
