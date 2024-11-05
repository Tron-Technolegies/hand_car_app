import 'package:flutter/material.dart';
import 'package:hand_car/core/extension/theme_extension.dart';

class CouponContainer extends StatelessWidget {
  final String couponName;
  final String couponName2;
  final String couponDescription;
  final String couponCode;
  final String couponImage;
  final LinearGradient gradient;

  const CouponContainer(
      {super.key,
      required this.couponName,
      required this.couponDescription,
      required this.couponCode,
      required this.couponImage,
      required this.gradient,
      required this.couponName2});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      width: 380,
      height: 200,
      padding: EdgeInsets.all(context.space.space_200),
      decoration: BoxDecoration(
        gradient: gradient, // Blue background color
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                color: const Color(
                    0xffFFE500), // Yellow background for "Exclusive"
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                "Exclusive",
                style: context.typography.body
                    .copyWith(color: context.colors.primaryTxt),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(top: context.space.space_400),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(couponName,
                      style: context.typography.h2.copyWith(
                        color: context.colors.white,
                      )),
                  Text(couponName2,
                      style: context.typography.h2.copyWith(
                        color: context.colors.white,
                      )),
                  Text(couponDescription,
                      style: context.typography.bodySemiBold
                          .copyWith(color: context.colors.white)),
                  Padding(
                    padding: EdgeInsets.only(top: context.space.space_200),
                    child: Container(
                      decoration: BoxDecoration(
                        color: context.colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: context.space.space_100),
                        child: Text(
                          "Use Code: $couponCode",
                          style: context.typography.bodySemiBold
                              .copyWith(color: context.colors.primaryTxt),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Image.asset(
              couponImage,
              width: 140,
              height: 140,
            ),
          ),
        ],
      ),
    ));
  }
}
