import 'package:benaiah_admin_app/core/enums/order_status_enum.dart';
import 'package:benaiah_admin_app/core/utils/dummy_data.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/models/order_model.dart';
import 'package:flutter/foundation.dart';

class AllocateStockProvider extends ChangeNotifier {
  final List<OrderModel> _orders = List.of(kOrders);

  List<OrderModel> get orders =>
      _orders..sort((a, b) => a.status.index.compareTo(b.status.index));

  void fulfillOrder(OrderModel order) {
    final orderIndex = _orders.indexOf(order);
    _orders[orderIndex] = order.copyWith(status: OrderStatus.outForDelivery);
    notifyListeners();
  }
}
