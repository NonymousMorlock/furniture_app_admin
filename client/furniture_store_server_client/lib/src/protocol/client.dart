/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'dart:async' as _i2;
import 'package:furniture_store_server_client/src/protocol/response.dart'
    as _i3;
import 'dart:io' as _i4;
import 'protocol.dart' as _i5;

class _EndpointExample extends _i1.EndpointRef {
  _EndpointExample(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'example';

  _i2.Future<String> hello(String name) => caller.callServerEndpoint<String>(
        'example',
        'hello',
        {'name': name},
      );
}

class _EndpointProduct extends _i1.EndpointRef {
  _EndpointProduct(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'product';

  _i2.Future<_i3.Response> addProduct(String body) =>
      caller.callServerEndpoint<_i3.Response>(
        'product',
        'addProduct',
        {'body': body},
      );

  _i2.Future<String?> getUploadDescription(String path) =>
      caller.callServerEndpoint<String?>(
        'product',
        'getUploadDescription',
        {'path': path},
      );

  _i2.Future<void> clearImages() => caller.callServerEndpoint<void>(
        'product',
        'clearImages',
        {},
      );

  _i2.Future<bool?> verifyUpload(String path) =>
      caller.callServerEndpoint<bool?>(
        'product',
        'verifyUpload',
        {'path': path},
      );

  _i2.Future<_i3.Response> getImageURL(String imagePath) =>
      caller.callServerEndpoint<_i3.Response>(
        'product',
        'getImageURL',
        {'imagePath': imagePath},
      );

  _i2.Future<_i3.Response> getProduct(int id) =>
      caller.callServerEndpoint<_i3.Response>(
        'product',
        'getProduct',
        {'id': id},
      );

  _i2.Future<_i3.Response> updateProduct(String body) =>
      caller.callServerEndpoint<_i3.Response>(
        'product',
        'updateProduct',
        {'body': body},
      );

  _i2.Future<_i3.Response> deleteProduct(int id) =>
      caller.callServerEndpoint<_i3.Response>(
        'product',
        'deleteProduct',
        {'id': id},
      );

  _i2.Future<_i3.Response> getAllProducts() =>
      caller.callServerEndpoint<_i3.Response>(
        'product',
        'getAllProducts',
        {},
      );
}

class Client extends _i1.ServerpodClient {
  Client(
    String host, {
    _i4.SecurityContext? context,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
  }) : super(
          host,
          _i5.Protocol(),
          context: context,
          authenticationKeyManager: authenticationKeyManager,
        ) {
    example = _EndpointExample(this);
    product = _EndpointProduct(this);
  }

  late final _EndpointExample example;

  late final _EndpointProduct product;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'example': example,
        'product': product,
      };
  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {};
}
