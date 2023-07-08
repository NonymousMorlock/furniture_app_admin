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

  Future<void> addProduct(FurnitureModel furniture) async {
    try {
      final imageURLS = <String>[];
      for (var i = 0; i < furniture.images.length; i++) {
        final imageFile = File(furniture.images[i]);
        final fileBytes = imageFile.readAsBytesSync();
        final data = ByteData.view(fileBytes.buffer);
        final imageExtension = imageFile.path.split('.').last;
        final imageID = const Uuid().v1();
        final path = 'images/$imageID${furniture.name}/_00$i.$imageExtension';
        final uploadDescription =
            await _client.product.getUploadDescription(path);
        if (uploadDescription != null) {
          final uploader = FileUploader(uploadDescription);
          await uploader.uploadByteData(data);
          final success = await _client.product.verifyUpload(path);
          if (success ?? false) {
            final imageUrlResponse = await _client.product.getImageURL(path);
            if (imageUrlResponse.statusCode == 200) {
              imageURLS.add(imageUrlResponse.body);
            }
          }
        }
      }
      final furnitureMap = furniture.copyWith(images: imageURLS).toMap()
        ..remove('id');
      debugPrint(furnitureMap.toString());
      final response =
          await _client.product.addProduct(jsonEncode(furnitureMap));
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

  Future<List<FurnitureModel>> getStocks() async {
    try {
      final response = await _client.product.getAllProducts();
      if (response.statusCode != 200) {
        throw ServerException(
          message: response.body,
          statusCode: response.statusCode,
        );
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

  Future<FurnitureModel> getStockById(int id) async {
    try {
      final response = await _client.product.getProduct(id);
      if (response.statusCode != 200) {
        throw ServerException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
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
