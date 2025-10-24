import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:store_max/models/product.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  //
  DatabaseHelper._init();

  // getter
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('products.db');
    return _database!;
  }

  Future<Database> _initDB(String fIlePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fIlePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE products(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        quantity INTEGER NOT NULL,
        price REAL NOT NULL,
        imagePath TEXT
      )
    ''');
  }

  // CRUD OPERATIONS as a crud advocate😃

  // Create ==> By God's grace
  Future<int> create(Product product) async {
    final db = await instance.database;
    return await db.insert('products', product.toMap());
  }

  // READ ==>
  Future<List<Product>> readAll() async {
    final db = await instance.database;
    final result = await db.query('products');
    return result.map((json) => Product.fromMap(json)).toList();
  }

  // UPDATE
  Future<int> update(Product product) async {
    final db = await instance.database;
    return db.update(
      'products',
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  // DELETE
  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete('products', where: 'id = ?', whereArgs: [id]);
  }

  // Close my lovely databse
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
