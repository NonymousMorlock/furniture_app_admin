import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/entities/order_product.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/presentation/components/order_products_data_source.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class OrderDetailsTable extends StatefulWidget {
  const OrderDetailsTable(this.orderProducts, {super.key});

  final List<OrderProduct> orderProducts;

  @override
  State<OrderDetailsTable> createState() => _OrderDetailsTableState();
}

class _OrderDetailsTableState extends State<OrderDetailsTable> {
  late OrderProductsDataSource orderProductsDataSource;

  @override
  void initState() {
    orderProductsDataSource = OrderProductsDataSource(
      products: widget.orderProducts,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: SfDataGrid(
        shrinkWrapColumns: true,
        shrinkWrapRows: true,
        source: orderProductsDataSource,
        columns: [
          GridColumn(
            columnName: 'id',
            label: const Padding(
              padding: EdgeInsets.all(10),
              child: Text('ID'),
            ),
            columnWidthMode: ColumnWidthMode.fitByCellValue,
          ),
          GridColumn(
            columnName: 'productName',
            label: const Padding(
              padding: EdgeInsets.all(10),
              child: Text('Product Name'),
            ),
            columnWidthMode: ColumnWidthMode.fitByCellValue,
          ),
          GridColumn(
            columnName: 'quantity',
            label: const Padding(
              padding: EdgeInsets.all(10),
              child: Text('Qty'),
            ),
            columnWidthMode: ColumnWidthMode.fill,
          ),
          GridColumn(
            columnName: 'price',
            label: const Padding(
              padding: EdgeInsets.all(10),
              child: Text('Price'),
            ),
            columnWidthMode: ColumnWidthMode.fill,
          ),
          GridColumn(
            columnName: 'total',
            label: const Padding(
              padding: EdgeInsets.all(10),
              child: Text('Total'),
            ),
            columnWidthMode: ColumnWidthMode.fill,
          ),
        ],
      ),
    );
  }
}
