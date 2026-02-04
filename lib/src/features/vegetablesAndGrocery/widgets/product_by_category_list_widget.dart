import 'package:flutter/material.dart';
import 'package:myvegiz_flutter/src/features/vegetablesAndGrocery/widgets/product_by_card_widget.dart';

import '../../../remote/models/category_by_product_model/category_by_product_response.dart';

class ProductByCategoryListWidget extends StatelessWidget {
  final List<Product> products;
  final String clientCode;

  const ProductByCategoryListWidget({super.key, required this.products, required this.clientCode});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: products.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return CategoryByProductCardWidget(product: products[index],clientCode: clientCode,);
      },
    );
  }
}
