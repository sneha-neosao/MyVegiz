import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myvegiz_flutter/src/routes/app_route_path.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myvegiz_flutter/src/configs/injector/injector_conf.dart';
import 'package:myvegiz_flutter/src/core/themes/app_color.dart';
import 'package:myvegiz_flutter/src/features/cart/bloc/add_to_cart_bloc/add_to_cart_bloc.dart';
import 'package:myvegiz_flutter/src/features/cart/bloc/update_cart_bloc/update_cart_bloc.dart';
import 'package:myvegiz_flutter/src/features/cart/domain/add_to_cart_usecase.dart';
import 'package:myvegiz_flutter/src/features/cart/domain/update_cart_usecase.dart';
import 'package:myvegiz_flutter/src/features/common/bloc/get_product_details_bloc/get_product_details_bloc.dart';
import 'package:myvegiz_flutter/src/features/widgets/app_loading_widget.dart';
import 'package:myvegiz_flutter/src/remote/models/category_by_product_model/category_by_product_response.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String productCode;
  final String mainCategoryCode;
  final String cityCode;
  final String clientCode;

  const ProductDetailsScreen({
    super.key,
    required this.productCode,
    required this.mainCategoryCode,
    required this.cityCode,
    required this.clientCode,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late GetProductDetailsBloc _getProductDetailsBloc;
  RateVariant? _selectedVariant;
  bool _isCurrentlyInCart = false;
  int _cartQuantity = 0;

  @override
  void initState() {
    super.initState();
    _getProductDetailsBloc = getIt<GetProductDetailsBloc>();
    _getProductDetailsBloc.add(
      FetchProductDetailsEvent(
        productCode: widget.productCode,
        mainCategoryCode: widget.mainCategoryCode,
        cityCode: widget.cityCode,
        clientCode: widget.clientCode,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _getProductDetailsBloc),
        BlocProvider(create: (context) => getIt<AddToCartBloc>()),
        BlocProvider(create: (context) => getIt<UpdateCartBloc>()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AddToCartBloc, AddToCartState>(
            listener: (context, state) {
              if (state is AddToCartSuccess) {
                if (mounted && _selectedVariant != null) {
                  setState(() {
                    if (state.response.cartCode != null) {
                      _selectedVariant!.cartCode = state.response.cartCode!;
                      _selectedVariant!.isInCart = true;
                      _selectedVariant!.cartQuantity = _cartQuantity;
                    }
                  });
                }
              } else if (state is AddToCartFailure) {
                if (mounted) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                }
              }
            },
          ),
          BlocListener<UpdateCartBloc, UpdateCartState>(
            listener: (context, state) {
              if (state is UpdateCartSuccess) {
                if (mounted && _selectedVariant != null) {
                  setState(() {
                    _selectedVariant!.cartQuantity = _cartQuantity;
                    if (state.response.status == "deletetrue" ||
                        _cartQuantity == 0) {
                      _selectedVariant!.isInCart = false;
                      _selectedVariant!.cartQuantity = 0;
                      _isCurrentlyInCart = false;
                    }
                  });
                }
              } else if (state is UpdateCartFailure) {
                if (mounted) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                }
              }
            },
          ),
        ],
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: _buildAppBar(context),
          body: BlocBuilder<GetProductDetailsBloc, GetProductDetailsState>(
            builder: (context, state) {
              if (state is GetProductDetailsLoading) {
                return const Center(child: AppLoadingWidget(strokeWidth: 4));
              } else if (state is GetProductDetailsError) {
                return Center(child: Text(state.message));
              } else if (state is GetProductDetailsLoaded) {
                final product = state.response.result.product;
                if (product == null) {
                  return const Center(child: Text('Product not found'));
                }

                if (_selectedVariant == null &&
                    product.rateVariants.isNotEmpty) {
                  _selectedVariant = product.rateVariants.firstWhere(
                    (v) => v.isMainVariant == "1",
                    orElse: () => product.rateVariants.first,
                  );
                  _isCurrentlyInCart = _selectedVariant!.isInCart;
                  _cartQuantity = _selectedVariant!.cartQuantity;
                }

                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image Section
                      _buildImageSection(product),
                      const SizedBox(height: 16),
                      // Title
                      Text(
                        product.productName
                            .replaceAll(RegExp(r'\s+'), ' ')
                            .trim(),
                        style: GoogleFonts.mavenPro(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColor.black,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Variants List
                      if (product.rateVariants.isNotEmpty)
                        _buildVariantsList(product),

                      const SizedBox(height: 16),
                      // Price & Add To Cart Button
                      if (_selectedVariant != null)
                        _buildPriceAndAddButton(product),

                      const SizedBox(height: 24),
                      // About Product Section
                      if (product.productDescription.isNotEmpty)
                        _buildAboutProductSection(product),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          bottomNavigationBar: SafeArea(
            child: Container(
              color: AppColor.white,
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "4 Items",
                        style: GoogleFonts.mavenPro(
                          color: AppColor.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "0",
                        style: GoogleFonts.mavenPro(
                          color: AppColor.black,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      context.pushNamed(AppRoute.cartScreen.name);
                    },
                    child: Container(
                      height: 46,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            AppColor.startGreenButton,
                            AppColor.middleGreenButton,
                            AppColor.endGreenButton,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 6.0,
                            horizontal: 30,
                          ),
                          child: Text(
                            "View Cart",
                            style: GoogleFonts.mavenPro(
                              color: AppColor.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.chevron_left,
              color: AppColor.black,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection(Product product) {
    return Container(
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
        color: const Color(0xffFFF2F2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: product.images.isNotEmpty
            ? Image.network(
                product.images.first,
                height: 200,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.image, size: 80, color: Colors.grey);
                },
              )
            : const Icon(Icons.image, size: 80, color: Colors.grey),
      ),
    );
  }

  Widget _buildVariantsList(Product product) {
    return Column(
      children: product.rateVariants.map((variant) {
        final isSelected =
            _selectedVariant?.variantsCode == variant.variantsCode;

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedVariant = variant;
              _isCurrentlyInCart = variant.isInCart;
              _cartQuantity = variant.cartQuantity;
            });
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 8),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: isSelected
                    ? AppColor.orange
                    : AppColor.orange.withOpacity(0.5),
                width: isSelected ? 1.5 : 1.0,
              ),
            ),
            child: Text(
              "${variant.quantity} ${variant.sellingUnit}",
              style: GoogleFonts.mavenPro(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? AppColor.black : AppColor.grayShade,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPriceAndAddButton(Product product) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_selectedVariant!.productDiscount.isNotEmpty &&
                _selectedVariant!.productDiscount != "0% Off")
              Container(
                margin: const EdgeInsets.only(bottom: 4),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      AppColor.startOrangeButton,
                      AppColor.middleOrangeButton,
                      AppColor.endOrangeButton,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  _selectedVariant!.productDiscount,
                  style: GoogleFonts.mavenPro(
                    color: AppColor.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            Row(
              children: [
                if (_selectedVariant!.regularPrice.isNotEmpty &&
                    _selectedVariant!.regularPrice !=
                        _selectedVariant!.sellingPrice)
                  Padding(
                    padding: const EdgeInsets.only(right: 6.0),
                    child: Text(
                      "₹ ${_selectedVariant!.regularPrice}",
                      style: GoogleFonts.mavenPro(
                        color: AppColor.grayShade,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ),
                Text(
                  "₹ ${_selectedVariant!.sellingPrice}",
                  style: GoogleFonts.mavenPro(
                    color: AppColor.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        _buildAddToCartButton(product),
      ],
    );
  }

  Widget _buildAddToCartButton(Product product) {
    return BlocBuilder<UpdateCartBloc, UpdateCartState>(
      builder: (context, updateState) {
        return BlocBuilder<AddToCartBloc, AddToCartState>(
          builder: (context, addState) {
            final isLoading =
                addState is AddToCartLoading ||
                updateState is UpdateCartLoading;

            if (!_isCurrentlyInCart) {
              return InkWell(
                onTap: isLoading
                    ? null
                    : () {
                        setState(() {
                          _isCurrentlyInCart = true;
                          _cartQuantity = 1;
                        });
                        context.read<AddToCartBloc>().add(
                          AddProductToCartEvent(
                            AddToCartParams(
                              clientCode: widget.clientCode,
                              price: _selectedVariant!.sellingPrice,
                              productCode: product.code,
                              productName: product.productName,
                              quantity: "1",
                              sellingQuantity: _selectedVariant!.quantity,
                              unit: _selectedVariant!.sellingUnit,
                              unitId: _selectedVariant!.variantsCode,
                            ),
                          ),
                        );
                      },
                child: Container(
                  width: 90,
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: AppColor.orange),
                    color: AppColor.white,
                  ),
                  child: Center(
                    child: isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: AppLoadingWidget(strokeWidth: 3),
                          )
                        : Text(
                            "ADD",
                            style: GoogleFonts.mavenPro(
                              color: AppColor.orange,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              );
            }

            // Counter Selector for Cart Quantity
            return Container(
              width: 90,
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                gradient: const LinearGradient(
                  colors: [
                    AppColor.startOrangeButton,
                    AppColor.middleOrangeButton,
                    AppColor.endOrangeButton,
                  ],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    child: const Icon(
                      Icons.remove,
                      color: AppColor.white,
                      size: 16,
                    ),
                    onTap: () {
                      if (_cartQuantity > 1) {
                        setState(() {
                          _cartQuantity--;
                        });
                      } else {
                        setState(() {
                          _isCurrentlyInCart = false;
                          _cartQuantity = 0;
                        });
                      }
                      context.read<UpdateCartBloc>().add(
                        UpdateCartQunatyEvent(
                          UpdateCartParams(
                            cartCode: _selectedVariant!.cartCode,
                            quantity: _cartQuantity.toString(),
                            clientCode: widget.clientCode,
                            productCode: product.code,
                            variantsCode: _selectedVariant!.variantsCode,
                            cityCode: product.cityCode,
                            unit: _selectedVariant!.sellingUnit,
                            unitId: _selectedVariant!.variantsCode,
                            sellingQuantity: _selectedVariant!.quantity,
                            productName: product.productName,
                            price: _selectedVariant!.sellingPrice,
                            count: "",
                          ),
                        ),
                      );
                    },
                  ),
                  isLoading
                      ? const SizedBox(
                          height: 16,
                          width: 16,
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
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                  GestureDetector(
                    child: const Icon(
                      Icons.add,
                      color: AppColor.white,
                      size: 16,
                    ),
                    onTap: () {
                      setState(() {
                        _cartQuantity++;
                      });
                      context.read<UpdateCartBloc>().add(
                        UpdateCartQunatyEvent(
                          UpdateCartParams(
                            cartCode: _selectedVariant!.cartCode,
                            quantity: _cartQuantity.toString(),
                            clientCode: widget.clientCode,
                            productCode: product.code,
                            variantsCode: _selectedVariant!.variantsCode,
                            cityCode: product.cityCode,
                            unit: _selectedVariant!.sellingUnit,
                            unitId: _selectedVariant!.variantsCode,
                            sellingQuantity: _selectedVariant!.quantity,
                            productName: product.productName,
                            price: _selectedVariant!.sellingPrice,
                            count: "",
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildAboutProductSection(Product product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "About Product",
          style: GoogleFonts.mavenPro(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColor.black,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(6),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product.productDescription.isNotEmpty
                  ? product.productDescription
                  : "WebView",
              style: GoogleFonts.mavenPro(fontSize: 14, color: AppColor.black),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
