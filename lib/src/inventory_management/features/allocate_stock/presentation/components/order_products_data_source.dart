
import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/entities/order_product.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class OrderProductsDataSource extends DataGridSource {
  OrderProductsDataSource({required List<OrderProduct> products}) {
    _products = products
        .map<DataGridRow>(
          (product) => DataGridRow(
            cells: [
              DataGridCell<String>(
                columnName: 'id',
                value: product.orderNumber,
              ),
              DataGridCell<String>(
                columnName: 'productName',
                value: product.name,
              ),
              DataGridCell<String>(
                columnName: 'quantity',
                value: 'x${product.quantity}',
              ),
              DataGridCell<String>(
                columnName: 'price',
                value: NumberFormat.currency(
                  name: 'GHS',
                  symbol: '₵',
                  decimalDigits: 2,
                ).format(product.price),
              ),
              DataGridCell<String>(
                columnName: 'total',
                value: NumberFormat.currency(
                  name: 'GHS',
                  symbol: '₵',
                  decimalDigits: 2,
                ).format(product.totalPrice),
              ),
            ],
          ),
        )
        .toList();
  }

  List<DataGridRow> _products = [];

  @override
  List<DataGridRow> get rows => _products;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataGridCell) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            dataGridCell.value as String,
            style: TextStyle(
              color: dataGridCell.columnName == 'productName'
                  ? Colors.black
                  : Colors.grey,
            ),
          ),
        );
      }).toList(),
    );
  }
}
