import 'package:benaiah_admin_app/core/enums/product_enums.dart';

class Dimensions {
  const Dimensions({
    required this.length,
    required this.width,
    required this.height,
    required this.lengthUnit,
  });

  final double length;
  final double width;
  final double height;
  final DimensionsUnit lengthUnit;
}
