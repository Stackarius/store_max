import 'package:flutter/material.dart';
import 'package:store_max/db/database_helper.dart';
import 'package:store_max/models/product.dart';

import '../contants/colors.dart';
import '../my_widget/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // new instance od _dbHelper
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  bool isLoading = true;
  final TextEditingController _searchController = TextEditingController();
  //

  @override
  void initState() {
    super.initState();
    _loadProducts();
    _searchController.addListener(_filterProducts);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // load products from databse
  Future<void> _loadProducts() async {
    setState(() => isLoading = true);
    final products = await _dbHelper.readAll();
    setState(() {
      _products = products;
      _filteredProducts = products;
      isLoading = false;
    });
  }

  // Filter Products
  void _filterProducts() {
    final query = _searchController.text.trim().toLowerCase();
    setState(() {
      _filteredProducts =
          _products
              .where((product) => product.name.toLowerCase().contains(query))
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Row(
                      spacing: 10,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(
                            "assets/images/image_1.jpeg",
                          ),
                          radius: 25,
                        ),
                        Text(
                          "Welcome Sarah",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // actions
                  Row(
                    children: [
                      Card(
                        color: AppColors.secondary,
                        child: Badge(
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.notifications),
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      Card(
                        color: AppColors.secondary,
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.settings),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              //  SearchBar
              Row(
                children: [
                  _searchBar(context),
                  SizedBox(width: 5),
                  Card(
                    color: AppColors.secondary,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.filter_list),
                    ),
                  ),
                ],
              ),

              // RECENT INVENTORIES
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Inventory",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 15),

              // List of recent inventories
              Expanded(
                child:
                    isLoading
                        ? Center(child: CircularProgressIndicator())
                        : _filteredProducts.isEmpty
                        ? _buildEmptyState(_searchController)
                        : GridView.builder(
                          physics: BouncingScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 15,
                                childAspectRatio: .75,
                              ),
                          itemCount: _filteredProducts.length,
                          itemBuilder: (context, index) {
                            final product = _filteredProducts[index];
                            return Hero(
                              tag: product.name,
                              child: ProductCard(product: product),
                            );
                          },
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _searchBar(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width / 1.35,
    decoration: BoxDecoration(
      color: AppColors.secondary,
      border: Border.all(width: 2, color: AppColors.myGrey),
      borderRadius: BorderRadius.circular(25),
    ),
    child: TextFormField(
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search),
        hintText: "Search",
        border: InputBorder.none,
      ),
      maxLines: 1,
    ),
  );
}

Widget _buildEmptyState(TextEditingController searchController) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.inventory_2_outlined, size: 80, color: Colors.grey[300]),
        SizedBox(height: 16),
        Text(
          searchController.text.isEmpty
              ? 'No products yet'
              : 'No products found',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 8),
        Text(
          searchController.text.isEmpty
              ? 'Add your first product'
              : 'Try different keywords',
          style: TextStyle(color: Colors.grey[500]),
        ),
      ],
    ),
  );
}
