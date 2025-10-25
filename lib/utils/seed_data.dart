import 'package:store_max/db/database_helper.dart';
import 'package:store_max/models/product.dart';

class SeedData {
  static final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  // 6 Essential T-Shirts for Demo
  static final List<Product> sampleTShirts = [
    Product(
      name: 'Black Yahweh Neck T-Shirt',
      quantity: 50,
      price: 3500,
      imagePath: 'assets/images/tshirt_1.jpeg',
    ),
    Product(
      name: 'Colored T-Shirt',
      quantity: 45,
      price: 3500,
      imagePath: 'assets/images/tshirt_2.jpeg',
    ),
    Product(
      name: 'Taipa T-Shirt',
      quantity: 15,
      price: 8500,
      imagePath: 'assets/images/tshirt_8.jpeg',
    ),
    Product(
      name: 'Black Trefoil T-Shirt',
      quantity: 12,
      price: 8500,
      imagePath: 'assets/images/tshirt_4.jpg',
    ),
    Product(
      name: 'Black Plain Shirt',
      quantity: 25,
      price: 6500,
      imagePath: 'assets/images/tshirt_5.jpg',
    ),
    Product(
      name: 'Taipa Black Tee',
      quantity: 22,
      price: 6000,
      imagePath: 'assets/images/tshirt_6.jpg',
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
