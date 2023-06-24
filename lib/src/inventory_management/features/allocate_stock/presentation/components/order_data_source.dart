import 'package:benaiah_admin_app/core/enums/order_status_enum.dart';
import 'package:benaiah_admin_app/core/extensions/custom_extensions.dart';
import 'package:benaiah_admin_app/core/extensions/date_extensions.dart';
import 'package:benaiah_admin_app/src/dashboard/presentation/app/dashboard_controller.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/entities/order.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/presentation/views/fulfill_order_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class OrderDataSource extends DataGridSource {
  OrderDataSource({required List<Order> orders}) {
    _orders = orders
        .map<DataGridRow>(
          (order) => DataGridRow(
            cells: [
              DataGridCell<String>(columnName: 'id', value: order.orderNumber),
              DataGridCell<String>(
                columnName: 'dateCreated',
                value: order.createdAt.formattedDate,
              ),
              DataGridCell<String>(
                columnName: 'lastUpdated',
                value: order.updatedAt.formattedDate,
              ),
              DataGridCell<String>(
                columnName: 'customerName',
                value: order.customerName,
              ),
              DataGridCell<String>(
                columnName: 'location',
                value: order.deliveryAddress,
              ),
              DataGridCell<String>(
                columnName: 'amount',
                value: NumberFormat.currency(
                  name: 'GHS',
                  symbol: '₵',
                  decimalDigits: 2,
                ).format(order.totalPrice),
              ),
              DataGridCell<Widget>(
                columnName: 'status',
                value: Chip(
                  avatar: order.status == OrderStatus.processing ? Icon(
                    Icons.circle,
                    size: 12,
                    color: order.status.colour,
                  ).animate(
                    onComplete: (controller) => controller.loop(),
                  ).fadeIn().then().fadeOut() : Icon(
                    Icons.circle,
                    size: 12,
                    color: order.status.colour,
                  ),
                  shape: const StadiumBorder(),
                  label: Text(order.status.value),
                  backgroundColor: order.status.colourLight,
                ),
              ),
              DataGridCell(
                columnName: 'action',
                value: PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem<void>(
                      child: const Text('View Order'),
                      onTap: () {
                        context.read<DashboardController>().push(
                              FulfillOrderView.routeName,
                              arguments: order,
                            );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
        .toList();
  }

  List<DataGridRow> _orders = [];

  @override
  List<DataGridRow> get rows => _orders;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataGridCell) {
        return dataGridCell.value is Widget
            ? Align(
                alignment: Alignment.centerLeft,
                child: dataGridCell.value as Widget,
              )
            : Padding(
                padding: const EdgeInsets.all(10),
                child: Text(dataGridCell.value.toString()),
              );
      }).toList(),
    );
  }
}
