import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myvegiz_flutter/src/configs/injector/injector.dart';
import 'package:myvegiz_flutter/src/configs/injector/injector_conf.dart';
import 'package:myvegiz_flutter/src/core/extensions/integer_sizedbox_extension.dart';
import 'package:myvegiz_flutter/src/core/themes/app_color.dart';
import 'package:myvegiz_flutter/src/routes/app_route_path.dart';
import 'package:myvegiz_flutter/src/core/session/session_manager.dart';
import 'package:myvegiz_flutter/src/features/cart/bloc/cartlist_bloc/cartlist_bloc.dart';
import 'package:myvegiz_flutter/src/features/cart/presentation/widgets/cart_product_card_widget.dart';
import 'package:myvegiz_flutter/src/remote/models/cart_model/cart_list_response.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String? _clientCode;
  late CartListBloc _cartListBloc;

  @override
  void initState() {
    super.initState();
    _cartListBloc = getIt<CartListBloc>();
    _loadData();
  }

  void _loadData() async {
    _clientCode = await SessionManager.getClientCode();
    if (_clientCode != null && mounted) {
      _cartListBloc.add(CartListGetEvent(_clientCode!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _cartListBloc,),
      ],
      child: Scaffold(
        backgroundColor: AppColor.whiteShade,
        appBar: AppBar(
          backgroundColor: AppColor.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'cart'.tr(),
            style: GoogleFonts.mavenPro(
              color: AppColor.black,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: BlocConsumer<CartListBloc, CartListState>(
          listener: (context, state) {
            if (state is CartListFailureState) {
              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(content: Text(state.message)),
              // );
            }
          },
          builder: (context, state) {
            if (state is CartListLoadingState) {
              return const Center(
                child: CircularProgressIndicator(color: AppColor.colorPrimary),
              );
            } else if (state is CartListSuccessState) {
              final cartData = state.data;
              if (cartData.result.products.isEmpty) {
                return _buildEmptyCart();
              }
              return _buildCartContent(cartData);
            } else if (state is CartListFailureState) {
              return _buildEmptyCart();
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
        bottomNavigationBar: _buildBottomCheckout(context),
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Image.asset("assets/icons/empty_cart_icon.png")),
        12.hS,
        Text(
          'your_cart_is_empty'.tr(),
          style: GoogleFonts.mavenPro(
            color: AppColor.gray,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        4.hS,
        Text(
          'add_products_to_cart_now'.tr(),
          style: GoogleFonts.mavenPro(
            color: AppColor.black,
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
        ),
        16.hS,
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.colorPrimary,
          ),
          onPressed: () {
            context.pushReplacementNamed(AppRoute.homeContentScreen.name);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Text(
              'shop_now'.tr(),
              style: GoogleFonts.mavenPro(
                color: AppColor.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCartContent(CartListResponse cartData) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Product List
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cartData.result.products.length,
            itemBuilder: (context, index) {
              return CartProductCardWidget(
                product: cartData.result.products[index],
                clientCode: _clientCode ?? "",
              );
            },
          ),

          16.hS,

          // Apply Coupon Section
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColor.grayShade.withOpacity(0.2)),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.local_offer_outlined,
                  color: AppColor.colorPrimary,
                ),
                12.wS,
                Expanded(
                  child: Text(
                    'apply_coupon'.tr(),
                    style: GoogleFonts.mavenPro(
                      color: AppColor.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: AppColor.grayShade,
                ),
              ],
            ),
          ),

          16.hS,

          // Bill Details Section
          _buildBillDetails(cartData),

          24.hS,
        ],
      ),
    );
  }

  Widget _buildBillDetails(CartListResponse cartData) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'bill_details'.tr(),
            style: GoogleFonts.mavenPro(
              color: AppColor.black,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          12.hS,
          _buildBillRow('item_total'.tr(), '₹${cartData.itemTotal}'),
          _buildBillRow(
            'discount'.tr(),
            '-₹${cartData.discount}',
            color: Colors.green,
          ),
          _buildBillRow('delivery_fee'.tr(), '₹${cartData.deliveryCharge}'),
          _buildBillRow('gst_and_taxes'.tr(), '₹${cartData.gstAmount}'),
          if (double.tryParse(cartData.packagingCharges) != 0)
            _buildBillRow(
              'packaging_charges'.tr(),
              '₹${cartData.packagingCharges}',
            ),
          const Divider(height: 24),
          _buildBillRow(
            'to_pay'.tr(),
            '₹${cartData.finalOrderAmount}',
            isBold: true,
          ),
        ],
      ),
    );
  }

  Widget _buildBillRow(
    String label,
    String value, {
    Color? color,
    bool isBold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.mavenPro(
              color: color ?? AppColor.grayShade,
              fontSize: 14,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.mavenPro(
              color: color ?? AppColor.black,
              fontSize: 14,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget? _buildBottomCheckout(BuildContext context) {
    return BlocBuilder<CartListBloc, CartListState>(
      builder: (context, state) {
        if (state is CartListSuccessState &&
            state.data.result.products.isNotEmpty) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColor.white,
              boxShadow: [
                BoxShadow(
                  color: AppColor.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'total'.tr(),
                        style: GoogleFonts.mavenPro(
                          color: AppColor.grayShade,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '₹${state.data.finalOrderAmount}',
                        style: GoogleFonts.mavenPro(
                          color: AppColor.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  20.wS,
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to checkout
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.colorPrimary,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'checkout'.tr(),
                        style: GoogleFonts.mavenPro(
                          color: AppColor.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
