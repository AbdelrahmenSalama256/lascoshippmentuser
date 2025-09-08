import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lasco/core/component/custom_toast.dart';
import 'package:lasco/core/constants/navigation.dart';
import 'package:lasco/core/locale/app_loacl.dart';
import 'package:lasco/features/company/views/shopping_companies_screen.dart';
import 'package:lasco/features/favourite/views/cubit/favorites_cubit.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/services/service_locator.dart';
import '../../../../company/views/company_details_screen.dart';
import '../../../../favourite/data/repo/favorites_repo.dart';
import '../../../../favourite/views/cubit/favorites_state.dart';
import '../../../data/model/company_model.dart';
import 'company_card.dart';
import 'section_header.dart';

class CompanyGrid extends StatelessWidget {
  final String? title;
  final List<CompanyModel> companies;
  final bool hasMore;
  final VoidCallback? onLoadMore;
  final int crossAxisCount;
  final double childAspectRatio;

  const CompanyGrid({
    super.key,
    this.title,
    required this.companies,
    this.hasMore = false,
    this.onLoadMore,
    this.crossAxisCount = 2,
    this.childAspectRatio = 0.75,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoritesCubit(sl<FavoritesRepo>()),
      child: BlocListener<FavoritesCubit, FavoritesState>(
        listener: (context, state) {
          if (state is FavoritesError) {
            showToast(context, message: state.error, state: ToastStates.error);
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              title: title ?? "Featured Companies",
              showViewAll: true,
              onViewAll: () {
                navigateTo(context, ShoppingCompaniesScreen());
              },
            ),

            SizedBox(height: 12.h),

            // Companies Grid
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: childAspectRatio,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 12.h,
                mainAxisExtent: 230.h,
              ),
              itemCount: companies.length,
              itemBuilder: (context, index) {
                final company = companies[index];
                return BlocBuilder<FavoritesCubit, FavoritesState>(
                  builder: (context, state) {
                    return CompanyCard(
                      isLoading: state is ToggleFavoritesLoading,
                      companyName: company.name ?? "",
                      description: company.description ?? "",
                      imageUrl: company.logo,
                      isFav: company.isFavourite ?? false,
                      rate: company.averageRating.toString(),
                      onFavPressed: () {
                        // استدعاء الكيوبت لإضافة/إزالة من المفضلة
                        context
                            .read<FavoritesCubit>()
                            .toggleFavorite(company.id ?? 0);
                      },
                      onViewPressed: () {
                        navigateTo(
                          context,
                          CompanyDetailsScreen(id: company.id ?? 0),
                        );
                      },
                    );
                  },
                );
              },
            ),

            // Load More Button
            if (hasMore && onLoadMore != null)
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: ElevatedButton(
                    onPressed: onLoadMore,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.orange,
                      foregroundColor: Colors.white,
                    ),
                    child: Text('load_more'.tr(context)),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
