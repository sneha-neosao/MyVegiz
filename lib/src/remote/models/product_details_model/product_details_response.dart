import 'package:myvegiz_flutter/src/remote/models/category_by_product_model/category_by_product_response.dart';

class ProductDetailsResponse {
  final String status;
  final String? message;
  final ProductDetailsResult result;

  ProductDetailsResponse({
    required this.status,
    this.message,
    required this.result,
  });

  factory ProductDetailsResponse.fromJson(Map<String, dynamic> json) {
    return ProductDetailsResponse(
      status: json['status'] ?? '',
      message: json['message'],
      result: json['result'] != null
          ? ProductDetailsResult.fromJson(json['result'])
          : ProductDetailsResult(product: null),
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'result': result.toJson(),
  };
}

class ProductDetailsResult {
  final Product? product;

  ProductDetailsResult({required this.product});

  factory ProductDetailsResult.fromJson(Map<String, dynamic>? json) {
    if (json == null) return ProductDetailsResult(product: null);

    // Product by id API returns a single product object instead of a list
    final dynamic productData = json['products'];
    if (productData is Map<String, dynamic>) {
      return ProductDetailsResult(product: Product.fromJson(productData));
    }
    return ProductDetailsResult(product: null);
  }

  Map<String, dynamic> toJson() => {'products': product?.toJson() ?? {}};
}
