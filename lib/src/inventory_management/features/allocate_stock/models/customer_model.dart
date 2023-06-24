import 'package:benaiah_admin_app/core/utils/typedefs.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/entities/customer.dart';

class CustomerModel extends Customer {
  const CustomerModel({
    required super.id,
    required super.name,
    required super.email,
    required super.shippingAddress,
    required super.billingAddress,
    required super.paymentMethod,
  });

  const CustomerModel.empty()
      : this(
          id: '._empty_.',
          name: '._empty_.',
          email: '._empty_.',
          shippingAddress: '._empty_.',
          billingAddress: '._empty_.',
          paymentMethod: '._empty_.',
        );

  CustomerModel.fromMap(DataMap map)
      : this(
          id: map['id'] as String,
          name: map['name'] as String,
          email: map['email'] as String,
          shippingAddress: map['shippingAddress'] as String,
          billingAddress: map['billingAddress'] as String,
          paymentMethod: map['paymentMethod'] as String,
        );

  CustomerModel copyWith({
    String? id,
    String? name,
    String? email,
    String? shippingAddress,
    String? billingAddress,
    String? paymentMethod,
  }) {
    return CustomerModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      billingAddress: billingAddress ?? this.billingAddress,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }

  DataMap toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'shippingAddress': shippingAddress,
      'billingAddress': billingAddress,
      'paymentMethod': paymentMethod,
    };
  }
}
