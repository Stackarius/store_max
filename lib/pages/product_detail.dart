import 'package:flutter/material.dart';
import 'package:store_max/contants/colors.dart';
import 'package:store_max/my_widget/s_button.dart';

import '../models/product.dart';

class ProductDetail extends StatefulWidget {
  final Product product;
  const ProductDetail({super.key, required this.product});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buidlappBar(),
          // Product Details
          Expanded(child: _buildProductDetails()),
          // Bottom
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                spacing: 20,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 2),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: SButton(text: "Edit ", color: AppColors.secondary),
                    ),
                  ),

                  Expanded(
                    child: SButton(
                      text: "Delete ",
                      color: AppColors.error,
                      textColor: AppColors.secondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buidlappBar() {
    final size = MediaQuery.of(context).size;

    return Hero(
      tag: widget.product.name,
      child: Container(
        height: size.height * 0.4,
        width: size.width,
        decoration: BoxDecoration(
          color: AppColors.myGrey,
          image: DecorationImage(
            image: AssetImage((widget.product.imagePath as String)),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 40,
              left: 20,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withAlpha(100),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.arrow_back, color: AppColors.secondary),
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
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.product.name,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "₦ ${widget.product.price.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 20, color: AppColors.primary),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber),
                      Icon(Icons.star, color: Colors.amber),
                      Icon(Icons.star, color: Colors.amber),
                      Icon(Icons.star, color: Colors.amber),
                      Icon(Icons.star_half, color: Colors.amber),
                    ],
                  ),
                  Text(
                    "4.5 (200 Reviews)",
                    style: TextStyle(fontSize: 14, color: AppColors.myGrey),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),

          Text(
            widget.product.quantity > 0
                ? "In Stock: ${widget.product.quantity}"
                : "Out of Stock",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.myGrey,
            ),
          ),

          // description
          SizedBox(height: 10),
          Text(
            "Premium quality cotton t-shirt with comfortable fit. Perfect for everyday casual wear. Durable fabric that maintains its shape after multiple washes.",
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
