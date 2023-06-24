import 'package:benaiah_admin_app/core/errors/exceptions.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/models/customer_model.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/utils/allocate_stock_dummy_database.dart';
import 'package:flutter/widgets.dart';

class AllocateStockRepository {
  const AllocateStockRepository(this._client);

  final AllocateStockDummyDatabase _client;

  Future<CustomerModel> getCustomerById(String customerId) async {
    try {
      final customerData = await _client.get(customerId);
      return CustomerModel.fromMap(customerData);
    } catch (e, s) {
      debugPrint(s.toString());
      throw ServerException(message: e.toString(), statusCode: 500);
    }
  }
}
