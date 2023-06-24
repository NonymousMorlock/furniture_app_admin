
import 'package:flutter/widgets.dart';

class CategoryController extends ChangeNotifier {
  final List<String> _selectedCategories = [];

  List<String> get selectedCategories => _selectedCategories;

  void addCategory(String category) {
    _selectedCategories.add(category);
    notifyListeners();
  }

  void removeCategory(String category) {
    _selectedCategories.remove(category);
    notifyListeners();
  }

  void toggleCategory(String category) {
    if (_selectedCategories.contains(category)) {
      removeCategory(category);
    } else {
      addCategory(category);
    }
  }

  void clear() {
    _selectedCategories.clear();
    notifyListeners();
  }
}
