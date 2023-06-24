import 'package:equatable/equatable.dart';

class OrderProduct extends Equatable {
  const OrderProduct({
    required this.productId,
    required this.name,
    required this.quantity,
    required this.price,
    required this.orderNumber,
  });

  const OrderProduct.empty()
      : this(
          productId: '._empty_.',
          name: '._empty_.',
          quantity: 1,
          price: 1,
          orderNumber: '._empty_.',
        );

  final String productId;
  final String name;
  final int quantity;
  final double price;
  final String orderNumber;

  double get totalPrice => quantity * price;

  @override
  List<Object?> get props => [productId, name];

  @override
  String toString() {
    return "OrderProduct(productId: '$productId', name: '$name', "
        "quantity: $quantity, price: $price, orderNumber: '$orderNumber'),";
  }
}
