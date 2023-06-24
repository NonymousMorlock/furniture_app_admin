import 'dart:convert';

import 'package:benaiah_admin_app/core/utils/typedefs.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/entities/order_product.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/models/order_product_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../../fixtures/fixture_reader.dart';

void main() {
  const tOrderProduct = OrderProductModel.empty();

  test(
    'should be a subclass of [OrderProduct]',
    () {
      expect(tOrderProduct, isA<OrderProduct>());
    },
  );

  final tMap = json.decode(fixture('order_product.json')) as DataMap;

  group('empty', () {
    test(
      'should return an empty [OrderProductModel]',
      () {
        const result = OrderProductModel.empty();
        expect(result.name, '._empty_.');
      },
    );
  });

  group('fromMap', () {
    test(
      'should return an [OrderProductModel] with the right data',
      () {
        final result = OrderProductModel.fromMap(tMap);

        expect(result, equals(tOrderProduct));
      },
    );
  });

  group('toMap', () {
    test(
      'should return a [Map] with the right data',
      () {
        final result = tOrderProduct.toMap();

        expect(result, equals(tMap));
      },
    );
  });

  group('copyWith', () {
    test(
      'should return an [OrderProductModel] with the new data',
      () {
        final result = tOrderProduct.copyWith(name: 'New Name');

        expect(result.name, 'New Name');
      },
    );
  });
}
