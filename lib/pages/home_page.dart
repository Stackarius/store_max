import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_max/db/database_helper.dart';
import 'package:store_max/models/product.dart';
import 'package:store_max/pages/product_detail.dart';
import '../contants/colors.dart';
import '../my_widget/product_card.dart';
import '../provider/product_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ProductProvider>(context, listen: false);
    provider.loadProducts();
    _searchController.addListener(() {
      provider.filterProducts(_searchController.text.trim());
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _openProductDetail(BuildContext context, Product product) async {
    final shouldRefresh = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ProductDetail(product: product)),
    );

    if (shouldRefresh == true && context.mounted) {
      Provider.of<ProductProvider>(context, listen: false).loadProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              _buildTopBar(),
              const SizedBox(height: 20),
              _buildSearchBarRow(),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Inventory",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Expanded(child: _buildProductGrid()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      children: [
        Expanded(
          child: Row(
            spacing: 10,
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage("assets/images/image_1.jpeg"),
                radius: 25,
              ),
              const Text(
                "Welcome Sarah",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Card(
              color: AppColors.secondary,
              child: Badge(
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications),
                ),
              ),
            ),
            const SizedBox(width: 5),
            Card(
              color: AppColors.secondary,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.settings),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSearchBarRow() {
    return Row(
      children: [
        Expanded(child: _searchBar()),
        const SizedBox(width: 5),
        Card(
          color: AppColors.secondary,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.filter_list),
          ),
        ),
      ],
    );
  }

  Widget _searchBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondary,
        border: Border.all(width: 2, color: AppColors.myGrey),
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextFormField(
        controller: _searchController,
        textAlignVertical: TextAlignVertical.center,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: "Search",
          border: InputBorder.none,
        ),
        maxLines: 1,
      ),
    );
  }

  Widget _buildProductGrid() {
    return Consumer<ProductProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final products = provider.filteredProducts;

        if (products.isEmpty) return _buildEmptyState();

        return GridView.builder(
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: .75,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return GestureDetector(
              onTap: () => _openProductDetail(context, product),
              child: Hero(
                tag: 'product-${product.id ?? product.name}',
                child: ProductCard(product: product),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildEmptyState() {
    final query = _searchController.text.trim();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inventory_2_outlined, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            query.isEmpty ? 'No products yet' : 'No products found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            query.isEmpty ? 'Add your first product' : 'Try different keywords',
            style: TextStyle(color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }
}
