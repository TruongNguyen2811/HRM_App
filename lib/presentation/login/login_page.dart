import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm/configuration/colors.dart';
import 'package:hrm/presentation/main/main_page.dart';
import 'package:hrm/services/repository/app_repository_impl.dart';
import 'package:hrm/utils/custom_theme.dart';
import 'package:hrm/utils/navigation_utils.dart';
import 'package:hrm/utils/utils.dart';
import 'package:hrm/widget/button_widget.dart';
import 'package:hrm/widget/show_loading_widget.dart';
import 'package:hrm/widget/text_field_widget.dart';

import 'login_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginCubit _cubit;

  late TextEditingController _phoneNumberController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    AppRepository repository = AppRepository();
    _cubit = LoginCubit(repository: repository);
    getBio();
    _phoneNumberController = TextEditingController();
    _passwordController = TextEditingController();
  }

  getBio() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0x19000000),
      body: BlocProvider(
        create: (_) => _cubit,
        child: BlocConsumer<LoginCubit, LoginState>(
          bloc: _cubit,
          listener: (context, state) async {
            if (state is LoginFailure) {
              // ignore: use_build_context_synchronously
              Utils.showToast(context, state.messageError);
            }
            if (state is LoginPhoneNotUpdatePassword) {
              NavigationUtils.replacePage(
                context,
                const MainPage(),
              );
            }
            if (state is LoginPhoneIsUpdatePassword) {
              // NavigationUtils.navigatePage(
              //   context,
              //   LoginNewPasswordPage(
              //     numberPhone: _phoneNumberController.text,
              //   ),
              // );
            }
          },
          builder: (context, state) {
            return _buildBody(state);
            // return buildPage(context, state);
          },
        ),
      ),
    );
  }

  Widget _buildBody(LoginState state) {
    return ShowLoadingWidget(
      isLoading: state is LoginLoading,
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // NewAppBarWidget(
                  //     title: "Đăng nhập",
                  //     leading: SizedBox(height: 24.h, width: 24.w)),
                  SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 278.h,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/hrm_banner.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        // SizedBox(
                        //     height: 278.h,
                        //     child: Stack(
                        //       children: [
                        //         Align(
                        //           alignment: Alignment.topCenter,
                        //           child: Container(
                        //             height: 278.h,
                        //             width: double.infinity,
                        //             decoration: const BoxDecoration(
                        //               image: DecorationImage(
                        //                 image: AssetImage(
                        //                     'assets/images/hrm_banner.png'),
                        //                 fit: BoxFit.fill,
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //       ],
                        //     )),
                        _buildLoginPhone(),
                        16.verticalSpace,
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Bạn cần hỗ trợ?",
                              style: Theme.of(context)
                                  .textTheme
                                  .subTitle16
                                  .copyWith(color: AppColors.dark7),
                            ),
                            4.verticalSpace,
                            Text(
                              "Liên hệ tổng đài CSKH",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelHighLight
                                  .copyWith(color: AppColors.blue1),
                            ),
                            4.verticalSpace,
                            GestureDetector(
                              onTap: () {
                                // Utils.launchURL(Utils.getTypeUrlLauncher(
                                //     Consts.PHONE_DEFAULT,
                                //     LaunchType.LAUNCH_TYPE_PHONE));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/icon/call.png',
                                    width: 24.w,
                                    height: 24.h,
                                    color: AppColors.dark7,
                                  ),
                                  4.horizontalSpace,
                                  Text(
                                    '0963591488',
                                    style: Theme.of(context)
                                        .textTheme
                                        .text16
                                        .copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.dark7,
                                          decoration: TextDecoration.underline,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            24.verticalSpace,
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginPhone() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFieldWidget(
            borderColor: AppColors.secondaryLine,
            borderFocusColor: AppColors.secondaryLine,
            borderErrorColor: AppColors.darkger1,
            titleText: 'Số điện thoại',
            maxLength: 10,
            controller: _phoneNumberController,
            keyboardType: TextInputType.phone,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            textInputAction: TextInputAction.done,
            hintText: 'Nhập số điện thoại của bạn',
            titleSize: 16.sp,
            titleWeight: FontWeight.w700,
            onChanged: (value) {
              _cubit.checkFocus(value);
            },
            errorText: _cubit.isErrorEnable ? _cubit.contentError : null,
          ),
          16.verticalSpace,
          TextFieldWidget(
            borderColor: AppColors.secondaryLine,
            borderFocusColor: AppColors.secondaryLine,
            borderErrorColor: AppColors.darkger1,
            titleText: 'Mật khẩu',
            controller: _passwordController,
            isPassword: true,
            // keyboardType: TextInputType.visiblePassword,
            // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            textInputAction: TextInputAction.done,
            suffixColor: AppColors.dark8,
            hintText: 'Nhập mật khẩu của bạn',
            titleSize: 16.sp,
            titleWeight: FontWeight.w700,
            onChanged: (value) {
              // _cubit.checkFocus(value);
            },
            errorText: _cubit.isErrorPasswordEnable
                ? _cubit.contentPasswordError
                : null,
            // errorText: _cubit.isErrorEnable ? _cubit.contentError : null,
          ),
          24.verticalSpace,
          Row(
            children: [
              Expanded(
                child: ButtonWidget(
                  // width: double.infinity,
                  radius: 32.r,
                  title: 'Đăng nhập',
                  // gradient: sosLinnearGradientDarkBlue(),
                  backgroundColor: AppColors.primaryColor,
                  textColor: AppColors.white,
                  disableTextColor: AppColors.dark7,
                  disableColor: AppColors.greyText,
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    await _cubit.checkUpdatePassword(
                        _phoneNumberController.text, _passwordController.text);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // GetIt.I<MainCubit>().lastPageBeforeLogin = null;
    // GetIt.I<AuthenticationCubit>().loginWithAnonymous();
    // if (getIt.isRegistered<PickInfoCubit>()) {
    //   getIt<PickInfoCubit>().getDriverDetail(isRefresh: true);
    // }
    super.dispose();
  }
}
