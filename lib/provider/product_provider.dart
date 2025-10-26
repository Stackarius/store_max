import 'package:flutter/foundation.dart';
import '../db/database_helper.dart';
import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  bool _isLoading = false;

  List<Product> get products => _products;
  List<Product> get filteredProducts => _filteredProducts;
  bool get isLoading => _isLoading;

  Future<void> loadProducts() async {
    _isLoading = true;
    notifyListeners();

    _products = await _dbHelper.readAll();
    _filteredProducts = List.from(_products);

    _isLoading = false;
    notifyListeners();
  }

  void filterProducts(String query) {
    if (query.isEmpty) {
      _filteredProducts = List.from(_products);
    } else {
      _filteredProducts =
          _products
              .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
              .toList();
    }
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    await _dbHelper.create(product);
    await loadProducts();
  }

  Future<void> updateProduct(Product product) async {
    await _dbHelper.update(product);
    await loadProducts();
  }

  Future<void> deleteProduct(int id) async {
    await _dbHelper.delete(id);
    await loadProducts();
  }
}
