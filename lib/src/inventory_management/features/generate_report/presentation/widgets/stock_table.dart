import 'package:benaiah_admin_app/core/common/entities/furniture.dart';
import 'package:benaiah_admin_app/core/extensions/date_extensions.dart';
import 'package:benaiah_admin_app/core/extensions/double_extensions.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/generate_report/presentation/widgets/no_products_found.dart';
import 'package:flutter/material.dart';

class StockTable extends StatefulWidget {
  const StockTable(this.products, {super.key});

  final List<Furniture> products;

  @override
  State<StockTable> createState() => _StockTableState();
}

class _StockTableState extends State<StockTable> {
  /// We can sort by price, quantity, weight, and scheduled restock date.

  int _sortColumnIndex = 0;
  bool _sortAscending = true;

  List<Furniture> _filteredProducts = [];

  void _sort<T>(
    Comparable<T> Function(Furniture furniture) getField,
    int columnIndex,
    bool ascending,
  ) {
    _filteredProducts.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  @override
  void didUpdateWidget(covariant StockTable oldWidget) {
    _filteredProducts = widget.products;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return _filteredProducts.isEmpty
        ? const NoProductsFound()
        : DataTable(
            sortAscending: _sortAscending,
            sortColumnIndex: _sortColumnIndex,
            showCheckboxColumn: false,
            showBottomBorder: true,
            dataRowColor: MaterialStateProperty.all(const Color(0xFFE9E9E9)),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.white,
            ),
            columns: [
              const DataColumn(
                label: Text(''),
              ),
              const DataColumn(
                label: Text(
                  'Product Name',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const DataColumn(
                label: Text(
                  'SKU',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: const Text(
                  'Quantity',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                numeric: true,
                onSort: (columnIndex, ascending) => _sort<num>(
                  (product) => product.quantity,
                  columnIndex,
                  ascending,
                ),
              ),
              DataColumn(
                label: const Text(
                  'Weight',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                numeric: true,
                onSort: (columnIndex, ascending) => _sort<num>(
                  (product) => product.weight,
                  columnIndex,
                  ascending,
                ),
              ),
              DataColumn(
                label: const Text(
                  'Scheduled Restock Date\n(DD/MM/YYYY)',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onSort: (columnIndex, ascending) => _sort<DateTime>(
                  (product) => product.availableAt,
                  columnIndex,
                  ascending,
                ),
              ),
              DataColumn(
                label: const Text(
                  'Price',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                numeric: true,
                onSort: (columnIndex, ascending) => _sort<num>(
                  (product) => product.price,
                  columnIndex,
                  ascending,
                ),
              ),
            ],
            rows: _filteredProducts
                .map(
                  (product) => DataRow(
                    cells: [
                      DataCell(
                        Image.network(
                          product.images.first,
                          height: 100,
                          width: 100,
                        ),
                      ),
                      DataCell(
                        Text(product.name),
                      ),
                      DataCell(
                        Text(product.SKU ?? '__'),
                      ),
                      DataCell(
                        Text(product.quantity.toString()),
                      ),
                      DataCell(
                        Text(
                          '${product.weight.tableFormat}'
                          '${product.weightUnit.value}',
                        ),
                      ),
                      DataCell(
                        Text(
                          '${product.availableAt.scheduled ? '⏱ ' : ''}'
                          '${product.availableAt.ddMMyyyy}',
                        ),
                      ),
                      DataCell(
                        Text(product.price.tableFormat),
                      ),
                    ],
                  ),
                )
                .toList(),
          );
  }
}
