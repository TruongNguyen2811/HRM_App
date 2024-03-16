import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm/configuration/colors.dart';
import 'package:hrm/presentation/home/widget/service_widget.dart';
import 'package:hrm/presentation/utility/utility_cubit.dart';
import 'package:hrm/presentation/utility/utility_state.dart';
import 'package:hrm/utils/custom_theme.dart';
import 'package:hrm/utils/utils.dart';
import 'package:hrm/widget/customcacgeImage_widget.dart';
import 'package:hrm/widget/new_appbar_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class UtilityPage extends StatefulWidget {
  const UtilityPage({super.key});

  @override
  State<UtilityPage> createState() => _UtilityPageState();
}

class _UtilityPageState extends State<UtilityPage> {
  late UtilityCubit _cubit;
  late PageController _pageController;
  @override
  void initState() {
    // TODO: implement initState
    _cubit = UtilityCubit();
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UtilityCubit, UtilityState>(
        bloc: _cubit,
        listener: (context, state) {
          if (state is UtilityFailure) {
            Utils.showToast(context, state.messageError);
            return;
          }
        },
        builder: (BuildContext context, UtilityState state) {
          return _buildPage(context, state);
        });
  }

  Widget _buildPage(BuildContext context, UtilityState state) {
    return Scaffold(
      backgroundColor: AppColors.newBackgroundColor,
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        NewAppBarWidget(
          title: 'Tiện ích',
          leading: SizedBox(width: 24.w),
        ),
        SingleChildScrollView(
          child: Column(children: [
            16.verticalSpace,
            _bannerWidget(),
            16.verticalSpace,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tiện ích',
                      style: Theme.of(context).textTheme.text16w700.copyWith(),
                    ),
                    16.verticalSpace,
                    HomeMenuWidget(),
                  ]),
            )
          ]),
        )
      ]),
    );
  }

  Widget _bannerWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 0.2.sh,
          child: PageView.builder(
            controller: _pageController,
            itemBuilder: (context, index) {
              // final item = bannerImages[index];
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: CustomCacheImageWidget(
                  fit: BoxFit.cover,
                  height: 140.h,
                  width: 380.w,
                  onPreviewImage: () {
                    // Utils.rootNavigatePageBanner(context,
                    //     actionType: listHeaderBanner?.detail?[index].action
                    //         ?.actionType,
                    //     route: listHeaderBanner?.detail?[index].action?.route);
                  },
                  borderRadius: BorderRadius.circular(16.r),
                  imageUrl: _cubit.nextEvents[index] ?? '',
                ),
                // child: Image.asset(
                //   item,
                //   fit: BoxFit.fill,
                // ),
              );
            },
            itemCount: _cubit.nextEvents.length ?? 1,
          ),
        ),
        SmoothPageIndicator(
          controller: _pageController, // PageController
          count: _cubit.nextEvents.length ?? 1,
          effect: WormEffect(
              dotHeight: 8.r,
              dotWidth: 8.r,
              dotColor: AppColors.dark12,
              activeDotColor: AppColors.primaryColor2), // your preferred effect
        )
      ],
    );
  }
}
