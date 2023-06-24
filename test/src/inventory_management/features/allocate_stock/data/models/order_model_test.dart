import 'dart:convert';

import 'package:benaiah_admin_app/core/utils/typedefs.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/entities/order.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/models/order_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../../fixtures/fixture_reader.dart';

void main() {
  final tOrderModel = OrderModel.empty(
    DateTime.fromMillisecondsSinceEpoch(1687187734940),
  );

  test(
    'should be a subclass of [Order] entity',
    () {
      expect(tOrderModel, isA<Order>());
    },
  );

  final tMap = json.decode(fixture('order.json')) as DataMap;

  group('empty', () {
    test(
      'should return an empty [OrderModel]',
      () {
        final result = OrderModel.empty();

        expect(result.customerName, equals('._empty_.'));
      },
    );
  });

  group('fromMap', () {
    test(
      'should return an [OrderModel] with the right data',
      () {
        final result = OrderModel.fromMap(tMap);

        expect(result, equals(tOrderModel));
      },
    );
  });

  group('toMap', () {
    test(
      'should return a [Map] with the right data',
      () {
        final result = tOrderModel.toMap();

        expect(result, equals(tMap));
      },
    );
  });

  group('copyWith', () {
    test(
      'should return an [OrderModel] with the new data',
      () {
        final result = tOrderModel.copyWith(customerName: 'New Customer Name');
        expect(result, isA<OrderModel>());
        expect(result.customerName, 'New Customer Name');
      },
    );
  });
}
