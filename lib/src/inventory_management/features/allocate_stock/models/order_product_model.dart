
import 'package:benaiah_admin_app/core/utils/typedefs.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/entities/order_product.dart';

class OrderProductModel extends OrderProduct {
  const OrderProductModel({
    required super.productId,
    required super.name,
    required super.quantity,
    required super.price,
    required super.orderNumber,
  });

  const OrderProductModel.empty() : this(
    productId: '._empty_.',
    name: '._empty_.',
    quantity: 1,
    price: 1,
    orderNumber: '._empty_.',
  );

  OrderProductModel.fromMap(DataMap map) :
      this(
        productId: map['productId'] as String,
        name: map['name'] as String,
        quantity: map['quantity'] as int,
        price: map['price'] as double,
        orderNumber: map['orderNumber'] as String,
      );

  OrderProductModel copyWith({
    String? productId,
    String? name,
    String? orderNumber,
    int? quantity,
    double? price,
  }) {
    return OrderProductModel(
      productId: productId ?? this.productId,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      orderNumber: orderNumber ?? this.orderNumber,
      price: price ?? this.price,
    );
  }

  DataMap toMap() {
    return {
      'productId': productId,
      'name': name,
      'quantity': quantity,
      'orderNumber': orderNumber,
      'price': price,
    };
  }
}
