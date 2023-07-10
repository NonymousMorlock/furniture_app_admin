import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:benaiah_admin_app/core/common/models/furniture_model.dart';
import 'package:benaiah_admin_app/core/errors/exceptions.dart';
import 'package:benaiah_admin_app/core/utils/typedefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:furniture_store_server_client/furniture_store_server_client.dart';

class ProductRepository {
  const ProductRepository(this._client);

  final Client _client;

  // Add a product to the server
  Future<void> addProduct(FurnitureModel furniture) async {
    try {
      final imageURLs = <String>[];

      // Iterate over each image in the furniture's images list
      for (var i = 0; i < furniture.images.length; i++) {
        final imageFile = File(furniture.images[i]);
        final fileBytes = imageFile.readAsBytesSync();
        final data = ByteData.view(fileBytes.buffer);
        final imageExtension = imageFile.path.split('.').last;
        final imageID = const Uuid().v1();
        final path = 'images/$imageID${furniture.name}/_00$i.$imageExtension';

        // Get the upload description for the image file
        final uploadDescription =
            await _client.product.getUploadDescription(path);

        // If upload description is available
        if (uploadDescription != null) {
          final uploader = FileUploader(uploadDescription);
          await uploader.uploadByteData(data);

          // Verify if the upload was successful
          final success = await _client.product.verifyUpload(path);
          if (success ?? false) {
            final imageUrlResponse = await _client.product.getImageURL(path);

            // If image URL is received successfully
            if (imageUrlResponse.statusCode == 200) {
              imageURLs.add(imageUrlResponse.body);
            }
          }
        }
      }

      // Remove the 'id' field from the furniture map and update the
      // 'images' field with the imageURLs
      final furnitureMap = furniture.copyWith(images: imageURLs).toMap()
        ..remove('id');
      debugPrint(furnitureMap.toString());

      // Add the product to the server
      final response =
          await _client.product.addProduct(jsonEncode(furnitureMap));

      // If the server response status code is not 201 (Created), throw
      // an exception
      if (response.statusCode != 201) {
        throw ServerException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
    } on ServerpodClientException catch (e, s) {
      debugPrint('_addProduct.ServerpodClientException: ');
      debugPrint(s.toString());
      throw ServerException(message: e.message, statusCode: e.statusCode);
    } on ServerException {
      debugPrint('_addProduct.ResponseException: ');
      rethrow;
    } catch (e, s) {
      debugPrint('_addProduct.DartException: ');
      debugPrint(s.toString());
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }

  // Get the list of all available stocks from the server
  Future<List<FurnitureModel>> getStocks() async {
    try {
      // Fetch all products from the server
      final response = await _client.product.getAllProducts();

      // If the server response status code is not 200 (OK), throw an exception
      if (response.statusCode != 200) {
        throw ServerException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }

      // Convert the response body to a list of DataMap and then map each
      // DataMap to FurnitureModel
      for (final element
          in List<DataMap>.from(jsonDecode(response.body) as List)) {
        debugPrint('id: ${element['id']}');
        debugPrint('name: ${element['name']}');
        debugPrint('price: ${element['price']}');
        debugPrint('quantity: ${element['quantity']}');
      }
      return List<DataMap>.from(jsonDecode(response.body) as List)
          .map(FurnitureModel.fromMap)
          .toList();
    } on ServerpodClientException catch (e, s) {
      debugPrint('_getStocks.ServerpodClientException: ');
      debugPrint(s.toString());
      throw ServerException(message: e.message, statusCode: e.statusCode);
    } on ServerException {
      debugPrint('_getStocks.ResponseException: ');
      rethrow;
    } catch (e, s) {
      debugPrint('_getStocks.DartException: ');
      debugPrint(s.toString());
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }

  // Update a specific stock on the server
  Future<void> updateProduct(FurnitureModel furniture) async {
    try {
      // Update the product on the server
      final response =
          await _client.product.updateProduct(jsonEncode(furniture.toMap()));

      // If the server response status code is not 200 (OK), throw an exception
      if (response.statusCode != 200) {
        throw ServerException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
    } on ServerpodClientException catch (e, s) {
      debugPrint('_updateStock.ServerpodClientException: ');
      debugPrint(s.toString());
      throw ServerException(message: e.message, statusCode: e.statusCode);
    } on ServerException {
      debugPrint('_updateStock.ResponseException: ');
      rethrow;
    } catch (e, s) {
      debugPrint('_updateStock.DartException: ');
      debugPrint(s.toString());
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }

  // Get a specific stock by its ID from the server
  Future<FurnitureModel> getStockById(int id) async {
    try {
      // Fetch the product with the specified ID from the server
      final response = await _client.product.getProduct(id);

      // If the server response status code is not 200 (OK), throw an exception
      if (response.statusCode != 200) {
        throw ServerException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }

      // Convert the response body (DataMap) to FurnitureModel
      return FurnitureModel.fromMap(jsonDecode(response.body) as DataMap);
    } on ServerpodClientException catch (e, s) {
      debugPrint('ServerpodClientException: ');
      debugPrint(s.toString());
      throw ServerException(message: e.message, statusCode: e.statusCode);
    } on ServerException {
      debugPrint('ResponseException: ');
      rethrow;
    } catch (e, s) {
      debugPrint('DartException: ');
      debugPrint(s.toString());
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }
}
