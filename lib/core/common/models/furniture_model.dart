import 'package:benaiah_admin_app/core/common/entities/dimensions.dart';
import 'package:benaiah_admin_app/core/common/entities/furniture.dart';
import 'package:benaiah_admin_app/core/common/models/dimensions_model.dart';
import 'package:benaiah_admin_app/core/enums/product_enums.dart';
import 'package:benaiah_admin_app/core/extensions/enum_extensions.dart';

class FurnitureModel extends Furniture {
  const FurnitureModel({
    required super.id,
    required super.name,
    required super.description,
    required super.categories,
    required super.quantity,
    required super.availability,
    required super.images,
    required super.weight,
    required super.weightUnit,
    required super.price,
    required super.createdAt,
    required super.updatedAt,
    required super.availableAt,
    // ignore: non_constant_identifier_names
    super.SKU,
    super.dimensions,
    super.compareAtPrice,
  });

  factory FurnitureModel.fromMap(Map<String, dynamic> map) {
    return FurnitureModel(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      categories: (map['categories'] as List).cast<String>(),
      quantity: map['quantity'] as int,
      SKU: map['sku'] as String?,
      availability: (map['availability'] as String).availability,
      images: (map['images'] as List).cast<String>(),
      weight: map['weight'] as double,
      weightUnit: (map['weightUnit'] as String).weightUnit,
      dimensions: map['dimensions'] == null
          ? null
          : DimensionsModel.fromJson(map['dimensions'] as String),
      price: map['price'] as double,
      compareAtPrice: map['compareAtPrice'] as double?,
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        int.parse(map['createdAt'] as String),
      ),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(
        int.parse(map['updatedAt'] as String),
      ),
      availableAt: DateTime.fromMillisecondsSinceEpoch(
        int.parse(map['availableAt'] as String),
      ),
    );
  }

  FurnitureModel copyWith({
    int? id,
    String? name,
    String? description,
    List<String>? categories,
    int? quantity,
    // ignore: non_constant_identifier_names
    String? SKU,
    Availability? availability,
    List<String>? images,
    double? weight,
    WeightUnit? weightUnit,
    Dimensions? dimensions,
    double? price,
    double? compareAtPrice,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? availableAt,
  }) {
    return FurnitureModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      categories: categories ?? this.categories,
      quantity: quantity ?? this.quantity,
      SKU: SKU ?? this.SKU,
      availability: availability ?? this.availability,
      images: images ?? this.images,
      weight: weight ?? this.weight,
      weightUnit: weightUnit ?? this.weightUnit,
      dimensions: dimensions ?? this.dimensions,
      price: price ?? this.price,
      compareAtPrice: compareAtPrice ?? this.compareAtPrice,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      availableAt: availableAt ?? this.availableAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'categories': categories,
      'quantity': quantity,
      'sku': SKU,
      'availability': availability.value,
      'images': images,
      'weight': weight,
      'weightUnit': weightUnit.value,
      'dimensions': (dimensions as DimensionsModel?)?.toJson(),
      'price': price,
      'compareAtPrice': compareAtPrice,
      'createdAt': createdAt.millisecondsSinceEpoch.toString(),
      'updatedAt': updatedAt.millisecondsSinceEpoch.toString(),
      'availableAt': availableAt.millisecondsSinceEpoch.toString(),
    };
  }
}
