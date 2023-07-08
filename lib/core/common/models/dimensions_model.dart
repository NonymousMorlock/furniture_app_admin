import 'dart:convert';

import 'package:benaiah_admin_app/core/common/entities/dimensions.dart';
import 'package:benaiah_admin_app/core/enums/product_enums.dart';
import 'package:benaiah_admin_app/core/extensions/enum_extensions.dart';
import 'package:benaiah_admin_app/core/utils/typedefs.dart';

class DimensionsModel extends Dimensions {
  const DimensionsModel({
    required super.length,
    required super.width,
    required super.height,
    required super.dimensionsUnit,
  });

  factory DimensionsModel.fromJson(String source) =>
      DimensionsModel.fromMap(jsonDecode(source) as DataMap);

  factory DimensionsModel.fromMap(DataMap map) {
    return DimensionsModel(
      length: map['length'] as double,
      width: map['width'] as double,
      height: map['height'] as double,
      dimensionsUnit: (map['dimensionsUnit'] as String).dimensionsUnit,
    );
  }

  DimensionsModel copyWith({
    double? length,
    double? width,
    double? height,
    DimensionsUnit? dimensionsUnit,
  }) {
    return DimensionsModel(
      length: length ?? this.length,
      width: width ?? this.width,
      height: height ?? this.height,
      dimensionsUnit: dimensionsUnit ?? this.dimensionsUnit,
    );
  }

  DataMap toMap() {
    return {
      'length': length,
      'width': width,
      'height': height,
      'dimensionsUnit': dimensionsUnit.value,
    };
  }

  String toJson() => jsonEncode(toMap());
}
