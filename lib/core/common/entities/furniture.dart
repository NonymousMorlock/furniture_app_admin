import 'package:benaiah_admin_app/core/common/entities/dimensions.dart';
import 'package:benaiah_admin_app/core/enums/product_enums.dart';
import 'package:equatable/equatable.dart';

class Furniture extends Equatable {
  const Furniture({
    required this.id,
    required this.name,
    required this.description,
    required this.categories,
    required this.quantity,
    required this.availability,
    required this.images,
    required this.weight,
    required this.weightUnit,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.availableAt,
    // ignore: non_constant_identifier_names
    this.SKU,
    this.dimensions,
    this.compareAtPrice,
  });

  final String id;
  final String name;
  final String description;
  final List<String> categories;
  final int quantity;
  // ignore: non_constant_identifier_names
  final String? SKU;
  final Availability availability;
  final List<String> images;
  final double weight;
  final WeightUnit weightUnit;
  final Dimensions? dimensions;
  final double price;
  final double? compareAtPrice;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime availableAt;

  @override
  List<Object?> get props => [id];
}
