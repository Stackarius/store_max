import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_max/my_widget/s_button.dart';
import 'package:store_max/pages/add_edit_product_page.dart';
import 'package:store_max/provider/product_provider.dart';
import '../contants/colors.dart';
import '../models/product.dart';

class ProductDetail extends StatefulWidget {
  final Product product;
  const ProductDetail({super.key, required this.product});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  late Product _currentProduct;

  @override
  void initState() {
    super.initState();
    _currentProduct = widget.product;
  }

  Future<void> _edit() async {
    // Navigate to edit page
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditProductScreen(product: _currentProduct),
      ),
    );

    // If product was updated, refresh provider
    if (result == true) {
      await Provider.of<ProductProvider>(context, listen: false).loadProducts();

      // Get updated product from provider
      final provider = Provider.of<ProductProvider>(context, listen: false);
      final updatedProduct = provider.products.firstWhere(
        (p) => p.id == _currentProduct.id,
        orElse: () => _currentProduct,
      );

      setState(() {
        _currentProduct = updatedProduct;
      });
    }
  }

  Future<void> _delete() async {
    final provider = Provider.of<ProductProvider>(context, listen: false);
    await provider.deleteProduct(_currentProduct.id!);

    // Return to homepage after deletion
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TODO: add margin and  a status container
          _buildAppBar(),
          Expanded(child: _buildProductDetails()),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                spacing: 20,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: _edit,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 2),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: SButton(
                          text: "Edit",
                          color: AppColors.secondary,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: _delete,
                      child: SButton(
                        text: "Delete",
                        color: AppColors.error,
                        textColor: AppColors.secondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    final size = MediaQuery.of(context).size;

    return Hero(
      tag: 'product-${_currentProduct.id ?? _currentProduct.name}',
      child: Container(
        height: size.height * 0.4,
        width: size.width,
        decoration: BoxDecoration(
          color: AppColors.myGrey,
          image: DecorationImage(
            image:
                _currentProduct.imagePath != null
                    ? FileImage(File(_currentProduct.imagePath!))
                    : const AssetImage('assets/default.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 65,
              left: 20,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(50),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    color: AppColors.primary.withAlpha(100),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.arrow_back, color: AppColors.secondary),
                ),
              ),
            ),

            Positioned(
              top: 60,
              left: MediaQuery.of(context).size.width / 2.7,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: AppColors.secondary),
                  borderRadius: BorderRadius.circular(30),
                  color: AppColors.primary.withAlpha(150),
                ),
                child: Text(
                  "@Store Max",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductDetails() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _currentProduct.name,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "₦ ${_currentProduct.price.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 20, color: AppColors.primary),
              ),
              Column(
                children: [
                  Row(
                    children: List.generate(
                      5,
                      (i) => Icon(
                        Icons.star,
                        color: i < 4 ? Colors.amber : Colors.grey,
                      ),
                    ),
                  ),
                  Text(
                    "4.5 (200 Reviews)",
                    style: TextStyle(fontSize: 14, color: AppColors.myGrey),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            _currentProduct.quantity > 0
                ? "In Stock: ${_currentProduct.quantity}"
                : "Out of Stock",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.myGrey,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Premium quality cotton t-shirt with comfortable fit.",
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
