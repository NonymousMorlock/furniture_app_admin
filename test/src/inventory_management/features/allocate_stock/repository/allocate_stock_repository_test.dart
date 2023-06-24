import 'package:benaiah_admin_app/core/errors/exceptions.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/models/customer_model.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/repository/allocate_stock_repository.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/utils/allocate_stock_dummy_database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAllocateStockDummyDatabase extends Mock
    implements AllocateStockDummyDatabase {}

void main() {
  late AllocateStockDummyDatabase client;
  late AllocateStockRepository repository;

  setUp(() {
    client = MockAllocateStockDummyDatabase();
    repository = AllocateStockRepository(client);
  });

  const tCustomer = CustomerModel.empty();

  group('getCustomerById', () {
    test(
      'should return a [CustomerModel] when the call to '
      '[AllocateStockDummyDatabase.get] is successful',
      () async {
        when(() => client.get(any())).thenAnswer(
          (_) async => tCustomer.toMap(),
        );

        final result = await repository.getCustomerById('1');

        expect(result, equals(tCustomer));

        verify(() => client.get('1')).called(1);
        verifyNoMoreInteractions(client);
      },
    );

    test(
      'should throw a [ServerException] when the call to '
      '[AllocateStockDummyDatabase.get] is unsuccessful',
      () async {
        when(() => client.get(any())).thenThrow(Exception('Error Occurred'));

        final call = repository.getCustomerById;

        expect(() => call('1'), throwsA(isA<ServerException>()));

        verify(() => client.get('1')).called(1);
        verifyNoMoreInteractions(client);

      },
    );
  });
}
