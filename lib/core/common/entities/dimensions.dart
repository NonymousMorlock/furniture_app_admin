import 'package:benaiah_admin_app/core/enums/product_enums.dart';
import 'package:equatable/equatable.dart';

class Dimensions extends Equatable {
  const Dimensions({
    required this.length,
    required this.width,
    required this.height,
    required this.dimensionsUnit,
  });

  final double length;
  final double width;
  final double height;
  final DimensionsUnit dimensionsUnit;

  @override
  List<Object?> get props => [length, width, height, dimensionsUnit];
}
