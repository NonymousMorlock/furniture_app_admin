// ignore_for_file: avoid_print

import 'dart:math';

import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/entities/order_product.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/models/order_product_model.dart';

final List<OrderProduct> orderProducts = [
  OrderProductModel(
    productId: '1',
    name: 'Foam Padded Chair',
    quantity: 864,
    price: 129.99,
  ),
  OrderProductModel(
    productId: '2',
    name: 'Glass Lamp',
    quantity: 322,
    price: 39.79,
  ),
  OrderProductModel(
    productId: '3',
    name: 'Glass Package',
    quantity: 392,
    price: 26.49,
  ),
  OrderProductModel(
    productId: '4',
    name: 'Plastic Chair',
    quantity: 1112,
    price: 63.0,
  ),
  OrderProductModel(
    productId: '5',
    name: 'Small Bookcase',
    quantity: 802,
    price: 34.99,
  ),
  OrderProductModel(
    productId: '6',
    name: 'Wooden Bookcase',
    quantity: 409,
    price: 61.78,
  ),
  OrderProductModel(
    productId: '7',
    name: 'Wooden Chair',
    quantity: 416,
    price: 114.46,
  ),
  OrderProductModel(
    productId: '8',
    name: 'Wooden Cupboard',
    quantity: 224,
    price: 99.99,
  ),
  OrderProductModel(
    productId: '9',
    name: 'Wooden Lamp',
    quantity: 608,
    price: 35.99,
  ),
  OrderProductModel(
    productId: '10',
    name: 'Wooden Table',
    quantity: 519,
    price: 159.99,
  ),
];

enum GeneratorOrderStatus {
  pending,
  processing,
  shipped,
  delivered,
  outForDelivery,
  cancelled,
}

