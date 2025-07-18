# Flutter E-Commerce App with Razorpay Integration

A complete Flutter e-commerce application with integrated Razorpay payment gateway. This app demonstrates modern UI design, product management, shopping cart functionality, and secure payment processing.

## Features

### 🛍️ E-Commerce Features
- **Product Catalog**: Browse through a curated list of products with high-quality images
- **Product Details**: Detailed product information with specifications and features
- **Shopping Cart**: Add/remove items, quantity management, and price calculation
- **Order Summary**: Complete breakdown of costs including shipping

### 💳 Payment Integration
- **Razorpay Integration**: Secure payment processing with multiple payment methods
- **Multiple Payment Options**: Credit/Debit cards, Net Banking, UPI, Wallets
- **Real-time Payment Status**: Success, failure, and external wallet handling
- **Payment Security**: Encrypted transactions with proper error handling

### 🎨 Modern UI/UX
- **Clean Design**: Modern black and white theme with excellent typography
- **Responsive Layout**: Works seamlessly across different screen sizes
- **Smooth Navigation**: Intuitive user flow from product selection to payment
- **Loading States**: Proper loading indicators and user feedback

## Screenshots

The app includes the following screens:
1. **Home Screen**: Product listing with search and navigation
2. **Product Detail**: Comprehensive product information
3. **Shopping Cart**: Cart management with quantity controls
4. **Payment Screen**: Secure Razorpay payment integration

## Prerequisites

Before running this app, ensure you have:

- Flutter SDK (>=2.18.0)
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- A Razorpay account for payment integration

## Installation & Setup

### 1. Clone the Repository
```bash
git clone <your-repository-url>
cd ecommerce_app
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Razorpay Configuration

#### Get Razorpay API Keys
1. Sign up at [Razorpay Dashboard](https://dashboard.razorpay.com/)
2. Navigate to Settings → API Keys
3. Generate Test/Live API keys

#### Update API Key
Replace the test key in `lib/screens/payment_screen.dart`:
```dart
'key': 'YOUR_RAZORPAY_KEY_HERE', // Replace with your actual key
```

### 4. Android Configuration

The app is pre-configured for Android with necessary permissions and activities. Key configurations include:

- **Internet Permission**: For API calls and payment processing
- **Razorpay Activity**: For handling payment callbacks
- **Minimum SDK**: API level 21 (Android 5.0)

### 5. Run the Application
```bash
flutter run
```

## Project Structure

```
ecommerce_app/
├── lib/
│   ├── main.dart                 # App entry point
│   ├── models/
│   │   └── product.dart          # Product data model
│   ├── screens/
│   │   ├── home_screen.dart      # Product listing
│   │   ├── product_detail_screen.dart  # Product details
│   │   ├── cart_screen.dart      # Shopping cart
│   │   └── payment_screen.dart   # Payment processing
│   └── services/
│       └── payment_service.dart  # Payment service abstraction
├── android/                      # Android-specific configurations
└── pubspec.yaml                 # Dependencies and metadata
```

## Key Components

### Product Model
```dart
class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
}
```

### Payment Integration
The app uses the `razorpay_flutter` package for payment processing:

```dart
void _openCheckout() {
  var options = {
    'key': 'YOUR_RAZORPAY_KEY',
    'amount': amount * 100, // Amount in paise
    'name': 'E-Commerce Store',
    'description': 'Payment for your order',
    'prefill': {
      'contact': '9876543210',
      'email': 'customer@example.com'
    }
  };
  _razorpay.open(options);
}
```

## Payment Flow

1. **Product Selection**: User browses and selects products
2. **Cart Management**: Items are added to cart with quantity controls
3. **Checkout Initiation**: User proceeds to payment screen
4. **Payment Processing**: Razorpay handles secure payment
5. **Status Handling**: Success/failure callbacks update the UI

## Customization

### Adding New Products
Update the products list in `home_screen.dart`:
```dart
final List<Product> products = [
  Product(
    id: 'new_id',
    name: 'New Product',
    description: 'Product description',
    price: 99.99,
    imageUrl: 'https://example.com/image.jpg',
  ),
];
```

### Styling
The app uses a consistent theme defined in `main.dart`. Customize colors, fonts, and spacing:
```dart
theme: ThemeData(
  primaryColor: Colors.black,
  scaffoldBackgroundColor: Colors.white,
  // Add your custom theme properties
),
```

## Testing

### Test Payment Integration
1. Use Razorpay test keys for development
2. Test different payment scenarios:
   - Successful payments
   - Failed payments
   - Payment cancellation
   - External wallet selection

### Test Cards (Razorpay Test Mode)
- **Success**: 4111 1111 1111 1111
- **Failure**: 4000 0000 0000 0002

## Production Deployment

### Security Considerations
1. **API Key Security**: Store Razorpay keys securely (environment variables)
2. **Signature Verification**: Implement server-side payment verification
3. **HTTPS**: Ensure all API calls use HTTPS
4. **Input Validation**: Validate all user inputs

### Backend Integration
For production, implement:
- Order management system
- Payment verification webhook
- User authentication
- Inventory management

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  razorpay_flutter: ^1.3.7
  cupertino_icons: ^1.0.2
```

## Troubleshooting

### Common Issues

1. **Razorpay not opening**
   - Check API key configuration
   - Verify internet permissions in AndroidManifest.xml

2. **Payment callbacks not working**
   - Ensure proper event listener setup
   - Check Razorpay activity configuration

3. **Build errors**
   - Run `flutter clean` and `flutter pub get`
   - Check minimum SDK version compatibility

### Debug Mode
Enable debug logging for payment issues:
```dart
debugPrint('Payment options: $options');
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support and questions:
- Check the [Flutter documentation](https://flutter.dev/docs)
- Review [Razorpay integration guide](https://razorpay.com/docs/payments/payment-gateway/flutter-integration/)
- Open an issue in this repository

## Acknowledgments

- Flutter team for the excellent framework
- Razorpay for secure payment processing
- Pexels for high-quality product images
- Material Design for UI guidelines

---

**Note**: This is a demonstration app. For production use, implement proper backend services, user authentication, and enhanced security measures.
