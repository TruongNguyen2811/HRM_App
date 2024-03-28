import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm/configuration/colors.dart';
import 'package:hrm/presentation/create_order/order_type/order_type_cubit.dart';
import 'package:hrm/presentation/create_order/order_type/order_type_state.dart';
import 'package:hrm/utils/custom_gradient.dart';
import 'package:hrm/utils/custom_theme.dart';
import 'package:hrm/widget/button_widget.dart';
import 'package:hrm/widget/single_tap.dart';

class OrderTypePage extends StatefulWidget {
  String? type;
  OrderTypePage({super.key, this.type});

  @override
  State<OrderTypePage> createState() => _OrderTypePageState();
}

class _OrderTypePageState extends State<OrderTypePage> {
  late OrderTypeCubit cubit;
  @override
  void initState() {
    // TODO: implement initState
    cubit = OrderTypeCubit();
    cubit.selected = widget.type ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderTypeCubit, OrderTypeState>(
      bloc: cubit,
      listener: (context, state) {},
      builder: (context, state) {
        return buildDialog(context, state);
      },
    );
  }

  Widget buildDialog(BuildContext context, OrderTypeState state) {
    return KeyboardDismissOnTap(
        child: Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 0.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        width: 327.w,
        height: 400.h,
        // height: 230.h,
        decoration: ShapeDecoration(
          color: AppColors.homeBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x19000000),
              blurRadius: 15,
              offset: Offset(0, 0),
              spreadRadius: 0,
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Chọn loại đơn',
              style: Theme.of(context)
                  .textTheme
                  .labelHighLight
                  .copyWith(color: AppColors.dark3),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(children: [
                  item('Đơn xin nghỉ phép'),
                  item('Đơn nghỉ không phép'),
                  item('Đơn đi muộn / về sớm'),
                  item('Đơn xin ra ngoài'),
                  item('Đơn xin công tác'),
                  item('Đơn xin đổi ca'),
                  item('Giải trình quên chấm công'),
                  item('Giải trình chấm công không đúng giờ'),
                  item('Đơn đổi giờ làm việc'),
                  item('Đơn xin sử dụng chế độ con nhỏ'),
                ]),
              ),
            ),
            16.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: ButtonWidget(
                      backgroundColor: AppColors.white,
                      borderColor: AppColors.primaryColor,
                      height: 40.h,
                      textColor: Colors.white,
                      radius: 8.r,
                      title: 'Hủy',
                      textStyle: Theme.of(context)
                          .textTheme
                          .text14W600
                          .copyWith(color: AppColors.primaryColor, height: 0),
                      onPressed: () {
                        // // cubit.sharedPref.removeFilterConfig();
                        // NavigationUtils.popDialog(context);
                        Navigator.pop(context);
                      }),
                ),
                16.horizontalSpace,
                Expanded(
                  child: ButtonWidget(
                      gradient: mainGradientPrimary(),
                      height: 40.h,
                      textColor: Colors.white,
                      radius: 8.r,
                      title: 'Xác nhận',
                      textStyle: Theme.of(context)
                          .textTheme
                          .text14W600
                          .copyWith(color: Colors.white, height: 0),
                      onPressed: () {
                        Navigator.of(context).pop(cubit.selected);
                        // return cubit.selected;
                        // print('Check name brand ${cubit.carBrand?.title}');
                        // cubit.voidSubmitSessionId();
                      }),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }

  Widget item(String title) {
    return SingleTapDetector(
      onTap: () {
        setState(() {
          cubit.selected = title;
        });
      },
      child: Container(
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Container(
                  width: 270.w,
                  child: Text(
                    '${title}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .subTitle16
                        .copyWith(color: AppColors.dark3),
                  ),
                ),
              ),
              Image.asset(
                cubit.selected == title
                    ? "assets/icon/ic_tick_square.png"
                    : "assets/icon/ic_untick_square.png",
                width: 20.w,
                height: 20.h,
              )
            ],
          ),
          Divider(
            height: 1.w,
            color: AppColors.dark3,
          )
        ]),
      ),
    );
  }
}
