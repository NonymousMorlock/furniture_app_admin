import 'dart:convert';
import 'dart:math';

import 'package:benaiah_admin_app/core/utils/typedefs.dart';
import 'package:http/http.dart' as http;

class AllocateStockDummyDatabase {
  const AllocateStockDummyDatabase(this._client);

  final http.Client _client;

  Future<DataMap> get(String customerId) async {
    final response = await _client.get(
      Uri.parse('https://randomuser.me/api/'),
    );

    var customerData = jsonDecode(response.body) as DataMap;

    customerData =
        List<DataMap>.from(customerData['results'] as List<dynamic>).first;

    final customerNameData = customerData['name'] as DataMap;

    final customerName = '${customerNameData['first'] as String} '
        '${customerNameData['last'] as String}';

    final customerLocationData = customerData['location'] as DataMap;

    final customerStreetData = customerLocationData['street'] as DataMap;

    final customerShippingAddress = '${customerStreetData['number']} '
        '${customerStreetData['name']}, '
        '${customerLocationData['city']}, '
        '${customerLocationData['state']}, '
        '${customerLocationData['country']} '
        '${customerLocationData['postcode']}';

    final customerEmail = customerData['email'] as String;

    const customerBillingAddress = 'Same as shipping address';

    const payment = 'Cash on Delivery';

    return {
      'id': customerId,
      'name': customerName,
      'email': customerEmail,
      'shippingAddress': customerShippingAddress,
      'billingAddress': customerBillingAddress,
      'paymentMethod': payment,
    };
  }

}
