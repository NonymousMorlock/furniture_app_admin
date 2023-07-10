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

  // Add a product to the server
  Future<void> addProduct(FurnitureModel furniture) async {
    _isLoading = true;
    notifyListeners();

    // Call the addProduct method in the ProductController
    final result = await _controller.addProduct(furniture);

    // Handle the result of the addProduct method
    result.fold(
      (failure) =>
          _errorMessage = '${failure.statusCode} Error: ${failure.message}',
      (_) => _productAdded = true,
    );

    _isLoading = false;
    notifyListeners();
  }

  // Update a product on the server
  Future<void> updateProduct(FurnitureModel furniture) async {
    _isLoading = true;
    notifyListeners();

    // Call the updateProduct method in the ProductController
    final result = await _controller.updateProduct(furniture);

    // Handle the result of the updateProduct method
    result.fold(
      (failure) =>
          _errorMessage = '${failure.statusCode} Error: ${failure.message}',
      (_) => _productAdded = true,
    );

    _isLoading = false;
    notifyListeners();
  }

  // Get the list of all available stocks from the server
  Future<List<Furniture>> getStocks() async {
    // Call the getStocks method in the ProductController
    final result = await _controller.getStocks();

    // Handle the result of the getStocks method
    return result.fold(
      (failure) {
        _errorMessage = '${failure.statusCode} Error: ${failure.message}';
        notifyListeners();
        return [];
      },
      (stocks) => stocks,
    );
  }

  // Get a specific stock by its ID from the server
  Future<Furniture> getStockById() async {
    // Call the getStockById method in the ProductController
    final result = await _controller.getStockById(1);

    // Handle the result of the getStockById method
    return result.fold(
      (failure) {
        _errorMessage = '${failure.statusCode} Error: ${failure.message}';
        notifyListeners();
        return Future.error(Exception(_errorMessage));
      },
      (stock) => stock,
    );
  }

  // Reset the error message
  void resetError() {
    _errorMessage = null;
  }
}
