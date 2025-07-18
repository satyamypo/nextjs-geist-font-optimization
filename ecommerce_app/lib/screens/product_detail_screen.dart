import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the passed product
    final product = ModalRoute.of(context)!.settings.arguments as Product;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/cart', arguments: product);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
              width: double.infinity,
              height: 300,
              decoration: const BoxDecoration(
                color: Colors.grey,
              ),
              child: Image.network(
                product.imageUrl,
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Container(
                  width: double.infinity,
                  height: 300,
                  color: Colors.grey[300],
                  child: const Icon(
                    Icons.image_not_supported,
                    size: 80,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            
            // Product Details
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name and Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          product.name,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Description Section
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    product.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      height: 1.6,
                      fontSize: 16,
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Features Section
                  Text(
                    'Features',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  _buildFeatureItem('Premium Quality Materials'),
                  _buildFeatureItem('Modern Design'),
                  _buildFeatureItem('Durable Construction'),
                  _buildFeatureItem('Easy Assembly'),
                  _buildFeatureItem('1 Year Warranty'),
                  
                  const SizedBox(height: 32),
                  
                  // Specifications
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Specifications',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildSpecRow('Product ID', product.id),
                        _buildSpecRow('Category', 'Furniture'),
                        _buildSpecRow('Material', 'Premium Wood/Metal'),
                        _buildSpecRow('Color', 'Natural/Black'),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
      
      // Bottom Add to Cart Button
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: ElevatedButton(
            onPressed: () {
              // Show success message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${product.name} added to cart!'),
                  backgroundColor: Colors.green,
                  duration: const Duration(seconds: 2),
                ),
              );
              
              // Navigate to cart after a short delay
              Future.delayed(const Duration(milliseconds: 500), () {
                Navigator.pushNamed(context, '/cart', arguments: product);
              });
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Add to Cart',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildFeatureItem(String feature) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            feature,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSpecRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
