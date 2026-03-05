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
import 'package:myvegiz_flutter/src/features/cart/bloc/delete_cart_item_bloc/delete_cart_item_bloc.dart';
import 'package:myvegiz_flutter/src/features/cart/domain/delete_cart_item_usecase.dart';
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
        BlocProvider.value(value: _cartListBloc),
        BlocProvider(create: (context) => getIt<DeleteCartItemBloc>()),
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
          actions: [
            BlocBuilder<CartListBloc, CartListState>(
              builder: (context, state) {
                if (state is CartListSuccessState &&
                    state.data.result.products.isNotEmpty) {
                  return BlocBuilder<DeleteCartItemBloc, DeleteCartItemState>(
                    builder: (context, deleteState) {
                      return TextButton(
                        onPressed: deleteState is DeleteCartItemLoading
                            ? null
                            : () {
                                _showEmptyCartDialog(context);
                              },
                        child: deleteState is DeleteCartItemLoading
                            ? const SizedBox(
                                height: 16,
                                width: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColor.colorPrimary,
                                ),
                              )
                            : Text(
                                'empty_cart'.tr(),
                                style: GoogleFonts.mavenPro(
                                  color: AppColor.startOrangeButton,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<CartListBloc, CartListState>(
              listener: (context, state) {
                if (state is CartListFailureState) {
                  // Handle failure if needed
                }
              },
            ),
            BlocListener<DeleteCartItemBloc, DeleteCartItemState>(
              listener: (context, state) {
                if (state is DeleteCartItemSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.response.message!)),
                  );
                  _loadData(); // Refresh cart list
                } else if (state is DeleteCartItemFailure) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
            ),
          ],
          child: BlocBuilder<CartListBloc, CartListState>(
            builder: (context, state) {
              if (state is CartListLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColor.colorPrimary,
                  ),
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
        crossAxisAlignment: CrossAxisAlignment.start,
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
              border: Border.all(color: AppColor.grayShade.withOpacity(0.1)),
            ),
            child: Row(
              children: [
                const Icon(Icons.percent, color: AppColor.black, size: 20),
                12.wS,
                Expanded(
                  child: Text(
                    'apply_coupon'.tr(),
                    style: GoogleFonts.mavenPro(
                      color: AppColor.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: AppColor.black,
                ),
              ],
            ),
          ),

          24.hS,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'bill_details'.tr().toUpperCase(),
              style: GoogleFonts.mavenPro(
                color: AppColor.grayShade,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          8.hS,

          // Bill Details Section
          _buildBillDetails(cartData),

          16.hS,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'note'.tr().toUpperCase() + ":",
              style: GoogleFonts.mavenPro(
                color: AppColor.startOrangeButton,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          8.hS,
          // Note Section
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColor.grayShade.withOpacity(0.1)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBulletPoint(
                  "Once you place an order, it cannot be cancelled.",
                ),
                _buildBulletPoint(
                  "If you receive spoiled vegetables after placing an order, they will be replaced.",
                ),
                _buildBulletPoint(
                  "If any product is missing from your order, the payment for that item will be refunded.",
                ),
              ],
            ),
          ),

          24.hS,
          // Delivery Address Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: AppColor.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: AppColor.startOrangeButton,
                      size: 20,
                    ),
                    8.wS,
                    Expanded(
                      child: Text(
                        "Deliver to HOME",
                        style: GoogleFonts.mavenPro(
                          color: AppColor.grayShade,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        side: BorderSide(
                          color: AppColor.grayShade.withOpacity(0.2),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: Text(
                        "CHANGE",
                        style: GoogleFonts.mavenPro(
                          color: AppColor.startOrangeButton,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 28.0),
                  child: Text(
                    "1,Menon Banglo,Kolhapur,India",
                    style: GoogleFonts.mavenPro(
                      color: AppColor.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

          32.hS,
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6.0),
            child: Icon(Icons.circle, size: 6, color: AppColor.black),
          ),
          8.wS,
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.mavenPro(
                color: AppColor.black,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
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
        border: Border.all(color: AppColor.grayShade.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBillRow('item_total'.tr(), '₹ ${cartData.itemTotal}'),
          _buildBillRow('discount'.tr(), '₹ ${cartData.discount}'),
          _buildBillRow('sub_total'.tr(), '₹ ${cartData.itemTotal}'),
          _buildBillRow('tax'.tr(), '₹ ${cartData.gstAmount}'),
          _buildBillRow(
            'packaging_charges'.tr(),
            '₹ ${cartData.packagingCharges == "" ? "0" : cartData.packagingCharges}',
          ),
          _buildBillRow(
            'delivery_charges'.tr() + ' (0 Kms)',
            '₹ ${cartData.deliveryCharge}',
          ),
          const Divider(height: 24),
          _buildBillRow(
            'total_payable'.tr(),
            '₹ ${cartData.finalOrderAmount}',
            isBold: true,
          ),
        ],
      ),
    );
  }

  Widget _buildBillRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.mavenPro(
              color: isBold ? AppColor.black : AppColor.grayShade,
              fontSize: 14,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.mavenPro(
              color: AppColor.black,
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: AppColor.white,
              border: Border(
                top: BorderSide(color: AppColor.grayShade.withOpacity(0.1)),
              ),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${state.data.result.products.length} Items',
                        style: GoogleFonts.mavenPro(
                          color: AppColor.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '₹ ${state.data.finalOrderAmount}',
                        style: GoogleFonts.mavenPro(
                          color: AppColor.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 180,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to checkout
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF386633),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'proceed_to_pay'.tr(),
                        style: GoogleFonts.mavenPro(
                          color: AppColor.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
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

  void _showEmptyCartDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(
          'empty_cart'.tr(),
          style: GoogleFonts.mavenPro(fontWeight: FontWeight.bold),
        ),
        content: Text(
          'are_you_sure_you_want_to_empty_cart'.tr(),
          style: GoogleFonts.mavenPro(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              'cancel'.tr(),
              style: GoogleFonts.mavenPro(color: AppColor.gray),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              if (_clientCode != null) {
                context.read<DeleteCartItemBloc>().add(
                  DeleteCartItemSubmitEvent(
                    DeleteCartItemParams(clientCode: _clientCode!),
                  ),
                );
              }
            },
            child: Text(
              'empty_cart'.tr(),
              style: GoogleFonts.mavenPro(color: AppColor.startOrangeButton),
            ),
          ),
        ],
      ),
    );
  }
}
