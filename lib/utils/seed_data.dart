import 'package:store_max/db/database_helper.dart';
import 'package:store_max/models/product.dart';

class SeedData {
  static final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  // sample TShirts
  static final List<Product> sampleTShirts = [
    Product(
      name: 'Black Yahweh Neck T-Shirt',
      quantity: 50,
      price: 3500,
      imagePath: null,
    ),
    Product(
      name: 'Colored T-Shirt',
      quantity: 45,
      price: 3500,
      imagePath: null,
    ),
    Product(name: 'Taipa T-Shirt', quantity: 15, price: 8500, imagePath: null),
    Product(
      name: 'Black Trefoil T-Shirt',
      quantity: 12,
      price: 8500,
      imagePath: null,
    ),
    Product(
      name: 'Black Plain Shirt',
      quantity: 25,
      price: 6500,
      imagePath: null,
    ),
    Product(
      name: 'Taipa Black Tee',
      quantity: 22,
      price: 6000,
      imagePath: null,
    ),
  ];

  /// Seed the database with 6 sample t-shirts
  static Future<int> seedDatabase() async {
    int count = 0;

    try {
      // Check if database is already populated
      final existingProducts = await _dbHelper.readAll();

      if (existingProducts.isNotEmpty) {
        print(
          ' Database already has ${existingProducts.length} products. Skipping seed.',
        );
        return 0;
      }

      // Add all 6 sample products
      for (var product in sampleTShirts) {
        await _dbHelper.create(product);
        count++;
        print(' Added: ${product.name}');
      }

      print(' Successfully added $count t-shirt products to database');
      return count;
    } catch (e) {
      print(' Error seeding database: $e');
      return count;
    }
  }

  /// Clear all products from database
  static Future<void> clearDatabase() async {
    try {
      final products = await _dbHelper.readAll();
      for (var product in products) {
        if (product.id != null) {
          await _dbHelper.delete(product.id!);
        }
      }
      print(' Database cleared successfully');
    } catch (e) {
      print(' Error clearing database: $e');
    }
  }

  /// Reseed database (clear and add fresh data)
  static Future<int> reseedDatabase() async {
    await clearDatabase();
    return await seedDatabase();
  }
}
