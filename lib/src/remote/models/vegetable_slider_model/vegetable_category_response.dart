import 'dart:convert';

class VegetableCategoryResponse {
  final String status;
  final String? message;
  final int totalRecords;
  final Result result;

  VegetableCategoryResponse({
    required this.status,
    required this.message,
    required this.totalRecords,
    required this.result,
  });

  factory VegetableCategoryResponse.fromJson(Map<String, dynamic> json) {
    return VegetableCategoryResponse(
      status: json['status'] ?? '',
      message: json["message"] ?? "",
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
  final String mainCategoryCode;
  final String categoryName;
  final String categorySName;
  final String categoryImage;
  final String isActive;
  final String isDelete;
  final String addID;
  final String addIP;
  final String addDate;
  final String? editIP;
  final String? editID;
  final String? editDate;
  final String? deleteID;
  final String? deleteIP;
  final String? deleteDate;

  Category({
    required this.id,
    required this.code,
    required this.mainCategoryCode,
    required this.categoryName,
    required this.categorySName,
    required this.categoryImage,
    required this.isActive,
    required this.isDelete,
    required this.addID,
    required this.addIP,
    required this.addDate,
    this.editIP,
    this.editID,
    this.editDate,
    this.deleteID,
    this.deleteIP,
    this.deleteDate,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? '',
      code: json['code'] ?? '',
      mainCategoryCode: json['mainCategoryCode'] ?? '',
      categoryName: json['categoryName'] ?? '',
      categorySName: json['categorySName'] ?? '',
      categoryImage: json['categoryImage'] ?? '',
      isActive: json['isActive'] ?? '',
      isDelete: json['isDelete'] ?? '',
      addID: json['addID'] ?? '',
      addIP: json['addIP'] ?? '',
      addDate: json['addDate'] ?? '',
      editIP: json['editIP'],
      editID: json['editID'],
      editDate: json['editDate'],
      deleteID: json['deleteID'],
      deleteIP: json['deleteIP'],
      deleteDate: json['deleteDate'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'code': code,
    'mainCategoryCode': mainCategoryCode,
    'categoryName': categoryName,
    'categorySName': categorySName,
    'categoryImage': categoryImage,
    'isActive': isActive,
    'isDelete': isDelete,
    'addID': addID,
    'addIP': addIP,
    'addDate': addDate,
    'editIP': editIP,
    'editID': editID,
    'editDate': editDate,
    'deleteID': deleteID,
    'deleteIP': deleteIP,
    'deleteDate': deleteDate,
  };
}
