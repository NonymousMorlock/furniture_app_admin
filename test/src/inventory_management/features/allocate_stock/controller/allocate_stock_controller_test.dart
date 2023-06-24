import 'package:benaiah_admin_app/core/errors/exceptions.dart';
import 'package:benaiah_admin_app/core/errors/failures.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/controller/allocate_stock_controller.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/entities/customer.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/models/customer_model.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/repository/allocate_stock_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAllocateStockRepository extends Mock
    implements AllocateStockRepository {}

void main() {
  late AllocateStockRepository repository;
  late AllocateStockController controller;

  setUp(() {
    repository = MockAllocateStockRepository();
    controller = AllocateStockController(repository);
  });

  const tCustomer = CustomerModel.empty();

  group('getCustomerById', () {
    test(
      'should return [Customer] from repository when call to repository '
      'is successful',
      () async {
        when(() => repository.getCustomerById(any()))
            .thenAnswer((_) async => tCustomer);

        final result = await controller.getCustomerById('1');

        expect(result, equals(const Right<dynamic, Customer>(tCustomer)));

        verify(() => repository.getCustomerById('1')).called(1);
        verifyNoMoreInteractions(repository);
      },
    );

    test(
      'should return [Failure] from repository when call to repository '
      'is unsuccessful',
      () async {
        when(() => repository.getCustomerById(any())).thenThrow(
          const ServerException(
            message: 'Unknown Error Occurred',
            statusCode: 500,
          ),
        );

        final result = await controller.getCustomerById('1');

        expect(
          result,
          equals(
            const Left<ServerFailure, Customer>(
              ServerFailure(
                message: 'Unknown Error Occurred',
                statusCode: 500,
              ),
            ),
          ),
        );

        verify(() => repository.getCustomerById('1')).called(1);
        verifyNoMoreInteractions(repository);
      },
    );
  });
}
