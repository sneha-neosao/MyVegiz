import 'package:flutter/material.dart';
import 'package:myvegiz_flutter/src/features/vegetablesAndGrocery/widgets/category_product_card_widget.dart';

import '../../../remote/models/category_by_product_model/category_by_product_response.dart';

class ProductListWidget extends StatelessWidget {
  final List<Product> products;

  const ProductListWidget({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return CategoryProductCardWidget(product: products[index]);
      },
    );
  }
}
