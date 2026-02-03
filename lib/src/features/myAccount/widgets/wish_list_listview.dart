import 'package:flutter/material.dart';
import 'package:myvegiz_flutter/src/features/myAccount/widgets/wish_list_card_widget.dart';
import 'package:myvegiz_flutter/src/remote/models/wish_list_model/wish_list_response.dart';

class WishListWidget extends StatelessWidget {
  final List<WishlistItem> wishList;
  final String clientCode;

  const WishListWidget({super.key, required this.wishList, required this.clientCode});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: wishList.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return WishListCardWidget(wishlistItem: wishList[index],clientCode: clientCode,);
      },
    );
  }
}
