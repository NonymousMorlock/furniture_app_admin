import 'package:benaiah_admin_app/core/enums/product_enums.dart';

extension EnumExt on String {
  Availability get availability {
    switch (this) {
      case 'inStore':
        return Availability.inStore;
      case 'online':
        return Availability.online;
      default:
        return Availability.inStoreAndOnline;
    }
  }

  DimensionsUnit get dimensionsUnit {
    switch (this) {
      case 'in':
        return DimensionsUnit.inches;
      case 'cm':
        return DimensionsUnit.cm;
      case 'm':
        return DimensionsUnit.m;
      default:
        return DimensionsUnit.mm;
    }
  }

  WeightUnit get weightUnit {
    switch (this) {
      case 'kg':
        return WeightUnit.kg;
      default:
        return WeightUnit.g;
    }
  }
}
