class CartListResponse {
  final int status;
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
  final bool isInCart;
  final bool isInWishlist;
  final String cartQuantity;
  final String totalPrice;
  final List<String> images;

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
