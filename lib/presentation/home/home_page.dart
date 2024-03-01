import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm/configuration/colors.dart';
import 'package:hrm/presentation/home/home_cubit.dart';
import 'package:hrm/presentation/home/home_state.dart';
import 'package:hrm/presentation/home/widget/service_widget.dart';
import 'package:hrm/utils/custom_gradient.dart';
import 'package:hrm/utils/custom_theme.dart';
import 'package:hrm/utils/utils.dart';
import 'package:hrm/widget/customcacgeImage_widget.dart';
import 'package:hrm/widget/single_tap.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeCubit _cubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cubit = HomeCubit();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
        bloc: _cubit,
        listener: (context, state) {
          if (state is HomeFailure) {
            Utils.showToast(context, state.messageError);
            return;
          }
        },
        builder: (BuildContext context, HomeState state) {
          return _buildPage(context, state);
        });
  }

  Widget _buildPage(BuildContext context, HomeState state) {
    return Scaffold(
      backgroundColor: AppColors.newBackgroundColor,
      body: Container(
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _buildHeader(),
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
                ],
              ),
            ),
            16.verticalSpace,
            _buildNewEvent(),
            // 16.horizontalSpace,
            // _buildNewEvent(),
          ]),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return SizedBox(
      height: 270.h,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            height: 200.h,
            decoration: BoxDecoration(
              gradient: sosLinnearGradientDarkBlue2(),
              // color: const Color.fromARGB(255, 0, 11, 161),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40.r),
                bottomRight: Radius.circular(40.r),
              ),
            ),
            child: Column(
              children: [
                56.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 24.r,
                            backgroundImage: const AssetImage(
                              'assets/images/avatar.png',
                            ),
                            // radius: 100.r,
                          ),
                          16.horizontalSpace,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Xin chào, Truong Nguyen!',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelDark16
                                    .copyWith(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w500),
                              ),
                              4.verticalSpace,
                              Text(
                                'Mobile Developer',
                                style:
                                    Theme.of(context).textTheme.text14.copyWith(
                                          color: AppColors.white,
                                        ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              padding: EdgeInsets.all(16.w),
              height: 140.h,
              width: 375.w,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(children: [
                Row(
                  children: [
                    // Image.asset(
                    //   'assets/icon/ic_calendar.png',
                    //   width: 20.w,
                    //   height: 20.w,
                    // ),
                    // 8.horizontalSpace,
                    Text(
                      'Ngày 03, tháng 01, năm 2024',
                      style: Theme.of(context).textTheme.label14.copyWith(),
                    ),
                  ],
                ),
                16.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/icon/ic_check-in.png',
                              width: 24.w,
                              height: 24.w,
                            ),
                            8.horizontalSpace,
                            Text(
                              'Check-in',
                              style: Theme.of(context)
                                  .textTheme
                                  .text18w600
                                  .copyWith(),
                            ),
                          ],
                        ),
                        8.verticalSpace,
                        Text(
                          '08:00 AM',
                          style: Theme.of(context)
                              .textTheme
                              .title4
                              .copyWith(color: AppColors.dark8),
                        ),
                      ],
                    ),
                    Container(
                      width: 1.w,
                      height: 60.h,
                      color: AppColors.dark11,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/icon/ic_check-out.png',
                              width: 24.w,
                              height: 24.w,
                            ),
                            8.horizontalSpace,
                            Text(
                              'Check-out',
                              style: Theme.of(context)
                                  .textTheme
                                  .text18w600
                                  .copyWith(),
                            ),
                          ],
                        ),
                        8.verticalSpace,
                        Text(
                          '06:30 PM',
                          style: Theme.of(context)
                              .textTheme
                              .title4
                              .copyWith(color: AppColors.dark8),
                        ),
                      ],
                    ),
                  ],
                )
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewEvent() {
    return Container(
      height: 200.h,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                Text(
                  'Sự kiện gần đây',
                  style: Theme.of(context).textTheme.text16w700.copyWith(),
                ),
              ],
            ),
          ),
          16.verticalSpace,
          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.only(top: 0, bottom: 0),
                shrinkWrap: true,
                itemCount: _cubit.nextEvents.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, index) {
                  return Row(
                    children: [
                      if (index == 0) 16.horizontalSpace,
                      SingleTapDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.only(
                              left: index == 0 ? 0 : 8.w,
                              // top: 12.h,
                              bottom: 12.h),
                          height: 170.h,
                          width: 295.w,
                          child: Stack(
                            children: [
                              CustomCacheImageWidget(
                                imageUrl: _cubit.nextEvents[index],
                                height: 170.h,
                                width: 295.w,
                                fit: BoxFit.cover,
                                placeHolder: 'assets/icon/ic_no-pictures.png',
                                onPickImage: () {
                                  // NavigationUtils.rootNavigatePage(
                                  //     context,
                                  //     HotNewsDetailPage(
                                  //       id: _cubit.listHotNew[index].id,
                                  //     ));
                                },
                                radius: 10.r,
                              ),
                            ],
                          ),
                          // decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(10.r),
                          //     color: AppColor.darkRed2,
                          //     image: CustomCacheImageWidget(
                          //       imageUrl: ,
                          //     )
                          // ),
                          //     // image: DecorationImage(
                          //     //     image: AssetImage(
                          //     //         "assets/images/img_info.png"),
                          //     //     fit: BoxFit.cover)),
                          // child: Column(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   mainAxisAlignment: MainAxisAlignment.end,
                          //   children: [
                          //     Text(
                          //       _cubit.listHotNew[index].title ?? '',
                          //       style: AppStyle.medium14
                          //           .copyWith(color: AppColors.white),
                          //     ),
                          //   ],
                          // ),
                        ),
                      ),
                      if (index != 15) 12.horizontalSpace,
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }
}
