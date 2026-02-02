import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myvegiz_flutter/src/core/extensions/integer_sizedbox_extension.dart';
import 'package:myvegiz_flutter/src/core/themes/app_color.dart';

import '../../../remote/models/category_by_product_model/category_by_product_response.dart';

class CategoryProductCardWidget extends StatefulWidget {
  final Product product;

  const CategoryProductCardWidget({super.key, required this.product});

  @override
  State<CategoryProductCardWidget> createState() => _CategoryProductCardWidgetState();
}

class _CategoryProductCardWidgetState extends State<CategoryProductCardWidget> {

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
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
                  image: widget.product.images.isNotEmpty ?
                  DecorationImage(
                    image: NetworkImage(
                        widget.product.images.first),
                    fit: BoxFit.cover,
                  ) : null,
                ),
              ),

              // Right side content
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.product.productName,
                            style: GoogleFonts.mavenPro(
                              color: AppColor.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: (){
                              // setState(() {
                              //   widget.product.isInWishlist == true
                              //       ? widget.product.isInWishlist = false
                              //       : widget.product.isInWishlist = true;
                              // });
                            },
                            child: Padding(
                              padding: EdgeInsets.only(top: 4.0),
                              child: Image.asset(
                                "assets/icons/filled_heart_icon.png",
                                color: widget.product.isInWishlist ?
                                AppColor.brightRed :
                                AppColor.hintText,
                                height: 20,
                              ),
                            ),
                          ),
                        ],
                      ),

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
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${widget.product.quantity} ${widget.product.sellingUnit}",
                                style: GoogleFonts.mavenPro(
                                  color: AppColor.gray,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: AppColor.black,
                                size: 22,
                              ),
                            ],
                          ),
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "₹${widget.product.regularPrice}",
                                style: GoogleFonts.mavenPro(
                                    color: AppColor.grayShade,fontSize: 13, fontWeight: FontWeight.w600,decoration: TextDecoration.lineThrough
                                ),
                              ),

                              Row(
                                children: [
                                  Text(
                                    "₹${widget.product.sellingPrice}",
                                    style: GoogleFonts.mavenPro(
                                        color: AppColor.black,fontSize: 16, fontWeight: FontWeight.w600
                                    ),
                                  ),
                                  4.wS,
                                  if (widget.product.rateVariants.isNotEmpty)
                                  Container(
                                    width: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
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
                                          widget.product.rateVariants.first.productDiscount,
                                          style: GoogleFonts.mavenPro(
                                              color: AppColor.white,fontSize: 9, fontWeight: FontWeight.w600
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
                                padding: EdgeInsets.symmetric(vertical: 6.0,horizontal: 8),
                                child: Text(
                                  widget.product.isInCart ? "ICART" : "ADD",
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
    );
  }
}
