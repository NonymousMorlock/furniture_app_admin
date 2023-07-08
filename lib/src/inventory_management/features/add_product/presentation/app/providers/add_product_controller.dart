import 'package:benaiah_admin_app/core/common/models/dimensions_model.dart';
import 'package:benaiah_admin_app/core/common/models/furniture_model.dart';
import 'package:benaiah_admin_app/core/enums/product_enums.dart';
import 'package:flutter/cupertino.dart';

class AddProductController extends ChangeNotifier {
  final _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> get formKey => _formKey;

  final _productNameController = TextEditingController();
  final _productDescriptionController = TextEditingController();
  final _productQuantityController = TextEditingController();
  final _productSkuController = TextEditingController();
  final _productWeightController = TextEditingController();
  final _productLengthController = TextEditingController();
  final _productWidthController = TextEditingController();
  final _productHeightController = TextEditingController();
  final _productPriceController = TextEditingController();
  final _productCompareAtPriceController = TextEditingController();

  TextEditingController get productNameController => _productNameController;

  TextEditingController get productDescriptionController =>
      _productDescriptionController;

  TextEditingController get productQuantityController =>
      _productQuantityController;

  TextEditingController get productSkuController => _productSkuController;

  TextEditingController get productWeightController => _productWeightController;

  TextEditingController get productLengthController => _productLengthController;

  TextEditingController get productWidthController => _productWidthController;

  TextEditingController get productHeightController => _productHeightController;

  TextEditingController get productPriceController => _productPriceController;

  TextEditingController get productCompareAtPriceController =>
      _productCompareAtPriceController;

  WeightUnit _weightUnit = WeightUnit.kg;

  WeightUnit get weightUnit => _weightUnit;

  Availability _availability = Availability.inStore;

  Availability get availability => _availability;

  set availability(Availability availability) {
    if (_availability == availability) return;
    _availability = availability;
    notifyListeners();
  }

  set weightUnit(WeightUnit weightUnit) {
    if (_weightUnit == weightUnit) return;
    _weightUnit = weightUnit;
    notifyListeners();
  }

  String? lengthValidator(String? value) {
    final lengthIsEmpty = value == null || value.isEmpty;
    if(!lengthIsEmpty) return null;
    if (
        _productWidthController.text.trim().isNotEmpty ||
        _productHeightController.text.trim().isNotEmpty) {
      return 'This field is required';
    }
    return null;
  }

  String? widthValidator(String? value) {
    final widthIsEmpty = value == null || value.isEmpty;
    if(!widthIsEmpty) return null;
    if (
        _productLengthController.text.trim().isNotEmpty ||
        _productHeightController.text.trim().isNotEmpty) {
      return 'This field is required';
    }
    return null;
  }

  String? heightValidator(String? value) {
    final heightIsEmpty = value == null || value.isEmpty;
    if(!heightIsEmpty) return null;
    if (
        _productLengthController.text.trim().isNotEmpty ||
        _productWidthController.text.trim().isNotEmpty) {
      return 'This field is required';
    }
    return null;
  }

  FurnitureModel furniture({
    required DateTime createdAt,
    required List<String> categories,
    required List<String> images,
    DateTime? scheduleDate,
  }) =>
      FurnitureModel(
        id: 1,
        createdAt: createdAt,
        updatedAt: createdAt,
        availableAt: scheduleDate ?? createdAt,
        categories: categories,
        images: images,
        name: _productNameController.text.trim(),
        description: _productDescriptionController.text.trim(),
        quantity: _productQuantityController.text.trim().isEmpty
            ? 1
            : int.parse(_productQuantityController.text.trim()),
        SKU: _productSkuController.text.trim().isEmpty
            ? null
            : _productSkuController.text.trim(),
        weight: double.parse(_productWeightController.text.trim()),
        dimensions: productDimensions,
        price: _productPriceController.text.trim().isEmpty
            ? 0
            : double.parse(_productPriceController.text.trim()),
        compareAtPrice: _productCompareAtPriceController.text.trim().isEmpty
            ? null
            : double.parse(_productCompareAtPriceController.text.trim()),
        weightUnit: _weightUnit,
        availability: _availability,
      );

  DimensionsModel? get productDimensions {
    if (_productLengthController.text.trim().isEmpty ||
        _productWidthController.text.trim().isEmpty ||
        _productHeightController.text.trim().isEmpty) return null;
    return DimensionsModel(
      length: double.parse(_productLengthController.text.trim()),
      width: double.parse(_productWidthController.text.trim()),
      height: double.parse(_productHeightController.text.trim()),
      dimensionsUnit: DimensionsUnit.inches,
    );
  }
}