class GeneratorOrder {
  GeneratorOrder({
    required this.id,
    required this.orderNumber,
    required this.customerName,
    required this.customerId,
    required this.furnitureId,
    required this.products,
    required this.deliveryAddress,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String orderNumber;
  final String customerName;
  final String customerId;
  final String furnitureId;
  final List<GeneratorOrderProduct> products;
  final String deliveryAddress;
  final GeneratorOrderStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;

  double get totalPrice =>
      products.fold(0, (total, product) => total + product.totalPrice);

  @override
  String toString() {
    return "Order(id: '$id', orderNumber: '$orderNumber', customerName: "
        "'$customerName', deliveryAddress: '$deliveryAddress', "
        "status: $status, customerId: '$customerId', furnitureId: "
        "'$furnitureId', products: $products, createdAt: "
        "DateTime.parse('$createdAt'), "
        "updatedAt: DateTime.parse('$updatedAt'),),";
  }
}

class GeneratorOrderProduct {
  GeneratorOrderProduct({
    required this.productId,
    required this.name,
    required this.quantity,
    required this.price,
    required this.orderNumber,
  });

  final String productId;
  final String name;
  final int quantity;
  final String orderNumber;
  final double price;

  double get totalPrice => quantity * price;

  @override
  String toString() {
    return "OrderProduct(productId: '$productId', name: '$name', "
        "quantity: $quantity, price: $price, orderNumber: '$orderNumber')";
  }
}

List<GeneratorOrder> generateOrders() {
  final random = Random();
  final orders = <GeneratorOrder>[];
  final existingIds = <String>[];

  for (var i = 0; i < 50; i++) {
    String orderId;
    do {
      orderId = _generateRandomId();
    } while (existingIds.contains(orderId));
    existingIds.add(orderId);

    final productCount = random.nextInt(5) + 1;
    final orderNumber = _generateRandomOrderNumber();
    // final products = List<GeneratorOrderProduct>.generate(
    //   productCount,
    //   (_) => _generateRandomProduct(random, orderNumber: orderNumber),
    // );

    final products = _generateRandomProducts(numberOfProducts: productCount);

    final order = GeneratorOrder(
      id: orderId,
      orderNumber: '#$orderNumber',
      customerName: _generateRandomName(),
      customerId: _generateRandomId(),
      furnitureId: _generateRandomId(),
      products: products,
      deliveryAddress: _generateRandomAddress(),
      status: _generateRandomStatus(),
      createdAt: DateTime.now().subtract(Duration(days: random.nextInt(30))),
      updatedAt: DateTime.now().subtract(Duration(days: random.nextInt(30))),
    );

    orders.add(order);
  }

  return orders;
}

/// Fetches a random order from the list of [orderProducts].
/// Using the selected orderProduct's [GeneratorOrderProduct.name],
/// [GeneratorOrderProduct.quantity] and
/// [GeneratorOrderProduct.price], and [GeneratorOrderProduct.productId],
/// generates a random [GeneratorOrderProduct]. with a random
/// [GeneratorOrderProduct.orderNumber].
/// and does this a total of 50 times.
/// This also takes into account the quantity of the selected orderProduct.
/// and generates a random quantity between 1 and the selected orderProduct's
/// quantity. but after each iteration, subtracts the generated quantity
/// from the selected orderProduct's quantity.
List<GeneratorOrderProduct> _generateRandomProducts({
  required int numberOfProducts,
}) {
  final random = Random();

  final products = <GeneratorOrderProduct>[];

  final orderNumber = _generateRandomOrderNumber();

  final usedProductIds = <String>[];

  while (products.length < numberOfProducts/*&& usedProductIds.length < orderProducts.length*/) {
    final orderProduct = orderProducts[random.nextInt(orderProducts.length)];
    // max of 10
    final quantity = random.nextInt(10) + 1;
    final price = orderProduct.price;
    final productId = orderProduct.productId;
    final name = orderProduct.name;

    if(usedProductIds.contains(productId)) continue;

    products.add(
      GeneratorOrderProduct(
        productId: productId,
        name: name,
        quantity: quantity,
        price: price,
        orderNumber: orderNumber,
      ),
    );

    final idx = orderProducts.indexOf(orderProduct);
    orderProducts[idx] = (orderProduct as OrderProductModel)
        .copyWith(quantity: orderProduct.quantity - quantity);

    if (orderProducts[idx].quantity == 0) {
      orderProducts.removeAt(idx);
    }

    usedProductIds.add(productId);
  }

  print('done');
  return products;

  // return GeneratorOrderProduct(
  //   productId: productId,
  //   name: name,
  //   quantity: quantity,
  //   orderNumber: '#$orderNumber',
  //   price: price,
  // );
}

String _generateRandomId() {
  final random = Random();
  final codeUnits = List.generate(16, (index) => random.nextInt(26) + 97);
  return String.fromCharCodes(codeUnits);
}

String _generateRandomOrderNumber() {
  final random = Random();
  return random.nextInt(999999).toString().padLeft(6, '0');
}

String _generateRandomName() {
  final random = Random();
  final firstNames = [
    'John',
    'Emily',
    'Michael',
    'Sophia',
    'Daniel',
    'Olivia',
    'David',
    'Emma',
    'Andrew',
    'Isabella'
  ];
  final lastNames = [
    'Smith',
    'Johnson',
    'Williams',
    'Brown',
    'Jones',
    'Garcia',
    'Miller',
    'Davis',
    'Rodriguez',
    'Martinez'
  ];

  final firstName = firstNames[random.nextInt(firstNames.length)];
  final lastName = lastNames[random.nextInt(lastNames.length)];

  return '$firstName $lastName';
}

String _generateRandomAddress() {
  final random = Random();
  final addresses = [
    'Street 1',
    'Street 2',
    'Street 3',
    'Street 4',
    'Street 5'
  ];
  final cities = ['London', 'New York', 'Paris', 'Tokyo', 'Berlin'];
  final countries = [
    'United Kingdom',
    'United States',
    'France',
    'Japan',
    'Germany'
  ];

  final city = cities[random.nextInt(cities.length)];
  var country = countries.first;

  if (city == 'London') {
    country = countries[0];
  } else if (city == 'New York') {
    country = countries[1];
  } else if (city == 'Paris') {
    country = countries[2];
  } else if (city == 'Tokyo') {
    country = countries[3];
  } else if (city == 'Berlin') {
    country = countries[4];
  }

  return '${addresses[random.nextInt(addresses.length)]}, '
      '$city, $country';
}

GeneratorOrderStatus _generateRandomStatus() {
  final random = Random();
  const statusValues = GeneratorOrderStatus.values;
  return statusValues[random.nextInt(statusValues.length)];
}

void main() {
  generateOrders().forEach(print);
}
