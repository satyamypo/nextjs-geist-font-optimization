# Flutter E-Commerce App - Example Usage Guide

This guide provides step-by-step examples of how to use and customize the Flutter e-commerce app with Razorpay integration.

## Quick Start Example

### 1. Basic Setup and Run

```bash
# Clone and setup
git clone <repository-url>
cd ecommerce_app

# Install dependencies
flutter pub get

# Run the app
flutter run
```

### 2. Razorpay Integration Example

#### Step 1: Get Razorpay Credentials
```bash
# Sign up at https://dashboard.razorpay.com/
# Navigate to Settings → API Keys
# Copy your Key ID and Key Secret
```

#### Step 2: Configure Payment Screen
```dart
// In lib/screens/payment_screen.dart
var options = {
  'key': 'rzp_test_1DP5mmOlF5G5ag', // Replace with your key
  'amount': (_amount * 100).toInt(),
  'name': 'Your Store Name',
  'description': 'Payment for your order',
  'prefill': {
    'contact': '9876543210',
    'email': 'customer@yourstore.com'
  }
};
```

## Code Examples

### 1. Adding New Products

```dart
// In lib/screens/home_screen.dart
final List<Product> products = [
  // Existing products...
  
  // Add your new product
  Product(
    id: '7',
    name: 'Gaming Chair',
    description: 'Ergonomic gaming chair with RGB lighting and premium comfort.',
    price: 399.99,
    imageUrl: 'https://images.pexels.com/photos/4050315/pexels-photo-4050315.jpeg',
  ),
  Product(
    id: '8',
    name: 'Standing Desk',
    description: 'Height-adjustable standing desk for better productivity.',
    price: 299.99,
    imageUrl: 'https://images.pexels.com/photos/667838/pexels-photo-667838.jpeg',
  ),
];
```

### 2. Custom Payment Success Handler

```dart
// In lib/screens/payment_screen.dart
void _handlePaymentSuccess(PaymentSuccessResponse response) {
  setState(() {
    _isLoading = false;
  });
  
  // Custom success handling
  _showSuccessDialog(
    'Payment Successful!',
    'Payment ID: ${response.paymentId}\n'
    'Order ID: ${response.orderId}\n'
    'Signature: ${response.signature}\n\n'
    'Thank you for your purchase!',
  );
  
  // Optional: Send to backend
  _sendPaymentToBackend(response);
}

void _sendPaymentToBackend(PaymentSuccessResponse response) {
  // Example API call
  // http.post('your-backend-url/verify-payment', body: {
  //   'payment_id': response.paymentId,
  //   'order_id': response.orderId,
  //   'signature': response.signature,
  // });
}
```

### 3. Custom Product Model with Categories

```dart
// Enhanced Product Model
class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final List<String> tags;
  final double rating;
  final int reviewCount;
  final bool inStock;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.category = 'General',
    this.tags = const [],
    this.rating = 0.0,
    this.reviewCount = 0,
    this.inStock = true,
  });
}

// Usage example
final List<Product> products = [
  Product(
    id: '1',
    name: 'Elegant Chair',
    description: 'A comfortable and elegant chair perfect for your living room.',
    price: 199.99,
    imageUrl: 'https://images.pexels.com/photos/276528/pexels-photo-276528.jpeg',
    category: 'Furniture',
    tags: ['chair', 'living room', 'comfort'],
    rating: 4.5,
    reviewCount: 128,
    inStock: true,
  ),
];
```

### 4. Advanced Cart Management

```dart
// Enhanced Cart Item with size and color options
class CartItem {
  final Product product;
  int quantity;
  final String? size;
  final String? color;

  CartItem({
    required this.product,
    required this.quantity,
    this.size,
    this.color,
  });

  double get totalPrice => product.price * quantity;
}

// Usage in cart screen
class _CartScreenState extends State<CartScreen> {
  List<CartItem> cartItems = [];
  
  void _addToCart(Product product, {String? size, String? color}) {
    final existingIndex = cartItems.indexWhere((item) => 
      item.product.id == product.id && 
      item.size == size && 
      item.color == color
    );
    
    if (existingIndex >= 0) {
      setState(() {
        cartItems[existingIndex].quantity++;
      });
    } else {
      setState(() {
        cartItems.add(CartItem(
          product: product,
          quantity: 1,
          size: size,
          color: color,
        ));
      });
    }
  }
}
```

## UI Customization Examples

### 1. Custom Theme

```dart
// In lib/main.dart
theme: ThemeData(
  primarySwatch: Colors.blue,
  primaryColor: Colors.deepPurple, // Change primary color
  scaffoldBackgroundColor: Colors.grey[50], // Light background
  
  // Custom AppBar theme
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.deepPurple,
    foregroundColor: Colors.white,
    elevation: 2,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  
  // Custom button theme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.deepPurple,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  ),
  
  // Custom text theme
  textTheme: const TextTheme(
    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.deepPurple,
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      color: Colors.black87,
      height: 1.5,
    ),
  ),
),
```

### 2. Custom Product Card Design

