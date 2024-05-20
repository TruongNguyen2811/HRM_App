import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm/configuration/colors.dart';
import 'package:hrm/injection_container.dart';
import 'package:hrm/presentation/account/account_cubit.dart';
import 'package:hrm/presentation/account/account_state.dart';
import 'package:hrm/presentation/account/change_pass/change_password_page.dart';
import 'package:hrm/presentation/account/contract_info/contract_page.dart';
import 'package:hrm/presentation/account/widget/menu_account_widget.dart';
import 'package:hrm/presentation/authentication/authentication_cubit.dart';
import 'package:hrm/utils/custom_theme.dart';
import 'package:hrm/utils/enum.dart';
import 'package:hrm/utils/navigation_utils.dart';
import 'package:hrm/utils/utils.dart';
import 'package:hrm/widget/customcacgeImage_widget.dart';
import 'package:hrm/widget/new_appbar_widget.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late AccountCubit _cubit;

  @override
  void initState() {
    // TODO: implement initState
    _cubit = AccountCubit();
    _cubit.getData();
    _cubit.onCheckAuth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountCubit, AccountState>(
        bloc: _cubit,
        listener: (context, state) {
          if (state is AccountFailure) {
            Utils.showToast(context, state.messageError);
            return;
          }
          if (state is AccountLogOutSuccess) {
            AppCubit authCubit = getIt<AppCubit>();
            authCubit.logout();
            // getIt<AppCubit>().logout();
          }
          if (state is RequestBio) {
            Utils.showToast(context,
                'Quét sinh trắc lỗi hoặc Chức năng sinh trắc chưa được bật trong Cài đặt của thiết bị');
          }
        },
        builder: (BuildContext context, AccountState state) {
          return _buildPage(context, state);
        });
  }

  Widget _buildPage(BuildContext context, AccountState state) {
    return Scaffold(
      backgroundColor: AppColors.newBackgroundColor,
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        NewAppBarWidget(
          title: 'Tài khoản',
          leading: SizedBox(
            width: 24.w,
          ),
        ),
        SingleChildScrollView(
          child: Column(children: [
            16.verticalSpace,
            _profileWidget(context),
            16.verticalSpace,
            _settingWidget(context),
          ]),
        )
      ]),
    );
  }

  Widget _profileWidget(BuildContext context) {
    return InkWell(
      onTap: () {
        NavigationUtils.rootNavigatePage(context, ContractPage());
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.all(16.w),
        height: 104.h,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primaryColor),
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16.r),
          // gradient: sosLinnearGradientDarkBlue()
          // image: DecorationImage(
          //     fit: BoxFit.cover,
          //     image: AssetImage(
          //       R.drawable.back_card_profile,
          //     ))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    // border: Border.all(color: AppColors.border),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: CustomCacheImageWidget(
                    width: 72.w,
                    height: 72.w,
                    placeHolder: 'assets/images/avatar.png',
                    borderRadius: BorderRadius.circular(8.r),
                    imageUrl: '',
                  ),
                ),
                16.horizontalSpace,
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 160.w,
                        child: Text(
                          '${_cubit.profileAuthResponse.display_name}',
                          style: Theme.of(context)
                              .textTheme
                              .text17
                              .copyWith(color: AppColors.newPrimary),
                        ),
                      ),
                      SizedBox(
                        width: 160.w,
                        child: Text(
                          '${_cubit.profileAuthResponse.company_name}',
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .label14
                              .copyWith(color: AppColors.newPrimary),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Chi tiết',
                  style: Theme.of(context)
                      .textTheme
                      .tooltip
                      .copyWith(color: AppColors.newPrimary),
                ),
                Icon(
                  Icons.arrow_forward,
                  size: 16.w,
                  color: AppColors.newPrimary,
                )
                // Image.asset(
                //   R.drawable.ic_arrow_right,
                //   width: 16.w,
                //   height: 16.w,
                //   color: AppColors.shadow,
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _settingWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Cài đặt',
            style: Theme.of(context)
                .textTheme
                .bold14
                .copyWith(color: AppColors.black),
          ),
          8.verticalSpace,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16.r)),
            child: Column(
              children: [
                MenuAccountWidget(
                  prefixIcon: 'assets/icon/reset-password.png',
                  title: 'Thay đổi mật khẩu',
                  onTap: () {
                    NavigationUtils.rootNavigatePage(
                        context, ChangePassWordPage());
                  },
                ),
                MenuAccountWidget(
                  prefixIcon: 'assets/icon/fingerprint.png',
                  title: 'Đăng nhập nhanh',
                  valueSwitch: _cubit.checkBio,
                  onChangeSwitch: (value) {
                    _cubit.onBioAuth();
                  },
                  showArrow: false,
                  showSwitch: true,
                ),
                // MenuAccountWidget(
                //   prefixIcon: 'assets/icon/file.png',
                //   title: 'Điều khoản và chính sách',
                //   onTap: () {},
                // ),
                MenuAccountWidget(
                  prefixIcon: 'assets/icon/customer-support.png',
                  title: 'Trung tâm hỗ trợ',
                  onTap: () {
                    Utils.launchURL(Utils.getTypeUrlLauncher(
                        '0963591488', LaunchType.LAUNCH_TYPE_PHONE));
                  },
                ),
                // MenuAccountWidget(
                //   prefixIcon: 'assets/icon/delete-document.png',
                //   title: 'Xoá tài khoản',
                //   onTap: () {
                //     // Utils.verifyAuthFuncOnClick(context, onPressed: () {
                //     //   AppTracking.instance.trackButtonClick('Click_Delete_Account');
                //     //   showAlertDialog(context,
                //     //       icon: Image.asset(R.drawable.img_trash,
                //     //           width: 130.w, height: 130.h),
                //     //       textStyle: Theme.of(context)
                //     //           .textTheme
                //     //           .labelHighLight2
                //     //           .copyWith(color: AppColors.dangerColor),
                //     //       title: 'Xoá tài khoản',
                //     //       content: Container(
                //     //         padding: EdgeInsets.symmetric(
                //     //             horizontal: R.dimen.thirdPadding),
                //     //         child: SingleChildScrollView(
                //     //           child: Column(
                //     //             mainAxisSize: MainAxisSize.min,
                //     //             crossAxisAlignment: CrossAxisAlignment.start,
                //     //             children: [
                //     //              Text(
                //     //                       'Tài khoản bị xoá sẽ không thể khôi phục lại dữ liệu đã có. Vui lòng cân nhắc khi kỹ trước khi xoá.',
                //     //                       textAlign: TextAlign.center,
                //     //                       style: Theme.of(context).textTheme.text14W600,
                //     //                     ),
                //     //             ],
                //     //           ),
                //     //         ),
                //     //       ),
                //     //       isWarning: true,
                //     //       primaryButtonTitle: 'Tôi đồng ý xoá tài khoản',
                //     //       onPrimaryButtonTap: (context) {

                //     //         NavigationUtils.popDialog(context);
                //     //       },
                //     //       secondaryButtonTitle: 'Huỷ',
                //     //       onSecondaryButtonTap: (_) {
                //     //         NavigationUtils.popDialog(context);
                //     //       });
                //     //   _cubit.refreshState();
                //     // });
                //   },
                // ),
                MenuAccountWidget(
                  showArrow: false,
                  prefixIcon: 'assets/icon/logout.png',
                  title: 'Đăng xuất',
                  onTap: () {
                    _cubit.logout();
                    // showAlertDialog(
                    //   context,
                    //   isWarning: true,
                    //   icon: Image.asset(R.drawable.img_problem,
                    //       width: 122.w, height: 122.h),
                    //   title: 'Xác nhận đăng xuất tài khoản',
                    //   textStyle: Theme.of(context)
                    //       .textTheme
                    //       .labelHighLight2
                    //       .copyWith(color: AppColors.dangerColor),
                    //   primaryButtonTitle: 'Đăng xuất',
                    //   onPrimaryButtonTap: (context) async {
                    //     AppTracking.instance.trackButtonClick('Click_logout');
                    //     Utils.showToast(context, R.string.logout_success.tr(),
                    //         type: ToastType.SUCCESS);
                    //     _pref.removeEpassToken();
                    //     _authCubit.logoutInApp();
                    //     NavigationUtils.popDialog(context);
                    //   },
                    //   secondaryButtonTitle: 'Huỷ',
                    //   onSecondaryButtonTap: (_) =>
                    //       NavigationUtils.popDialog(context),
                    // );
                  },
                  showDivider: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
