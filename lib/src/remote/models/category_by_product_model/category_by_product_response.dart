class ProductByCategoryResponse {
  final String status;
  final String? message;
  final int totalRecords;
  final ProductResult result;

  ProductByCategoryResponse({
    required this.status,
    this.message,
    required this.totalRecords,
    required this.result,
  });

  factory ProductByCategoryResponse.fromJson(Map<String, dynamic> json) {
    return ProductByCategoryResponse(
      status: json['status'] ?? '',
      message: json["message"],
      totalRecords: json['totalRecords'] ?? 0,
      result: ProductResult.fromJson(json['result']),
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'totalRecords': totalRecords,
    'result': result.toJson(),
  };
}

class ProductResult {
  final List<Product> products;

  ProductResult({required this.products});

  factory ProductResult.fromJson(Map<String, dynamic> json) {
    var list = json['products'] as List? ?? [];
    return ProductResult(
      products: list.map((e) => Product.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'products': products.map((e) => e.toJson()).toList(),
  };
}

class Product {
  final String id;
  final String code;
  final String hsnCode;
  final String taxPercent;
  final String productName;
  final String productDescription;
  final String minimumSellingQuantity;
  final String productUom;
  final String productRegularPrice;
  final String productSellingPrice;
  final String productStatus;
  final String cityCode;
  final String regularPrice;
  final String sellingUnit;
  final String quantity;
  final String isActive;
  final String tagCode;
  final String tagTitle;
  final String tagColor;
  final String variantsCode;
  final String isMainVariant;
  final String subCategoryId;
  final bool isInCart;
  final int cartQuantity;
  final String cartCode;
  final bool isInWishlist;
  final String sellingPrice;
  final List<String> images;
  final List<RateVariant> rateVariants;

  Product({
    required this.id,
    required this.code,
    required this.hsnCode,
    required this.taxPercent,
    required this.productName,
    required this.productDescription,
    required this.minimumSellingQuantity,
    required this.productUom,
    required this.productRegularPrice,
    required this.productSellingPrice,
    required this.productStatus,
    required this.cityCode,
    required this.regularPrice,
    required this.sellingUnit,
    required this.quantity,
    required this.isActive,
    required this.tagCode,
    required this.tagTitle,
    required this.tagColor,
    required this.variantsCode,
    required this.isMainVariant,
    required this.subCategoryId,
    required this.isInCart,
    required this.cartQuantity,
    required this.cartCode,
    required this.isInWishlist,
    required this.sellingPrice,
    required this.images,
    required this.rateVariants,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    var imgList = json['images'] as List? ?? [];
    var variantList = json['rate_variants'] as List? ?? [];
    return Product(
      id: json['id'] ?? '',
      code: json['code'] ?? '',
      hsnCode: json['hsnCode'] ?? '',
      taxPercent: json['taxPercent'] ?? '',
      productName: json['productName'] ?? '',
      productDescription: json['productDescription'] ?? '',
      minimumSellingQuantity: json['minimumSellingQuantity'] ?? '',
      productUom: json['productUom'] ?? '',
      productRegularPrice: json['productRegularPrice'] ?? '',
      productSellingPrice: json['productSellingPrice'] ?? '',
      productStatus: json['productStatus'] ?? '',
      cityCode: json['cityCode'] ?? '',
      regularPrice: json['regularPrice'] ?? '',
      sellingUnit: json['sellingUnit'] ?? '',
      quantity: json['quantity'] ?? '',
      isActive: json['isActive'] ?? '',
      tagCode: json['tagCode'] ?? '',
      tagTitle: json['tagTitle'] ?? '',
      tagColor: json['tagColor'] ?? '',
      variantsCode: json['variantsCode'] ?? '',
      isMainVariant: json['isMainVariant'] ?? '',
      subCategoryId: json['subCategoryId'] ?? '',
      isInCart: json['isInCart'] ?? false,
      cartQuantity: json['cartQuantity'] ?? 0,
      cartCode: json['cartCode'] ?? '',
      isInWishlist: json['isInWishlist'] ?? false,
      sellingPrice: json['sellingPrice'] ?? '',
      images: imgList.map((e) => e.toString()).toList(),
      rateVariants: variantList.map((e) => RateVariant.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'code': code,
    'hsnCode': hsnCode,
    'taxPercent': taxPercent,
    'productName': productName,
    'productDescription': productDescription,
    'minimumSellingQuantity': minimumSellingQuantity,
    'productUom': productUom,
    'productRegularPrice': productRegularPrice,
    'productSellingPrice': productSellingPrice,
    'productStatus': productStatus,
    'cityCode': cityCode,
    'regularPrice': regularPrice,
    'sellingUnit': sellingUnit,
    'quantity': quantity,
    'isActive': isActive,
    'tagCode': tagCode,
    'tagTitle': tagTitle,
    'tagColor': tagColor,
    'variantsCode': variantsCode,
    'isMainVariant': isMainVariant,
    'subCategoryId': subCategoryId,
    'isInCart': isInCart,
    'cartQuantity': cartQuantity,
    'cartCode': cartCode,
    'isInWishlist': isInWishlist,
    'sellingPrice': sellingPrice,
    'images': images,
    'rate_variants': rateVariants.map((e) => e.toJson()).toList(),
  };
}

class RateVariant {
  final String variantsCode;
  final String cityCode;
  final String sellingUnit;
  final String quantity;
  final String productStatus;
  final String sellingPrice;
  final String regularPrice;
  final String productDiscount;
  final String isMainVariant;
  final bool isInCart;
  final int cartQuantity;
  final String cartCode;

  RateVariant({
    required this.variantsCode,
    required this.cityCode,
    required this.sellingUnit,
    required this.quantity,
    required this.productStatus,
    required this.sellingPrice,
    required this.regularPrice,
    required this.productDiscount,
    required this.isMainVariant,
    required this.isInCart,
    required this.cartQuantity,
    required this.cartCode,
  });

  factory RateVariant.fromJson(Map<String, dynamic> json) {
    return RateVariant(
      variantsCode: json['variantsCode'] ?? '',
      cityCode: json['cityCode'] ?? '',
      sellingUnit: json['sellingUnit'] ?? '',
      quantity: json['quantity'] ?? '',
      productStatus: json['productStatus'] ?? '',
      sellingPrice: json['sellingPrice'] ?? '',
      regularPrice: json['regularPrice'] ?? '',
      productDiscount: json['productDiscount'] ?? '',
      isMainVariant: json['isMainVariant'] ?? '',
      isInCart: json['isInCart'] ?? false,
      cartQuantity: json['cartQuantity'] ?? 0,
      cartCode: json['cartCode'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'variantsCode': variantsCode,
    'cityCode': cityCode,
    'sellingUnit': sellingUnit,
    'quantity': quantity,
    'productStatus': productStatus,
    'sellingPrice': sellingPrice,
    'regularPrice': regularPrice,
    'productDiscount': productDiscount,
    'isMainVariant': isMainVariant,
    'isInCart': isInCart,
    'cartQuantity': cartQuantity,
    'cartCode': cartCode,
  };
}
