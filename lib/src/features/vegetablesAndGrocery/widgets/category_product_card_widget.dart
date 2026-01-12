import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myvegiz_flutter/src/core/themes/app_color.dart';

class CategoryProductCardWidget extends StatefulWidget {
  const CategoryProductCardWidget({super.key});

  @override
  State<CategoryProductCardWidget> createState() => _CategoryProductCardWidgetState();
}

class _CategoryProductCardWidgetState extends State<CategoryProductCardWidget> {
  @override
  Widget build(BuildContext context) {
    return  Container(
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
                          "Onion-Kanda-Pyaj",
                          style: GoogleFonts.mavenPro(
                            color: AppColor.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.only(top: 4.0),
                          child: Image.asset(
                            "assets/icons/filled_heart_icon.png",
                            color: AppColor.hintText,
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
                              "1 KG",
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
                              "₹40.00",
                              style: GoogleFonts.mavenPro(
                                  color: AppColor.grayShade,fontSize: 13, fontWeight: FontWeight.w600,decoration: TextDecoration.lineThrough
                              ),
                            ),

                            Row(
                              children: [
                                Text(
                                  "₹35.00",
                                  style: GoogleFonts.mavenPro(
                                      color: AppColor.black,fontSize: 16, fontWeight: FontWeight.w600
                                  ),
                                ),
                                Container(
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
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(
                                      "13% Off",
                                      style: GoogleFonts.mavenPro(
                                          color: AppColor.white,fontSize: 8, fontWeight: FontWeight.w600
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
                                "ADD",
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
    );
  }
}
