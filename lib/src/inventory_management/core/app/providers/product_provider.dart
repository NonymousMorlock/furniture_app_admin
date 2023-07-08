import 'package:benaiah_admin_app/core/common/entities/furniture.dart';
import 'package:benaiah_admin_app/core/common/models/furniture_model.dart';
import 'package:benaiah_admin_app/src/inventory_management/core/controller/product_controller.dart';
import 'package:flutter/foundation.dart';

class ProductProvider extends ChangeNotifier {
  ProductProvider(this._controller);

  final ProductController _controller;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  bool _productAdded = false;

  bool get productAdded => _productAdded;

  Object? result;

  Future<void> addProduct(FurnitureModel furniture) async {
    _isLoading = true;
    notifyListeners();
    final result = await _controller.addProduct(furniture);
    result.fold(
      (failure) =>
          _errorMessage = '${failure.statusCode} Error: ${failure.message}',
      (_) => _productAdded = true,
    );
    _isLoading = false;
    notifyListeners();
  }

  Future<List<Furniture>> getStocks() async {
    final result = await _controller.getStocks();
    return result.fold(
      (failure) {
        _errorMessage = '${failure.statusCode} Error: ${failure.message}';
        notifyListeners();
        return [];
      },
      (stocks) => stocks,
    );
  }

  Future<Furniture> getStockById() async {
    final result = await _controller.getStockById(1);
    return result.fold(
      (failure) {
        _errorMessage = '${failure.statusCode} Error: ${failure.message}';
        notifyListeners();
        return Future.error(Exception(_errorMessage));
      },
      (stock) => stock,
    );
  }

  void resetError() {
    _errorMessage = null;
  }
}
