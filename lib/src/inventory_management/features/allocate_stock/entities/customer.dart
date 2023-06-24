import 'package:equatable/equatable.dart';

class Customer extends Equatable {
  const Customer({
    required this.id,
    required this.name,
    required this.email,
    required this.shippingAddress,
    required this.billingAddress,
    required this.paymentMethod,
  });

  const Customer.empty()
      : this(
          id: '._empty_.',
          name: '._empty_.',
          email: '._empty_.',
          shippingAddress: '._empty_.',
          billingAddress: '._empty_.',
          paymentMethod: '._empty_.',
        );

  final String id;
  final String name;
  final String email;
  final String shippingAddress;
  final String billingAddress;
  final String paymentMethod;

  @override
  List<Object?> get props => [id];
}
