import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lasco/core/component/custom_loading_indicator.dart';
import 'package:lasco/core/constants/app_colors.dart';
import 'package:lasco/core/locale/app_loacl.dart';

import '../../../../../core/component/widgets/app_button.dart';

class CompanyCard extends StatelessWidget {
  final String companyName;
  final String description;
  final String? imageUrl;
  final VoidCallback? onFavPressed;
  final bool isFav;
  final bool isLoading;
  final String? rate;
  final VoidCallback? onViewPressed;

  const CompanyCard({
    super.key,
    required this.companyName,
    required this.description,
    this.onFavPressed,
    this.isFav = false,
    this.rate,
    this.imageUrl,
    this.isLoading = false,
    this.onViewPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onViewPressed,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        decoration: BoxDecoration(
          color: Color(0xffF7F7F7),
          borderRadius: BorderRadiusDirectional.only(
            topEnd: Radius.circular(12.61.r),
            topStart: Radius.circular(12.61.r),
            bottomStart: Radius.circular(12.61.r),
            bottomEnd: Radius.circular(36.r),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Company Image
            _buildImageSection(context),

            // Company Details
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              // margin: EdgeInsets.only(top: 5.h),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(12.61.r),
                  topStart: Radius.circular(12.61.r),
                  bottomStart: Radius.circular(12.61.r),
                  bottomEnd: Radius.circular(36.r),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Company Name
                  Text(
                    companyName,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  // SizedBox(height: 4.h),

                  // // Description
                  // Text(
                  //   description,
                  //   style: TextStyle(
                  //     fontSize: 12.sp,
                  //     fontWeight: FontWeight.w400,
                  //     color: AppColors.grey,
                  //   ),
                  //   maxLines: 2,
                  //   overflow: TextOverflow.ellipsis,
                  // ),

                  SizedBox(height: 12.h),

                  // View Button
                  Row(
                    children: [
                      // Wishlist button
                      Container(
                        width: 30.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          color: Color(0xffFDEAE3),
                          borderRadius: BorderRadius.circular(10.r),
                          // shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 4,
                              offset:
                                  Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: isLoading
                              ? CustomLoadingIndicator()
                              : SvgPicture.asset(
                                  isFav
                                      ? "assets/images/svg/heart-fill.svg"
                                      : "assets/images/svg/heart.svg",
                                  color: AppColors.orange,
                                  width: 20.w,
                                ),
                          onPressed: onFavPressed ?? () {},
                        ),
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      Expanded(
                        child: AppButton(
                          onPressed: onViewPressed,
                          text: 'view'.tr(context),
                          backgroundColor: AppColors.orange,
                          height: 30.h,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection(BuildContext context) {
    return Container(
      height: 120.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.r),
          topRight: Radius.circular(12.r),
        ),
      ),
      child: Stack(
        children: [
          // Company Image
          Center(
            child: imageUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.r),
                      topRight: Radius.circular(12.r),
                    ),
                    child: Image.network(
                      imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildPlaceholderImage();
                      },
                    ),
                  )
                : _buildPlaceholderImage(),
          ),
          // RATE SECTION

          PositionedDirectional(
              end: 5,
              top: 5,
              child: Container(
                // height: 18.h,
                // width: 40.w,
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: AppColors.secoundry,
                  borderRadius: BorderRadius.circular(100.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 4,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star,
                      color: Color(0xffFFD867),
                      size: 12.w,
                    ),
                    Text(
                      rate ?? '4.5',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      height: 80.h,
      width: 60.w,
      decoration: BoxDecoration(
        color: Colors.orange[100],
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Icon(
        Icons.business,
        color: Colors.orange[400],
        size: 30.w,
      ),
    );
  }
}
