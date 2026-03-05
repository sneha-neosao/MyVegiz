class AddToCartResponse {
  final String? status;
  final String? message;
  final String? cartCode;

  AddToCartResponse({this.status, this.message, this.cartCode});

  factory AddToCartResponse.fromJson(Map<String, dynamic> json) =>
      AddToCartResponse(
        status: json["status"],
        message: json["message"],
        cartCode: json["cartCode"],
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "cartCode": cartCode,
  };
}
