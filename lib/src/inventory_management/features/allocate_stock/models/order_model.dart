import 'package:benaiah_admin_app/core/enums/order_status_enum.dart';
import 'package:benaiah_admin_app/core/utils/typedefs.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/entities/order.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/entities/order_product.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/models/order_product_model.dart';

class OrderModel extends Order {
  const OrderModel({
    required super.id,
    required super.orderNumber,
    required super.customerName,
    required super.customerId,
    required super.furnitureId,
    required super.deliveryAddress,
    required super.products,
    required super.status,
    required super.createdAt,
    required super.updatedAt,
    super.paymentMethod = 'Pay on Delivery',
  });

  OrderModel.empty([DateTime? date])
      : this(
          id: '._empty_.',
          orderNumber: '._empty_.',
          customerName: '._empty_.',
          customerId: '._empty_.',
          furnitureId: '._empty_.',
          deliveryAddress: '._empty_.',
          products: [],
          status: OrderStatus.pending,
          createdAt: date ?? DateTime.now(),
          updatedAt: date ?? DateTime.now(),
          paymentMethod: '._empty_.',
        );

  OrderModel.fromMap(DataMap map)
      : this(
          id: map['id'] as String,
          orderNumber: map['orderNumber'] as String,
          customerName: map['customerName'] as String,
          customerId: map['customerId'] as String,
          furnitureId: map['furnitureId'] as String,
          deliveryAddress: map['deliveryAddress'] as String,
          products: List<DataMap>.from(map['products'] as List<dynamic>)
              .map(OrderProductModel.fromMap)
              .toList(),
          status: OrderStatus.values.firstWhere(
            (status) => status.value == map['status'] as String,
          ),
          createdAt:
              DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
          updatedAt:
              DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
          paymentMethod: map['paymentMethod'] as String? ?? 'Pay on Delivery',
        );

  OrderModel copyWith({
    String? id,
    String? orderNumber,
    String? customerName,
    String? deliveryAddress,
    OrderStatus? status,
    String? customerId,
    String? furnitureId,
    List<OrderProduct>? products,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? paymentMethod,
  }) {
    return OrderModel(
      id: id ?? this.id,
      orderNumber: orderNumber ?? this.orderNumber,
      customerName: customerName ?? this.customerName,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      status: status ?? this.status,
      customerId: customerId ?? this.customerId,
      furnitureId: furnitureId ?? this.furnitureId,
      products: products ?? this.products,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }

  DataMap toMap() => {
        'id': id,
        'orderNumber': orderNumber,
        'customerName': customerName,
        'customerId': customerId,
        'furnitureId': furnitureId,
        'deliveryAddress': deliveryAddress,
        'products': products
            .map((product) => (product as OrderProductModel).toMap())
            .toList(),
        'status': status.value,
        'createdAt': createdAt.millisecondsSinceEpoch,
        'updatedAt': updatedAt.millisecondsSinceEpoch,
        'paymentMethod': paymentMethod,
      };
}
