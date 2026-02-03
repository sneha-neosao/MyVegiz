class WishlistResponse {
  final String status;
  final String? message;
  final int totalResult;
  final WishlistResult result;

  WishlistResponse({
    required this.status,
    this.message,
    required this.totalResult,
    required this.result,
  });

  factory WishlistResponse.fromJson(Map<String, dynamic> json) {
    return WishlistResponse(
      status: json['status'] ?? '',
      message: json["message"],
      totalResult: json['totalresult'] ?? 0,
      result: WishlistResult.fromJson(json['result']),
    );
  }
}

class WishlistResult {
  final List<WishlistItem> wishlist;

  WishlistResult({required this.wishlist});

  factory WishlistResult.fromJson(Map<String, dynamic> json) {
    return WishlistResult(
      wishlist: (json['wishlist'] as List<dynamic>)
          .map((e) => WishlistItem.fromJson(e))
          .toList(),
    );
  }
}

class WishlistItem {
  final String id;
  final String code;
  final String productName;
  final String mainCategoryCode;
  final String productCategory;
  final String? subCategoryCode;
  final String? storageCode;
  final String productDescription;
  final String minimumSellingQuantity;
  final String productUom;
  final String productSellingPrice;
  final String productRegularPrice;
  final String productStatus;
  final String? isActive;
  final String isDelete;
  final String productCode;
  final String cityCode;
  final String sellingUnit;
  final String quantity;
  final String sellingPrice;
  final String regularPrice;
  final String variantsCode;
  final String isMainVariant;
  final bool isInCart;
  final bool isInWishlist;
  final int cartQuantity;
  final String cartCode;
  final String wishlistCode;
  final List<RateVariant> rateVariants;
  final List<String> images;

  WishlistItem({
    required this.id,
    required this.code,
    required this.productName,
    required this.mainCategoryCode,
    required this.productCategory,
    this.subCategoryCode,
    this.storageCode,
    required this.productDescription,
    required this.minimumSellingQuantity,
    required this.productUom,
    required this.productSellingPrice,
    required this.productRegularPrice,
    required this.productStatus,
    this.isActive,
    required this.isDelete,
    required this.productCode,
    required this.cityCode,
    required this.sellingUnit,
    required this.quantity,
    required this.sellingPrice,
    required this.regularPrice,
    required this.variantsCode,
    required this.isMainVariant,
    required this.isInCart,
    required this.isInWishlist,
    required this.cartQuantity,
    required this.cartCode,
    required this.wishlistCode,
    required this.rateVariants,
    required this.images,
  });

  factory WishlistItem.fromJson(Map<String, dynamic> json) {
    return WishlistItem(
      id: json['id'] ?? '',
      code: json['code'] ?? '',
      productName: json['productName'] ?? '',
      mainCategoryCode: json['mainCategoryCode'] ?? '',
      productCategory: json['productCategory'] ?? '',
      subCategoryCode: json['subCategoryCode'],
      storageCode: json['storageCode'],
      productDescription: json['productDescription'] ?? '',
      minimumSellingQuantity: json['minimumSellingQuantity'] ?? '',
      productUom: json['productUom'] ?? '',
      productSellingPrice: json['productSellingPrice'] ?? '',
      productRegularPrice: json['productRegularPrice'] ?? '',
      productStatus: json['productStatus'] ?? '',
      isActive: json['isActive'],
      isDelete: json['isDelete'] ?? '',
      productCode: json['productCode'] ?? '',
      cityCode: json['cityCode'] ?? '',
      sellingUnit: json['sellingUnit'] ?? '',
      quantity: json['quantity'] ?? '',
      sellingPrice: json['sellingPrice'] ?? '',
      regularPrice: json['regularPrice'] ?? '',
      variantsCode: json['variantsCode'] ?? '',
      isMainVariant: json['isMainVariant'] ?? '',
      isInCart: json['isInCart'] ?? false,
      isInWishlist: json['isInWishlist'] ?? false,
      cartQuantity: json['cartQuantity'] ?? 0,
      cartCode: json['cartCode'] ?? '',
      wishlistCode: json['wishlistCode'] ?? '',
      rateVariants: (json['rate_variants'] as List<dynamic>)
          .map((e) => RateVariant.fromJson(e))
          .toList(),
      images: (json['images'] as List<dynamic>).map((e) => e.toString()).toList(),
    );
  }
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
}
