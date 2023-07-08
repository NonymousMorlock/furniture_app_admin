import 'package:benaiah_admin_app/core/enums/order_status_enum.dart';

import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/entities/order_product.dart';
import 'package:equatable/equatable.dart';

class Order extends Equatable {
  const Order({
    required this.id,
    required this.orderNumber,
    required this.customerName,
    required this.customerId,
    required this.deliveryAddress,
    required this.products,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.paymentMethod = 'Pay on Delivery',
  });

  Order.empty() : this(
    id: '._empty_.',
    orderNumber: '._empty_.',
    customerName: '._empty_.',
    customerId: '._empty_.',
    deliveryAddress: '._empty_.',
    products: [],
    status: OrderStatus.pending,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    paymentMethod: '._empty_.',
  );

  final String id;
  final String orderNumber;
  final String customerName;
  final String deliveryAddress;
  final OrderStatus status;
  final String customerId;
  final List<OrderProduct> products;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String paymentMethod;

  double get totalPrice =>
      products.fold(0, (total, product) => total + product.totalPrice);

  @override
  List<Object?> get props => [id, orderNumber];
}
