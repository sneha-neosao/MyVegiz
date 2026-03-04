import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myvegiz_flutter/src/configs/injector/injector.dart';
import 'package:myvegiz_flutter/src/core/extensions/integer_sizedbox_extension.dart';
import 'package:myvegiz_flutter/src/core/themes/app_color.dart';
import 'package:myvegiz_flutter/src/features/cart/domain/add_to_cart_usecase.dart';
import 'package:myvegiz_flutter/src/features/widgets/app_loading_widget.dart';
import '../../../configs/injector/injector_conf.dart';
import '../../../remote/models/category_by_product_model/category_by_product_response.dart';

class CategoryByProductCardWidget extends StatefulWidget {
  final Product product;
  final String clientCode;

  const CategoryByProductCardWidget({
    super.key,
    required this.product,
    required this.clientCode,
  });

  @override
  State<CategoryByProductCardWidget> createState() =>
      _CategoryByProductCardWidgetState();
}

class _CategoryByProductCardWidgetState
    extends State<CategoryByProductCardWidget> {
  late bool _isInWishlist; // local state
  late RateVariant _selectedVariant;
  late bool _isCurrentlyInCart;

  @override
  void initState() {
    super.initState();
    _isInWishlist = widget.product.isInWishlist; // initialize from product

    // Initialize selected variant. Use main variant or first one available.
    _selectedVariant = widget.product.rateVariants.firstWhere(
      (v) => v.isMainVariant == "1",
      orElse: () => widget.product.rateVariants.first,
    );
    _isCurrentlyInCart = _selectedVariant.isInCart;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<AddToWishListBloc>()),
        BlocProvider(create: (_) => getIt<AddToCartBloc>()),
      ],
      child: BlocListener<AddToCartBloc, AddToCartState>(
        listener: (context, state) {
          if (state is AddToCartSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.response.message ?? "Added to cart"),
              ),
            );
            setState(() {
              _isCurrentlyInCart = true;
            });
          } else if (state is AddToCartFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
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
                    image: widget.product.images.isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(widget.product.images.first),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                widget.product.productName
                                    .replaceAll(RegExp(r'\s+'), ' ')
                                    .trim(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.mavenPro(
                                  color: AppColor.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),

                            const SizedBox(width: 8),

                            BlocConsumer<AddToWishListBloc, AddToWishListState>(
                              listener: (context, state) {
                                if (state is AddToWishListFailureState) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(state.message)),
                                  );
                                } else if (state is AddToWishListSuccessState) {
                                  setState(() {
                                    _isInWishlist = !_isInWishlist;
                                  });
                                }
                              },
                              builder: (context, state) {
                                if (state is AddToWishListLoadingState) {
                                  return const SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: AppLoadingWidget(strokeWidth: 4),
                                  );
                                }

                                return InkWell(
                                  onTap: () {
                                    context.read<AddToWishListBloc>().add(
                                      AddToWishListGetEvent(
                                        widget.product.code,
                                        widget.clientCode,
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Image.asset(
                                      "assets/icons/filled_heart_icon.png",
                                      color: _isInWishlist
                                          ? AppColor.brightRed
                                          : AppColor.hintText,
                                      height: 20,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),

                        // Quantity + UOM
                        InkWell(
                          onTap: () {
                            _showVariantDialog(context, widget.product);
                          },
                          child: Container(
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
                                horizontal: 8.0,
                                vertical: 2,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${_selectedVariant.quantity} ${_selectedVariant.sellingUnit}",
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
                        ),

                        // Price + discount + add button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "₹${_selectedVariant.regularPrice}",
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
                                      "₹${_selectedVariant.sellingPrice}",
                                      style: GoogleFonts.mavenPro(
                                        color: AppColor.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    4.wS,
                                    if (_selectedVariant
                                            .productDiscount
                                            .isNotEmpty &&
                                        _selectedVariant.productDiscount !=
                                            "0% Off")
                                      Container(
                                        width: 40,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
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
                                              _selectedVariant.productDiscount,
                                              style: GoogleFonts.mavenPro(
                                                color: AppColor.white,
                                                fontSize: 9,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                            BlocBuilder<AddToCartBloc, AddToCartState>(
                              builder: (context, state) {
                                return InkWell(
                                  onTap: () {
                                    if (!_isCurrentlyInCart) {
                                      context.read<AddToCartBloc>().add(
                                        AddProductToCartEvent(
                                          AddToCartParams(
                                            clientCode: widget.clientCode,
                                            price:
                                                _selectedVariant.sellingPrice,
                                            productCode: widget.product.code,
                                            productName:
                                                widget.product.productName,
                                            quantity: "1",
                                            sellingQuantity:
                                                _selectedVariant.quantity,
                                            unit: _selectedVariant.sellingUnit,
                                            unitId:
                                                _selectedVariant.variantsCode,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  child: Container(
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
                                          vertical: 6.0,
                                          horizontal: 8,
                                        ),
                                        child: state is AddToCartLoading
                                            ? const SizedBox(
                                                height: 20,
                                                width: 20,
                                                child: AppLoadingWidget(
                                                  strokeWidth: 3,
                                                ),
                                              )
                                            : Text(
                                                _isCurrentlyInCart
                                                    ? "ICART"
                                                    : "ADD",
                                                style: GoogleFonts.mavenPro(
                                                  color: AppColor.orange,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
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

  void _showVariantDialog(BuildContext context, Product product) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.productName.replaceAll(RegExp(r'\s+'), ' ').trim(),
                  style: GoogleFonts.mavenPro(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColor.black,
                  ),
                ),
                const SizedBox(height: 20),
                ...product.rateVariants.map((variant) {
                  final isSelected =
                      variant.variantsCode == _selectedVariant.variantsCode;
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedVariant = variant;
                        _isCurrentlyInCart = variant.isInCart;
                      });
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSelected
                              ? AppColor.colorPrimary
                              : AppColor.middleOrangeButton.withOpacity(0.5),
                          width: isSelected ? 2 : 1,
                        ),
                        color: isSelected
                            ? AppColor.colorPrimary.withOpacity(0.05)
                            : null,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              "${variant.quantity} ${variant.sellingUnit}",
                              style: GoogleFonts.mavenPro(
                                fontSize: 14,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.w600,
                                color: AppColor.black,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              "₹ ${variant.sellingPrice}",
                              style: GoogleFonts.mavenPro(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColor.black,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              "₹ ${variant.regularPrice}",
                              textAlign: TextAlign.right,
                              style: GoogleFonts.mavenPro(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColor.grayShade,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        );
      },
    );
  }
}
