import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm/configuration/colors.dart';
import 'package:hrm/presentation/create_order/create_order_cubit.dart';
import 'package:hrm/presentation/create_order/create_order_state.dart';
import 'package:hrm/presentation/create_order/order_type/order_type_page.dart';
import 'package:hrm/presentation/time_keeping/time_keeping_cubit.dart';
import 'package:hrm/presentation/time_keeping/time_keeping_state.dart';
import 'package:hrm/utils/custom_gradient.dart';
import 'package:hrm/utils/custom_theme.dart';
import 'package:hrm/utils/enum.dart';
import 'package:hrm/utils/navigation_utils.dart';
import 'package:hrm/utils/utils.dart';
import 'package:hrm/widget/button_widget.dart';
import 'package:hrm/widget/new_appbar_widget.dart';
import 'package:hrm/widget/single_tap.dart';
import 'package:hrm/widget/text_field_date_widget.dart';
import 'package:hrm/widget/text_field_range_date_widget.dart';
import 'package:hrm/widget/text_field_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class CreateOrderPage extends StatefulWidget {
  const CreateOrderPage({super.key});

  @override
  State<CreateOrderPage> createState() => _CreateOrderState();
}

class _CreateOrderState extends State<CreateOrderPage> {
  late CreateOrderCubit _cubit;
  late RefreshController refreshController;
  @override
  void initState() {
    // TODO: implement initState
    _cubit = CreateOrderCubit();
    refreshController = RefreshController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateOrderCubit, CreateOrderState>(
        bloc: _cubit,
        listener: (context, state) {
          if (state is CreateOrderFailure) {
            Utils.showToast(context, state.messageError);
            return;
          }
          if (state is CreateOrderSuccess) {
            Utils.showToast(
                context, 'Bạn đã tạo thành công đơn ${_cubit.typeOrder.text}',
                type: ToastType.SUCCESS);
            NavigationUtils.popPage(context);
          }
        },
        builder: (BuildContext context, CreateOrderState state) {
          return _buildPage(context, state);
        });
  }

  Widget _buildPage(BuildContext context, CreateOrderState state) {
    return KeyboardDismissOnTap(
      child: Scaffold(
        backgroundColor: AppColors.newBackgroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            NewAppBarWidget(
              title: 'Tạo đơn',
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      16.verticalSpace,
                      8.verticalSpace,
                      Row(
                        children: [
                          Text(
                            'Loại đơn',
                            style: Theme.of(context)
                                .textTheme
                                .text14W400
                                .copyWith(color: AppColors.dark3),
                          ),
                          Text(
                            '*',
                            style: Theme.of(context)
                                .textTheme
                                .text14W400
                                .copyWith(color: AppColors.red),
                          ),
                        ],
                      ),
                      8.verticalSpace,
                      SingleTapDetector(
                        onTap: () {
                          print('131');
                          showDialog(
                              context: context,
                              builder: (_) {
                                return OrderTypePage(
                                  type: _cubit.typeOrder.text,
                                );
                              }).then((value) {
                            _cubit.typeOrder.text = value;
                          });
                        },
                        child: TextFieldWidget(
                          controller: _cubit.typeOrder,
                          hintText: 'Chọn loại đơn',
                          isEnable: false,
                          fillColor: AppColors.white,
                          // fillBackground: true,
                        ),
                      ),
                      8.verticalSpace,
                      Row(
                        children: [
                          Text(
                            'Từ ngày',
                            style: Theme.of(context)
                                .textTheme
                                .text14W400
                                .copyWith(color: AppColors.dark3),
                          ),
                          Text(
                            '*',
                            style: Theme.of(context)
                                .textTheme
                                .text14W400
                                .copyWith(color: AppColors.red),
                          ),
                        ],
                      ),
                      8.verticalSpace,
                      TextFieldDateWidget(
                        controller: _cubit.fromDate,
                        hintText: 'Chọn thời gian bắt đầu',
                      ),
                      8.verticalSpace,
                      Row(
                        children: [
                          Text(
                            'Đến ngày',
                            style: Theme.of(context)
                                .textTheme
                                .text14W400
                                .copyWith(color: AppColors.dark3),
                          ),
                          Text(
                            '*',
                            style: Theme.of(context)
                                .textTheme
                                .text14W400
                                .copyWith(color: AppColors.red),
                          ),
                        ],
                      ),
                      8.verticalSpace,
                      TextFieldDateWidget(
                        controller: _cubit.toDate,
                        hintText: 'Chọn thời gian kết thúc',
                      ),
                      // 8.verticalSpace,
                      // Row(
                      //   children: [
                      //     Text(
                      //       'Tổng số giờ',
                      //       style: Theme.of(context)
                      //           .textTheme
                      //           .text14W400
                      //           .copyWith(color: AppColors.dark3),
                      //     ),
                      //     // Text(
                      //     //   '*',
                      //     //   style: Theme.of(context)
                      //     //       .textTheme
                      //     //       .text14W400
                      //     //       .copyWith(color: AppColors.red),
                      //     // ),
                      //   ],
                      // ),
                      // 8.verticalSpace,
                      // TextFieldWidget(
                      //   controller: _cubit.totalHours,
                      //   hintText: '0 giờ',
                      // ),
                      8.verticalSpace,
                      Row(
                        children: [
                          Text(
                            'Lý do',
                            style: Theme.of(context)
                                .textTheme
                                .text14W400
                                .copyWith(color: AppColors.dark3),
                          ),
                          Text(
                            '*',
                            style: Theme.of(context)
                                .textTheme
                                .text14W400
                                .copyWith(color: AppColors.red),
                          ),
                        ],
                      ),
                      8.verticalSpace,
                      TextFieldWidget(
                        controller: _cubit.reason,
                        hintText: 'Chọn lý do',
                      ),
                      8.verticalSpace,
                      Row(
                        children: [
                          Text(
                            'Nội dung',
                            style: Theme.of(context)
                                .textTheme
                                .text14W400
                                .copyWith(color: AppColors.dark3),
                          ),
                          // Text(
                          //   '*',
                          //   style: Theme.of(context)
                          //       .textTheme
                          //       .text14W400
                          //       .copyWith(color: AppColors.red),
                          // ),
                        ],
                      ),
                      8.verticalSpace,
                      TextFieldWidget(
                        controller: _cubit.content,
                        maxLength: 100,
                        maxLines: 4,
                        hintText: 'Nội dung',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
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
              _cubit.Submit();
            },
          ),
        ),
      ),
    );
  }
}
