import 'package:benaiah_admin_app/core/errors/exceptions.dart';
import 'package:benaiah_admin_app/core/errors/failures.dart';
import 'package:benaiah_admin_app/core/utils/typedefs.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/entities/customer.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/repository/allocate_stock_repository.dart';
import 'package:dartz/dartz.dart';

class AllocateStockController {
  const AllocateStockController(this._repository);

  final AllocateStockRepository _repository;

  ResultFuture<Customer> getCustomerById(String customerId) async {
    try {
      final result = await _repository.getCustomerById(customerId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
