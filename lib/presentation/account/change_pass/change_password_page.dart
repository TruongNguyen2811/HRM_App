import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm/configuration/colors.dart';
import 'package:hrm/presentation/account/change_pass/change_pass_cubit.dart';
import 'package:hrm/presentation/account/change_pass/change_pass_state.dart';
import 'package:hrm/utils/custom_gradient.dart';
import 'package:hrm/utils/navigation_utils.dart';
import 'package:hrm/utils/utils.dart';
import 'package:hrm/widget/button_widget.dart';
import 'package:hrm/widget/new_appbar_widget.dart';
import 'package:hrm/widget/text_field_widget.dart';

class ChangePassWordPage extends StatefulWidget {
  const ChangePassWordPage({super.key});

  @override
  State<ChangePassWordPage> createState() => _ChangePassWordPageState();
}

class _ChangePassWordPageState extends State<ChangePassWordPage> {
  late ChangePassCubit _cubit;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cubit = ChangePassCubit();
    _cubit.getData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChangePassCubit, ChangePassState>(
        bloc: _cubit,
        listener: (context, state) {
          if (state is ChangePassFailure) {
            Utils.showToast(context, state.messageError);
            return;
          }
          if (state is ChangePassSuccess) {
            NavigationUtils.popPage(context);
            // getIt<AppCubit>().logout();
          }
        },
        builder: (BuildContext context, ChangePassState state) {
          return _buildPage(context, state);
        });
  }

  Widget _buildPage(BuildContext context, ChangePassState state) {
    return KeyboardDismissOnTap(
      child: Scaffold(
        backgroundColor: AppColors.newBackgroundColor,
        body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          const NewAppBarWidget(
            title: 'Đổi mật khẩu',
          ),
          SingleChildScrollView(
            child: Column(children: [
              Container(
                height: 278.h,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/hrm_banner.png'),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: TextFieldWidget(
                  titleText: 'Nhập mật khẩu mới',
                  isPassword: true,
                  controller: _cubit.textEditingController,
                ),
              )
            ]),
          )
        ]),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color(0x19000000),
                blurRadius: 12,
                offset: Offset(0, -4),
                spreadRadius: 0,
              )
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: ButtonWidget(
            title: "Xác nhận",
            gradient: mainGradientPrimary(),
            onPressed: () {
              _cubit.changePass();
            },
          ),
        ),
      ),
    );
  }
}
