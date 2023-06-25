import 'package:flutter/material.dart';

class Stock {
  final String id;
  final String productName;
  final String category;
  final int quantity;
  final double price;

  Stock({
    required this.id,
    required this.productName,
    required this.category,
    required this.quantity,
    required this.price,
  });
}

List<Stock> generateDummyStocks() {
  return [
    Stock(
      id: '1',
      productName: 'Chair',
      category: 'Furniture',
      quantity: 10,
      price: 99.99,
    ),
    Stock(
      id: '2',
      productName: 'Table',
      category: 'Furniture',
      quantity: 5,
      price: 199.99,
    ),
    Stock(
      id: '3',
      productName: 'Lamp',
      category: 'Lighting',
      quantity: 8,
      price: 49.99,
    ),
    // Add more dummy stocks as needed
  ];
}

class StockReportsView extends StatefulWidget {
  const StockReportsView({super.key});

  static const routeName = '/stock-reports';

  @override
  State<StockReportsView> createState() => _StockReportsViewState();
}

class _StockReportsViewState extends State<StockReportsView> {
  List<Stock> stocks = generateDummyStocks();
  List<Stock> filteredStocks = [];

  TextEditingController searchController = TextEditingController();
  String selectedCategory = 'All';
  bool sortAscending = true;

  @override
  void initState() {
    super.initState();
    filteredStocks = stocks;
  }

  void filterStocks() {
    setState(() {
      final searchTerm = searchController.text.toLowerCase();
      filteredStocks = stocks.where((stock) {
        final productName = stock.productName.toLowerCase();
        final category = stock.category.toLowerCase();
        return productName.contains(searchTerm) ||
            category.contains(searchTerm);
      }).toList();

      if (selectedCategory != 'All') {
        filteredStocks = filteredStocks
            .where((stock) => stock.category == selectedCategory)
            .toList();
      }

      if (!sortAscending) {
        filteredStocks.sort((a, b) => b.productName.compareTo(a.productName));
      } else {
        filteredStocks.sort((a, b) => a.productName.compareTo(b.productName));
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
                items: const [
                  DropdownMenuItem(
                    value: 'All',
                    child: Text('All Categories'),
                  ),
                  DropdownMenuItem(
                    value: 'Furniture',
                    child: Text('Furniture'),
                  ),
                  DropdownMenuItem(
                    value: 'Lighting',
                    child: Text('Lighting'),
                  ),
                  // Add more categories here
                ],
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
            child: ListView.builder(
              itemCount: filteredStocks.length,
              itemBuilder: (context, index) {
                final stock = filteredStocks[index];
                return ListTile(
                  title: Text(stock.productName),
                  subtitle: Text(
                    'Category: ${stock.category} | '
                        'Quantity: ${stock.quantity} | '
                        'Price: \$${stock.price}',
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
