// lib/features/home/presentation/screens/home_screen.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lasco/core/component/widgets/app_button.dart';
import 'package:lasco/core/constants/widgets/print_util.dart';
import 'package:lasco/core/cubit/global_cubit.dart';
import 'package:lasco/core/locale/app_loacl.dart';

import '../../../../core/component/widgets/app_text_field.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/navigation.dart';
import '../../../../core/cubit/global_state.dart';
import '../../package/views/pick_up_screen.dart';
import '../data/model/recent_orders_model.dart';
import 'component/widgets/company_grid.dart';
import 'component/widgets/recent_order_card.dart';
import 'component/widgets/section_header.dart';
import 'component/widgets/welcome_header.dart';
import 'cubit/company_cubit.dart';
import 'cubit/company_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  List<RecentOrdersModel> _recentOrders() {
    return [
      RecentOrdersModel(
        id: "F124G375",
        currentStep: 2,
        totalSteps: 5,
        fromLocation: "Manhattan",
        toLocation: "Times Square",
        fromDate: "18 Jul, 2024",
        toDate: "18 Jul, 2024",
      ),
      RecentOrdersModel(
        id: "B978X421",
        currentStep: 3,
        totalSteps: 5,
        fromLocation: "Brooklyn",
        toLocation: "Queens",
        fromDate: "19 Jul, 2024",
        toDate: "19 Jul, 2024",
      ),
      RecentOrdersModel(
        id: "C543H210",
        currentStep: 1,
        totalSteps: 5,
        fromLocation: "Harlem",
        toLocation: "Bronx",
        fromDate: "20 Jul, 2024",
        toDate: "20 Jul, 2024",
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CompanyCubit()..getCompanies(),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: BlocBuilder<GlobalCubit, GlobalState>(
          builder: (context, state) {
            final globalCubit = context.read<GlobalCubit>();
            return SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 25.h),
                    WelcomeHeader(globalCubit: globalCubit),
                    SizedBox(height: 20.h),
                    _buildSearchBar(context),
                    SizedBox(height: 20.h),
                    Expanded(
                      child: BlocBuilder<CompanyCubit, CompanyState>(
                        builder: (context, companyState) {
                          return SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (companyState is CompanyLoading)
                                  _buildLoadingIndicator(),
                                if (companyState is CompanyError)
                                  _buildErrorWidget(
                                      companyState.message, context),
                                if (companyState is CompanyLoaded)
                                  CompanyGrid(
                                    title: "shipping_companies".tr(context),
                                    companies: companyState.companies,
                                    onLoadMore: () {
                                      context
                                          .read<CompanyCubit>()
                                          .loadMoreCompanies();
                                    },
                                    hasMore: companyState.hasMore,
                                  ),
                                SizedBox(height: 20.h),
                                //! Recent orders section
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SectionHeader(
                                      title: "recent_orders".tr(context),
                                      showViewAll: true,
                                      onViewAll: () {
                                        if (kDebugMode) {
                                          PrintUtil.debug(
                                              'View all recent orders pressed');
                                        }
                                      },
                                    ),
                                    SizedBox(height: 12.h),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: _recentOrders().length,
                                      itemBuilder: (context, index) {
                                        final order = _recentOrders()[index];
                                        return Padding(
                                          padding:
                                              EdgeInsets.only(bottom: 12.h),
                                          child: RecentOrderCard(
                                            orderId: order.id,
                                            currentStep: order.currentStep,
                                            totalSteps: order.totalSteps,
                                            fromLocation: order.fromLocation,
                                            toLocation: order.toLocation,
                                            fromDate: order.fromDate,
                                            toDate: order.toDate,
                                            onPickupPressed: () {
                                              navigateTo(
                                                context,
                                                PickupAddressScreen(),
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: CircularProgressIndicator(color: AppColors.orange),
      ),
    );
  }

  Widget _buildErrorWidget(String message, BuildContext context) {
    return Column(
      children: [
        // Text(
        //   message,
        //   style: TextStyle(color: Colors.red, fontSize: 14.sp),
        // ),
        // SizedBox(height: 10.h),
        AppButton(
          text: "retry".tr(context),
          backgroundColor: AppColors.orange,
          onPressed: () {
            context.read<CompanyCubit>().getCompanies();
          },
        ),
        SizedBox(height: 20.h),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: Color(0xffFEEBE4),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "track_your_package".tr(context),
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      "please_enter_id".tr(context),
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.grey,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                flex: 2,
                child: AppButton(
                  text: "add_new".tr(context),
                  backgroundColor: AppColors.orange,
                  height: 35.h,
                  onPressed: () {},
                ),
              ),
            ],
          ),
          AppTextField(
            controller: TextEditingController(),
            hintText: "example_id".tr(context),
            radius: BorderRadiusDirectional.circular(12.r),
            suffixIcon: Icon(
              CupertinoIcons.search,
              size: 25.sp,
              color: AppColors.orange,
            ),
          ),
        ],
      ),
    );
  }
}
