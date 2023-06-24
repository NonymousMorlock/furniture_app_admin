
import 'dart:convert';

import 'package:benaiah_admin_app/core/utils/typedefs.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/models/customer_model.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/entities/customer.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../../fixtures/fixture_reader.dart';

void main() {
  const tCustomerModel = CustomerModel.empty();

  test(
    'should be a subclass of [Customer] entity',
    () {
      expect(tCustomerModel, isA<Customer>());
    },
  );

  final tMap = json.decode(fixture('customer.json')) as DataMap;

  group('empty', () {
    test(
      'should return an empty [CustomerModel]',
      () {
        const result = CustomerModel.empty();

        expect(result.name, equals('._empty_.'));
      },
    );
  });

  group('fromMap', () {
    test(
      'should return an [CustomerModel] with the right data',
      () {
        final result = CustomerModel.fromMap(tMap);

        expect(result, equals(tCustomerModel));
      },
    );
  });

  group('toMap', () {
    test(
      'should return a [Map] with the right data',
      () {
        final result = tCustomerModel.toMap();

        expect(result, equals(tMap));
      },
    );
  });

  group('copyWith', () {
    test(
      'should return an [CustomerModel] with the new data',
      () {
        final result = tCustomerModel.copyWith(name: 'New Customer Name');
        expect(result, isA<CustomerModel>());
        expect(result.name, 'New Customer Name');
      },
    );
  });
}
