import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lasco/core/locale/app_loacl.dart';

import '../../../core/component/custom_toast.dart';
import '../../../core/component/widgets/app_button.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/navigation.dart';
import '../../../core/services/service_locator.dart';
import '../../company/views/company_details_screen.dart';
import '../../home/view/component/widgets/company_card.dart';
import '../data/repo/favorites_repo.dart';
import 'cubit/favorites_cubit.dart';
import 'cubit/favorites_state.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoritesCubit(sl<FavoritesRepo>())..getFavorites(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: AppColors.textBlack),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'favourite'.tr(context),
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textBlack,
            ),
          ),
        ),
        body: BlocConsumer<FavoritesCubit, FavoritesState>(
          listener: (context, state) {
            if (state is FavoritesError) {
              showToast(
                context,
                message: state.error,
                state: ToastStates.error,
                duration: const Duration(seconds: 3),
              );
            } else if (state is FavoritesSuccess) {
              showToast(
                context,
                message: state.message,
                state: ToastStates.success,
                duration: const Duration(seconds: 3),
              );
            }
          },
          builder: (context, state) {
            if (state is FavoritesLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is FavoritesError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 80.sp,
                      color: AppColors.textGrey,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      state.error,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.textGrey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.h),
                    AppButton(
                      onPressed: () =>
                          context.read<FavoritesCubit>().getFavorites(),
                      text: 'retry'.tr(context),
                    ),
                  ],
                ),
              );
            }
            if (state is FavoritesLoaded) {
              final favorites = state.favorites;
              if (favorites.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.favorite_border,
                        size: 80.sp,
                        color: AppColors.textGrey,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'no_favorites_found'.tr(context),
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: AppColors.textGrey,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 12.w,
                    mainAxisSpacing: 12.h,
                    mainAxisExtent: 230.h,
                  ),
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    final favorite = favorites[index];
                    final company = favorite.company;
                    return CompanyCard(
                      companyName: company?.name ?? '',
                      description: company?.description ?? '',
                      imageUrl: company?.logo,
                      isFav: true,
                      onViewPressed: () {
                        navigateTo(
                          context,
                          CompanyDetailsScreen(id: company?.id ?? 0),
                        );
                      },
                      onFavPressed: () {
                        context
                            .read<FavoritesCubit>()
                            .toggleFavorite(favorite.id ?? 0);
                      },
                    );
                  },
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
