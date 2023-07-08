import 'dart:async';

import 'package:benaiah_admin_app/core/common/entities/furniture.dart';
import 'package:benaiah_admin_app/src/inventory_management/core/app/providers/product_provider.dart';
import 'package:benaiah_admin_app/src/inventory_management/core/utils/inventory_utils.dart';
import 'package:benaiah_admin_app/src/inventory_management/features/generate_report/presentation/widgets/stock_table.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StockReportsView extends StatefulWidget {
  const StockReportsView({super.key});

  static const routeName = '/stock-reports';

  @override
  State<StockReportsView> createState() => _StockReportsViewState();
}

class _StockReportsViewState extends State<StockReportsView> {
  List<Furniture> stocks = [];
  List<Furniture> filteredStocks = [];

  final Completer<List<Furniture>> _completer = Completer();

  TextEditingController searchController = TextEditingController();
  String selectedCategory = 'All';
  bool sortAscending = true;

  @override
  void initState() {
    super.initState();
    InventoryUtils.listen(context);
    _completer.future.then((value) {
      setState(() {
        stocks = value;
        filteredStocks = stocks;
      });
    });
  }

  List<String> getCategories() {
    final categories = <String>['All'];
    for (final stock in stocks) {
      for (final category in stock.categories) {
        if (!categories.contains(category)) {
          categories.add(category);
        }
      }
    }
    return categories;
  }

  void filterStocks() {
    setState(() {
      final searchTerm = searchController.text.trim().toLowerCase();
      filteredStocks = stocks.where((stock) {
        final productName = stock.name.toLowerCase();
        final categories =
            stock.categories.map((category) => category.toLowerCase()).toList();
        return productName.contains(searchTerm) ||
            categories.any((category) => category.contains(searchTerm));
      }).toList();

      if (selectedCategory != 'All') {
        filteredStocks = filteredStocks.where((stock) {
          final categories = stock.categories
              .map((category) => category.toLowerCase())
              .toList();
          return categories.contains(selectedCategory.toLowerCase());
        }).toList();
      }

      if (!sortAscending) {
        filteredStocks.sort((a, b) => b.name.compareTo(a.name));
      } else {
        filteredStocks.sort((a, b) => a.name.compareTo(b.name));
      }
    });
  }

  void clearFilters() {
    setState(() {
      searchController.clear();
      selectedCategory = 'All';
      sortAscending = true;
      filteredStocks = stocks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Furniture>>(
      future: context.read<ProductProvider>().getStocks(),
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            snapshot.data != null &&
            !_completer.isCompleted) {
          _completer.complete(snapshot.data);
        } else if (snapshot.hasError && !_completer.isCompleted) {
          _completer.completeError(snapshot.error!);
        }
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Search by product name or category',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: clearFilters,
                        ),
                      ),
                      onChanged: (value) => filterStocks(),
                    ),
                  ),
                  const SizedBox(width: 16),
                  DropdownButton<String>(
                    value: selectedCategory,
                    items: getCategories().map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(
                          category.toLowerCase() == 'all'
                              ? 'All Categories'
                              : category,
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value!;
                        filterStocks();
                      });
                    },
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: Icon(
                      sortAscending
                          ? Icons.sort_by_alpha
                          : Icons.sort_by_alpha_outlined,
                    ),
                    onPressed: () {
                      setState(() {
                        sortAscending = !sortAscending;
                        filterStocks();
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [StockTable(filteredStocks)],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
