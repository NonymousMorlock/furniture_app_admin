// ignore_for_file: avoid_print

import 'dart:math';

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
    final products = List<GeneratorOrderProduct>.generate(
      productCount,
      (_) => _generateRandomProduct(random, orderNumber: orderNumber),
    );

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

GeneratorOrderProduct _generateRandomProduct(
  Random random, {
  required String orderNumber,
}) {
  final productIds = ['prod1', 'prod2', 'prod3', 'prod4', 'prod5'];
  final productNames = [
    'Product 1',
    'Product 2',
    'Product 3',
    'Product 4',
    'Product 5'
  ];
  final productId = productIds[random.nextInt(productIds.length)];
  final name = productNames[random.nextInt(productNames.length)];
  final quantity = random.nextInt(5) + 1;
  final price = (random.nextInt(10) + 1) * 100.0;

  return GeneratorOrderProduct(
    productId: productId,
    name: name,
    quantity: quantity,
    orderNumber: '#$orderNumber',
    price: price,
  );
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
