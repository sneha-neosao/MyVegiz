import 'dart:convert';

class CategoryAndProductResponse {
  final String status;
  final String? message;
  final int totalRecords;
  final Result result;

  CategoryAndProductResponse({
    required this.status,
    this.message,
    required this.totalRecords,
    required this.result,
  });

  factory CategoryAndProductResponse.fromJson(Map<String, dynamic> json) {
    return CategoryAndProductResponse(
      status: json['status'] ?? '',
      message: json["message"],
      totalRecords: json['totalRecords'] ?? 0,
      result: Result.fromJson(json['result']),
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'totalRecords': totalRecords,
    'result': result.toJson(),
  };
}

class Result {
  final List<Category> categories;

  Result({required this.categories});

  factory Result.fromJson(Map<String, dynamic> json) {
    var list = json['categories'] as List? ?? [];
    return Result(
      categories: list.map((e) => Category.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'categories': categories.map((e) => e.toJson()).toList(),
  };
}

class Category {
  final String id;
  final String code;
  final String categoryName;
  final String categorySName;
  final String categoryImage;
  final String isActive;
  final ProductList? productList;

  Category({
    required this.id,
    required this.code,
    required this.categoryName,
    required this.categorySName,
    required this.categoryImage,
    required this.isActive,
    this.productList,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? '',
      code: json['code'] ?? '',
      categoryName: json['categoryName'] ?? '',
      categorySName: json['categorySName'] ?? '',
      categoryImage: json['categoryImage'] ?? '',
      isActive: json['isActive'] ?? '',
      productList: json['productList'] != null
          ? ProductList.fromJson(json['productList'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'code': code,
    'categoryName': categoryName,
    'categorySName': categorySName,
    'categoryImage': categoryImage,
    'isActive': isActive,
    'productList': productList?.toJson(),
  };
}

class ProductList {
  final List<Product> products;

  ProductList({required this.products});

  factory ProductList.fromJson(Map<String, dynamic> json) {
    var list = json['products'] as List? ?? [];
    return ProductList(
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
  final String productName;
  final String regularPrice;
  final String sellingPrice;
  final List<String> images;
  final List<RateVariant> rateVariants;

  Product({
    required this.id,
    required this.code,
    required this.productName,
    required this.regularPrice,
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
      productName: json['productName'] ?? '',
      regularPrice: json['regularPrice'] ?? '',
      sellingPrice: json['sellingPrice'] ?? '',
      images: imgList.map((e) => e.toString()).toList(),
      rateVariants: variantList.map((e) => RateVariant.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'code': code,
    'productName': productName,
    'regularPrice': regularPrice,
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
  final int sellingPrice;
  final int regularPrice;
  final int productDiscount;
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
      sellingPrice: json['sellingPrice'] ?? 0,
      regularPrice: json['regularPrice'] ?? 0,
      productDiscount: json['productDiscount'] ?? 0,
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

