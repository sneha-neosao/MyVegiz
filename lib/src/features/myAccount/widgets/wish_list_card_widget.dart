import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myvegiz_flutter/src/configs/injector/injector.dart';
import 'package:myvegiz_flutter/src/core/extensions/integer_sizedbox_extension.dart';
import 'package:myvegiz_flutter/src/core/session/session_manager.dart';
import 'package:myvegiz_flutter/src/core/themes/app_color.dart';
import 'package:myvegiz_flutter/src/features/widgets/app_loading_widget.dart';
import 'package:myvegiz_flutter/src/remote/models/wish_list_model/wish_list_response.dart';

import '../../../configs/injector/injector_conf.dart';

class WishListCardWidget extends StatefulWidget {
  final WishlistItem wishlistItem;
  final String clientCode;

  const WishListCardWidget({
    super.key,
    required this.wishlistItem,
    required this.clientCode,
  });

  @override
  State<WishListCardWidget> createState() =>
      _WishListCardWidgetState();
}

class _WishListCardWidgetState extends State<WishListCardWidget> {
  late bool _isInWishlist; // local state
  late String citCode;

  @override
  void initState() {
    super.initState();
    _loadCityCode();
    _isInWishlist = widget.wishlistItem.isInWishlist; // initialize from product
  }

  void _loadCityCode() async {
    final cityCode = await SessionManager.getCityCode();

    setState(() {
      citCode = cityCode!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AddToWishListBloc>(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Left image box
                Container(
                  height: 85,
                  width: 85,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColor.black,
                    image: widget.wishlistItem.images.isNotEmpty
                        ? DecorationImage(
                      image: NetworkImage(widget.wishlistItem.images.first),
                      fit: BoxFit.fill,
                    )
                        : null,
                  ),
                ),

                // Right side content
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.wishlistItem.productName,
                              style: GoogleFonts.mavenPro(
                                color: AppColor.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const Spacer(),
                            BlocConsumer<AddToWishListBloc, AddToWishListState>(
                              listener: (context, state) {
                                if (state is AddToWishListFailureState) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(state.message)),
                                  );
                                } else if (state is AddToWishListSuccessState) {
                                  context.read<WishListBloc>().add(WishListGetEvent(widget.clientCode, 'MCAT_1', citCode));
                                  // Toggle local state on success
                                  // setState(() {
                                  //   _isInWishlist = !_isInWishlist;
                                  // });
                                }
                              },
                              builder: (context, state) {
                                if (state is AddToWishListLoadingState) {
                                  return const SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: AppLoadingWidget(strokeWidth: 4,),
                                  );
                                }

                                return InkWell(
                                  onTap: () {
                                    context.read<AddToWishListBloc>().add( AddToWishListGetEvent( widget.wishlistItem.code, widget.clientCode, ), );
                                    },
                                  child: Container(
                                    height: 24,
                                    width: 24,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColor.hintText.withOpacity(0.4),
                                    ),
                                    child: const Icon(
                                      Icons.close_rounded, color:
                                    AppColor.black,
                                      size: 18,
                                    ),
                                  ),
                                );

                              },
                            )
                          ],
                        ),

                        // Quantity + UOM
                        Container(
                          width: 105,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: AppColor.brightRed.withOpacity(0.1),
                            border: Border.all(
                              width: 1,
                              color: AppColor.middleOrangeButton,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${widget.wishlistItem.quantity} ${widget.wishlistItem.sellingUnit}",
                                  style: GoogleFonts.mavenPro(
                                    color: AppColor.gray,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: AppColor.black,
                                  size: 22,
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Price + discount + add button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "₹${widget.wishlistItem.regularPrice}",
                                  style: GoogleFonts.mavenPro(
                                    color: AppColor.grayShade,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "₹${widget.wishlistItem.sellingPrice}",
                                      style: GoogleFonts.mavenPro(
                                        color: AppColor.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    4.wS,
                                    if (widget.wishlistItem.rateVariants.isNotEmpty)
                                      Container(
                                        width: 40,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(6),
                                          gradient: const LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                              AppColor.startOrangeButton,
                                              AppColor.middleOrangeButton,
                                              AppColor.endOrangeButton,
                                            ],
                                          ),
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Text(
                                              widget.wishlistItem.rateVariants.first
                                                  .productDiscount,
                                              style: GoogleFonts.mavenPro(
                                                color: AppColor.white,
                                                fontSize: 9,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                  ],
                                )
                              ],
                            ),
                            Container(
                              width: 110,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  width: 1,
                                  color: AppColor.middleOrangeButton,
                                ),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 6.0, horizontal: 8),
                                  child: Text(
                                    widget.wishlistItem.isInCart ? "ICART" : "ADD",
                                    style: GoogleFonts.mavenPro(
                                      color: AppColor.orange,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
