import 'package:benaiah_admin_app/core/utils/dummy_data.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/allocate_stock/presentation/components/order_data_source.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:window_manager/window_manager.dart';

class AllocateStockView extends StatefulWidget {
  const AllocateStockView({super.key});

  static const routeName = '/allocate-stock';

  @override
  State<AllocateStockView> createState() => _AllocateStockViewState();
}

class _AllocateStockViewState extends State<AllocateStockView>
    with WindowListener {
  late OrderDataSource orderDataSource;

  @override
  void initState() {
    orderDataSource = OrderDataSource(orders: kOrders);
    windowManager.addListener(this);
    super.initState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  void onWindowResize() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  'Orders',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              Expanded(
                child: SfDataGrid(
                  source: orderDataSource,
                  allowSorting: true,
                  showSortNumbers: true,
                  selectionMode: SelectionMode.single,
                  headerGridLinesVisibility: GridLinesVisibility.none,
                  isScrollbarAlwaysShown: true,
                  allowEditing: true,
                  columns: [
                    GridColumn(
                      columnName: 'id',
                      label: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text('ID'),
                      ),
                      columnWidthMode: ColumnWidthMode.fill,
                    ),
                    GridColumn(
                      columnName: 'dateCreated',
                      label: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text('Order date'),
                      ),
                      columnWidthMode: ColumnWidthMode.fill,
                    ),
                    GridColumn(
                      columnName: 'lastUpdated',
                      label: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text('Last Updated'),
                      ),
                      columnWidthMode: ColumnWidthMode.fill,
                    ),
                    GridColumn(
                      columnName: 'customerName',
                      label: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text('Customer Name'),
                      ),
                      columnWidthMode: ColumnWidthMode.fill,
                    ),
                    GridColumn(
                      columnName: 'location',
                      label: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text('Location'),
                      ),
                      columnWidthMode: ColumnWidthMode.fitByCellValue,
                    ),
                    GridColumn(
                      columnName: 'amount',
                      label: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text('Amount'),
                      ),
                      columnWidthMode: ColumnWidthMode.fill,
                    ),
                    GridColumn(
                      columnName: 'status',
                      label: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text('Order Status'),
                      ),
                      columnWidthMode: ColumnWidthMode.fill,
                    ),
                    GridColumn(
                      columnName: 'action',
                      label: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text('Action'),
                      ),
                      columnWidthMode: ColumnWidthMode.fitByColumnName,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
