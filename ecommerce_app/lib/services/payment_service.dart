import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentService {
  late Razorpay _razorpay;
  
  // Callback functions
  Function(PaymentSuccessResponse)? onPaymentSuccess;
  Function(PaymentFailureResponse)? onPaymentError;
  Function(ExternalWalletResponse)? onExternalWallet;

  PaymentService() {
    _initializeRazorpay();
  }

  void _initializeRazorpay() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    if (onPaymentSuccess != null) {
      onPaymentSuccess!(response);
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    if (onPaymentError != null) {
      onPaymentError!(response);
    }
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    if (onExternalWallet != null) {
      onExternalWallet!(response);
    }
  }

  void openCheckout({
    required double amount,
    required String orderId,
    String? customerName,
    String? customerEmail,
    String? customerPhone,
    String? description,
  }) {
    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag', // Replace with your actual Razorpay key
      'amount': (amount * 100).toInt(), // Amount in paise
      'name': 'E-Commerce Store',
      'order_id': orderId,
      'description': description ?? 'Payment for your order',
      'timeout': 300, // 5 minutes timeout
      'prefill': {
        'contact': customerPhone ?? '9876543210',
        'email': customerEmail ?? 'customer@example.com',
        'name': customerName ?? 'Customer',
      },
      'external': {
        'wallets': ['paytm']
      },
      'theme': {
        'color': '#000000'
      },
      'modal': {
        'ondismiss': () {
          debugPrint('Payment modal dismissed');
        }
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error opening Razorpay: $e');
      throw Exception('Failed to open payment gateway');
    }
  }

  // Generate order ID (in real app, this should come from your backend)
  String generateOrderId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return 'order_$timestamp';
  }

  // Verify payment signature (should be done on backend in production)
  bool verifyPaymentSignature({
    required String paymentId,
    required String orderId,
    required String signature,
    required String razorpaySecret,
  }) {
    // This is a simplified version - in production, signature verification
    // should be done on your secure backend server
    try {
      // Implementation would involve HMAC SHA256 verification
      // For demo purposes, we'll return true
      return true;
    } catch (e) {
      debugPrint('Signature verification failed: $e');
      return false;
    }
  }

  void dispose() {
    _razorpay.clear();
  }
}

// Payment status enum
enum PaymentStatus {
  pending,
  success,
  failed,
  cancelled,
}

// Payment result model
class PaymentResult {
  final PaymentStatus status;
  final String? paymentId;
  final String? orderId;
  final String? signature;
  final String? errorMessage;
  final int? errorCode;

  PaymentResult({
    required this.status,
    this.paymentId,
    this.orderId,
    this.signature,
    this.errorMessage,
    this.errorCode,
  });

  factory PaymentResult.success({
    required String paymentId,
    required String orderId,
    required String signature,
  }) {
    return PaymentResult(
      status: PaymentStatus.success,
      paymentId: paymentId,
      orderId: orderId,
      signature: signature,
    );
  }

  factory PaymentResult.failed({
    required String errorMessage,
    int? errorCode,
  }) {
    return PaymentResult(
      status: PaymentStatus.failed,
      errorMessage: errorMessage,
      errorCode: errorCode,
    );
  }

  factory PaymentResult.cancelled() {
    return PaymentResult(
      status: PaymentStatus.cancelled,
      errorMessage: 'Payment cancelled by user',
    );
  }
}
