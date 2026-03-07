class CartListResponse {
  final String status;
  final String? message;
  final int totalRecords;
  final String itemTotal;
  final String discount;
  final String subTotal;
  final int minimumOrder;
  final String shortestDistance;
  final String deliveryCharge;
  final String gstPer;
  final String gstAmount;
  final String packagingCharges;
  final String finalOrderAmount;
  final Result result;
  final CouponDetails couponDetails;
  final String note;

  CartListResponse({
    required this.status,
    required this.message,
    required this.totalRecords,
    required this.itemTotal,
    required this.discount,
    required this.subTotal,
    required this.minimumOrder,
    required this.shortestDistance,
    required this.deliveryCharge,
    required this.gstPer,
    required this.gstAmount,
    required this.packagingCharges,
    required this.finalOrderAmount,
    required this.result,
    required this.couponDetails,
    required this.note,
  });

  factory CartListResponse.fromJson(Map<String, dynamic> json) {
    return CartListResponse(
      status: json['status'],
      message: json["message"],
      totalRecords: json['totalRecords'],
      itemTotal: json['itemTotal'],
      discount: json['discount'],
      subTotal: json['subTotal'],
      minimumOrder: json['minimumOrder'],
      shortestDistance: json['shortestDistance'],
      deliveryCharge: json['deliveryCharge'],
      gstPer: json['gstPer'],
      gstAmount: json['gstAmount'],
      packagingCharges: json['packagingCharges'],
      finalOrderAmount: json['finalOrderAmount'],
      result: Result.fromJson(json['result']),
      couponDetails: CouponDetails.fromJson(json['couponDetails']),
      note: json['note'],
    );
  }
}

class Result {
  final List<Product> products;
  final List<Slot> slotList;

  Result({required this.products, required this.slotList});

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      products: (json['products'] as List)
          .map((e) => Product.fromJson(e))
          .toList(),
      slotList: (json['slotList'] as List)
          .map((e) => Slot.fromJson(e))
          .toList(),
    );
  }
}

class Product {
  final String id;
  final String productName;
  final String productDescription;
  final String minimumSellingQuantity;
  final String productUom;
  final String sellingUnit;
  final String productStatus;
  final String regularPrice;
  final String sellingPrice;
  final String quantity;
  bool isInCart;
  final bool isInWishlist;
  dynamic cartQuantity;
  final String totalPrice;
  final List<String> images;
  final List<RateVariant> rateVariants;

  Product({
    required this.id,
    required this.productName,
    required this.productDescription,
    required this.minimumSellingQuantity,
    required this.productUom,
    required this.sellingUnit,
    required this.productStatus,
    required this.regularPrice,
    required this.sellingPrice,
    required this.quantity,
    required this.isInCart,
    required this.isInWishlist,
    required this.cartQuantity,
    required this.totalPrice,
    required this.images,
    required this.rateVariants,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      productName: json['productName'],
      productDescription: json['productDescription'],
      minimumSellingQuantity: json['minimumSellingQuantity'],
      productUom: json['productUom'],
      sellingUnit: json['sellingUnit'],
      productStatus: json['productStatus'],
      regularPrice: json['regularPrice'],
      sellingPrice: json['sellingPrice'],
      quantity: json['quantity'],
      isInCart: json['isInCart'],
      isInWishlist: json['isInWishlist'],
      cartQuantity: json['cartQuantity'],
      totalPrice: json['totalPrice'],
      images: List<String>.from(json['images']),
      rateVariants: (json['rate_variants'] as List? ?? [])
          .map((e) => RateVariant.fromJson(e))
          .toList(),
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
  bool isInCart;
  int cartQuantity;
  String cartCode;

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

class Slot {
  final String code;
  final String slotTitle;
  final String startTime;
  final String endTime;
  final String deliveryCharge;
  final int isSelected;

  Slot({
    required this.code,
    required this.slotTitle,
    required this.startTime,
    required this.endTime,
    required this.deliveryCharge,
    required this.isSelected,
  });

  factory Slot.fromJson(Map<String, dynamic> json) {
    return Slot(
      code: json['code'],
      slotTitle: json['slotTitle'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      deliveryCharge: json['deliveryCharge'],
      isSelected: json['isSelected'],
    );
  }
}

class CouponDetails {
  final String nextLimit;
  final String message;
  final String submessage;
  final String totalAmount;
  final String discountApplied;

  CouponDetails({
    required this.nextLimit,
    required this.message,
    required this.submessage,
    required this.totalAmount,
    required this.discountApplied,
  });

  factory CouponDetails.fromJson(Map<String, dynamic> json) {
    return CouponDetails(
      nextLimit: json['nextLimit'],
      message: json['message'],
      submessage: json['submessage'],
      totalAmount: json['totalAmount'],
      discountApplied: json['discountApplied'],
    );
  }
}
