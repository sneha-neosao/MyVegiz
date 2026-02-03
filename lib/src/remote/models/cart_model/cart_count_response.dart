class CartCountResponse {
  final String status;
  final String message;
  final CartResult result;

  CartCountResponse({
    required this.status,
    required this.message,
    required this.result,
  });

  factory CartCountResponse.fromJson(Map<String, dynamic> json) {
    return CartCountResponse(
      status: json['status'],
      message: json['message'],
      result: CartResult.fromJson(json['result']),
    );
  }
}

class CartResult {
  final String cartAmount;
  final int groceryCartCount;

  CartResult({
    required this.cartAmount,
    required this.groceryCartCount,
  });

  factory CartResult.fromJson(Map<String, dynamic> json) {
    return CartResult(
      cartAmount: json['cartAmount'],
      groceryCartCount: json['groceryCartCount'],
    );
  }
}
