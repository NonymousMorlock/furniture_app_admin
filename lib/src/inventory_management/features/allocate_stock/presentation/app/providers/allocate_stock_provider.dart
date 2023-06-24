
import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/controller/allocate_stock_controller.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/entities/customer.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';

class AllocateStockProvider extends ChangeNotifier {

  AllocateStockProvider(this._controller);

  final AllocateStockController _controller;

  Future<Either<String, Customer>> getCustomerById(String id) async {
    final result = await _controller.getCustomerById(id);
    return result.fold(
      (failure) => Left('${failure.statusCode} Error: ${failure.message}'),
      Right.new,
    );
  }
}