```dart
// Custom product card widget
Widget _buildProductCard(Product product) {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product Image with overlay
        Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                product.imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            if (!product.inStock)
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: const Center(
                  child: Text(
                    'OUT OF STOCK',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            // Favorite button
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.favorite_border,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
        
        // Product details
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                product.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.grey[600],
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: product.inStock ? () => _addToCart(product) : null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    ),
                    child: const Text('Add to Cart'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
```

## Payment Integration Examples

### 1. Custom Payment Options

```dart
// Custom payment method selection
class PaymentMethodSelector extends StatefulWidget {
  final Function(String) onMethodSelected;
  
  const PaymentMethodSelector({Key? key, required this.onMethodSelected}) : super(key: key);
  
  @override
  State<PaymentMethodSelector> createState() => _PaymentMethodSelectorState();
}

class _PaymentMethodSelectorState extends State<PaymentMethodSelector> {
  String selectedMethod = 'card';
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildPaymentOption('card', 'Credit/Debit Card', Icons.credit_card),
        _buildPaymentOption('netbanking', 'Net Banking', Icons.account_balance),
        _buildPaymentOption('upi', 'UPI', Icons.qr_code),
        _buildPaymentOption('wallet', 'Wallet', Icons.account_balance_wallet),
      ],
    );
  }
  
  Widget _buildPaymentOption(String value, String title, IconData icon) {
    return RadioListTile<String>(
      value: value,
      groupValue: selectedMethod,
      onChanged: (String? value) {
        setState(() {
          selectedMethod = value!;
        });
        widget.onMethodSelected(value!);
      },
      title: Row(
        children: [
          Icon(icon, color: Colors.deepPurple),
          const SizedBox(width: 12),
          Text(title),
        ],
      ),
    );
  }
}
```

### 2. Order Confirmation Screen

```dart
// Create a new screen for order confirmation
class OrderConfirmationScreen extends StatelessWidget {
  final String orderId;
  final String paymentId;
  final double amount;
  
  const OrderConfirmationScreen({
    Key? key,
    required this.orderId,
    required this.paymentId,
    required this.amount,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Confirmed'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 100,
              ),
              const SizedBox(height: 24),
              const Text(
                'Order Confirmed!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Thank you for your purchase',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    _buildDetailRow('Order ID', orderId),
                    _buildDetailRow('Payment ID', paymentId),
                    _buildDetailRow('Amount', '\$${amount.toStringAsFixed(2)}'),
                    _buildDetailRow('Status', 'Confirmed'),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/',
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text('Continue Shopping'),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(value, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
```

## Testing Examples

### 1. Test Payment Integration

```dart
// Test payment with different scenarios
void testPaymentScenarios() {
  // Test successful payment
  _testSuccessfulPayment();
  
  // Test failed payment
  _testFailedPayment();
  
  // Test cancelled payment
  _testCancelledPayment();
}

void _testSuccessfulPayment() {
  var options = {
    'key': 'rzp_test_1DP5mmOlF5G5ag',
    'amount': 10000, // ₹100 in paise
    'name': 'Test Store',
    'description': 'Test payment',
    'prefill': {
      'contact': '9876543210',
      'email': 'test@example.com'
    }
  };
  
  // Use test card: 4111 1111 1111 1111
  // This will always succeed in test mode
}

void _testFailedPayment() {
  // Use test card: 4000 0000 0000 0002
  // This will always fail in test mode
}
```

### 2. Unit Tests for Models

```dart
// test/product_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:ecommerce_app/models/product.dart';

void main() {
  group('Product Model Tests', () {
    test('Product creation', () {
      final product = Product(
        id: '1',
        name: 'Test Product',
        description: 'Test Description',
        price: 99.99,
        imageUrl: 'https://example.com/image.jpg',
      );
      
      expect(product.id, '1');
      expect(product.name, 'Test Product');
      expect(product.price, 99.99);
    });
    
    test('Product JSON serialization', () {
      final product = Product(
        id: '1',
        name: 'Test Product',
        description: 'Test Description',
        price: 99.99,
        imageUrl: 'https://example.com/image.jpg',
      );
      
      final json = product.toJson();
      final productFromJson = Product.fromJson(json);
      
      expect(productFromJson.id, product.id);
      expect(productFromJson.name, product.name);
      expect(productFromJson.price, product.price);
    });
  });
}
```

## Deployment Examples

### 1. Build for Release

```bash
# Build APK
flutter build apk --release

# Build App Bundle (recommended for Play Store)
flutter build appbundle --release

# Build for iOS
flutter build ios --release
```

### 2. Environment Configuration

```dart
// lib/config/environment.dart
class Environment {
  static const String razorpayKeyId = String.fromEnvironment(
    'RAZORPAY_KEY_ID',
    defaultValue: 'rzp_test_1DP5mmOlF5G5ag',
  );
  
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://api.yourstore.com',
  );
  
  static const bool isProduction = bool.fromEnvironment('PRODUCTION');
}

// Usage
var options = {
  'key': Environment.razorpayKeyId,
  // ... other options
};
```

This comprehensive example guide should help you understand how to use, customize, and extend the Flutter e-commerce app with Razorpay integration.
