import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myvegiz_flutter/src/configs/injector/injector_conf.dart';
import 'package:myvegiz_flutter/src/core/extensions/integer_sizedbox_extension.dart';
import 'package:myvegiz_flutter/src/core/themes/app_color.dart';
import 'package:myvegiz_flutter/src/features/cart/bloc/add_to_cart_bloc/add_to_cart_bloc.dart';
import 'package:myvegiz_flutter/src/features/cart/domain/add_to_cart_usecase.dart';
import 'package:myvegiz_flutter/src/features/cart/bloc/cartlist_bloc/cartlist_bloc.dart';
import '../../../../remote/models/cart_model/cart_list_response.dart';

class CartProductCardWidget extends StatefulWidget {
  final Product product;
  final String clientCode;

  const CartProductCardWidget({
    super.key,
    required this.product,
    required this.clientCode,
  });

  @override
  State<CartProductCardWidget> createState() => _CartProductCardWidgetState();
}

class _CartProductCardWidgetState extends State<CartProductCardWidget> {
  late int _cartQuantity;
  late RateVariant _selectedVariant;

  @override
  void initState() {
    super.initState();
    _cartQuantity = int.tryParse(widget.product.cartQuantity.toString()) ?? 0;

    // Initialize selected variant based on what's in the cart
    // Since this is the cart list, the product in the cart IS a variant.
    // We try to find it in the rateVariants list if available, or create a dummy one.
    if (widget.product.rateVariants.isNotEmpty) {
      _selectedVariant = widget.product.rateVariants.firstWhere(
        (v) => v.variantsCode == widget.product.productUom,
        orElse: () => widget.product.rateVariants.first,
      );
    } else {
      // Fallback if rateVariants is empty (though it shouldn't be now)
      _selectedVariant = RateVariant(
        variantsCode: widget.product.productUom,
        cityCode: "",
        sellingUnit: widget.product.sellingUnit,
        quantity: widget.product.quantity,
        productStatus: widget.product.productStatus,
        sellingPrice: widget.product.sellingPrice,
        regularPrice: widget.product.regularPrice,
        productDiscount: "0",
        isMainVariant: "0",
        isInCart: true,
        cartQuantity: _cartQuantity,
        cartCode: "",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddToCartBloc>(),
      child: BlocListener<AddToCartBloc, AddToCartState>(
        listener: (context, state) {
          if (state is AddToCartSuccess) {
            // Refresh cart list after successfully updating quantity
            context.read<CartListBloc>().add(
              CartListGetEvent(widget.clientCode),
            );
          } else if (state is AddToCartFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColor.grayShade.withOpacity(0.1)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start, // Align to top
              children: [
                // Product Image
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: widget.product.images.isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(widget.product.images.first),
                            fit: BoxFit.contain,
                          )
                        : null,
                  ),
                ),
                12.wS,
                // Product details and Quantity selector
                Expanded(
                  child: SizedBox(
                    height: 85, // Fixed height to align selector at bottom
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name and Price
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                widget.product.productName.trim(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.mavenPro(
                                  color: AppColor.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            8.wS,
                            Text(
                              "₹ ${_selectedVariant.sellingPrice}",
                              style: GoogleFonts.mavenPro(
                                color: AppColor.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),

                        // Quantity units (Clickable for variant selection) and Selector
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                if (widget.product.rateVariants.isNotEmpty) {
                                  _showVariantDialog(context, widget.product);
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColor.grayShade.withOpacity(0.2),
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "${_selectedVariant.quantity} ${_selectedVariant.sellingUnit}",
                                      style: GoogleFonts.mavenPro(
                                        color: AppColor.grayShade,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    if (widget
                                        .product
                                        .rateVariants
                                        .isNotEmpty) ...[
                                      2.wS,
                                      const Icon(
                                        Icons.keyboard_arrow_down,
                                        size: 16,
                                        color: AppColor.grayShade,
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                            // Quantity Selector
                            _buildQuantitySelector(context),
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
                  product.productName.trim(),
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
                      });
                      _updateQuantity(context, 1, variant: variant);
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
                              : AppColor.middleOrangeButton.withOpacity(0.2),
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

  Widget _buildQuantitySelector(BuildContext context) {
    return BlocBuilder<AddToCartBloc, AddToCartState>(
      builder: (context, state) {
        final isLoading = state is AddToCartLoading;
        return Container(
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: AppColor.middleOrangeButton,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: isLoading
                    ? null
                    : () {
                        if (_cartQuantity > 1) {
                          _updateQuantity(context, _cartQuantity - 1);
                        } else {
                          _updateQuantity(context, 0);
                        }
                      },
                child: const SizedBox(
                  width: 30,
                  child: Center(
                    child: Icon(Icons.remove, color: AppColor.white, size: 16),
                  ),
                ),
              ),
              isLoading
                  ? const SizedBox(
                      height: 12,
                      width: 12,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColor.white,
                      ),
                    )
                  : Text(
                      "$_cartQuantity",
                      style: GoogleFonts.mavenPro(
                        color: AppColor.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
              InkWell(
                onTap: isLoading
                    ? null
                    : () {
                        _updateQuantity(context, _cartQuantity + 1);
                      },
                child: const SizedBox(
                  width: 30,
                  child: Center(
                    child: Icon(Icons.add, color: AppColor.white, size: 16),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _updateQuantity(
    BuildContext context,
    int newQty, {
    RateVariant? variant,
  }) {
    final targetVariant = variant ?? _selectedVariant;

    // Optimistic update
    setState(() {
      _cartQuantity = newQty;
      if (variant != null) {
        _selectedVariant = variant;
      }
    });

    context.read<AddToCartBloc>().add(
      AddProductToCartEvent(
        AddToCartParams(
          clientCode: widget.clientCode,
          price: targetVariant.sellingPrice,
          productCode: widget.product.id,
          productName: widget.product.productName,
          quantity: newQty.toString(),
          sellingQuantity: targetVariant.quantity,
          unit: targetVariant.sellingUnit,
          unitId: targetVariant.variantsCode,
        ),
      ),
    );
  }
}
