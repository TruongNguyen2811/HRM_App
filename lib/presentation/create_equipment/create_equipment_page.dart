import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm/configuration/colors.dart';
import 'package:hrm/model/response/department_list_response.dart';
import 'package:hrm/model/response/employee_info_response.dart';
import 'package:hrm/model/response/room_info_response.dart';
import 'package:hrm/presentation/create_equipment/create_equipment_cubit.dart';
import 'package:hrm/presentation/create_equipment/create_equipment_state.dart';
import 'package:hrm/utils/custom_gradient.dart';
import 'package:hrm/utils/custom_theme.dart';
import 'package:hrm/utils/enum.dart';
import 'package:hrm/utils/navigation_utils.dart';
import 'package:hrm/utils/utils.dart';
import 'package:hrm/widget/button_widget.dart';
import 'package:hrm/widget/dropdown_widget.dart';
import 'package:hrm/widget/new_appbar_widget.dart';
import 'package:hrm/widget/new_time_picker_widget.dart';
import 'package:hrm/widget/search_list_item.dart';
import 'package:hrm/widget/show_loading_widget.dart';
import 'package:hrm/widget/text_field_date_widget.dart';
import 'package:hrm/widget/text_field_widget.dart';

class CreateEquipmentPage extends StatefulWidget {
  const CreateEquipmentPage({super.key});

  @override
  State<CreateEquipmentPage> createState() => _CreateEquipmentPageState();
}

class _CreateEquipmentPageState extends State<CreateEquipmentPage> {
  late CreateEquipmentCubit _cubit;

  @override
  void initState() {
    // TODO: implement initState
    _cubit = CreateEquipmentCubit();
    _cubit.getListDepartment();
    _cubit.getListEmployee();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateEquipmentCubit, CreateEquipmentState>(
        bloc: _cubit,
        listener: (context, state) {
          if (state is CreateEquipmentFailure) {
            Utils.showToast(context, state.messageError);
            return;
          }
          if (state is CreateEquipmentSuccess) {
            Utils.showToast(
                context, 'Bạn đã tạo đơn mượn văn phòng phẩm thành công',
                type: ToastType.SUCCESS);
            NavigationUtils.popPage(context);
          }
        },
        builder: (BuildContext context, CreateEquipmentState state) {
          return _buildPage(context, state);
        });
  }

  Widget _buildPage(BuildContext context, CreateEquipmentState state) {
    return ShowLoadingWidget(
      isLoading: state is CreateEquipmentLoading,
      child: KeyboardDismissOnTap(
        child: Scaffold(
          backgroundColor: AppColors.newBackgroundColor,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              NewAppBarWidget(
                title: 'Đơn xin văn phòng phẩm',
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        16.verticalSpace,
                        8.verticalSpace,
                        DropDownFieldWidget(
                          borderRadius: 16.r,
                          isEnable: true,
                          titleText: 'Nhân viên',
                          require: true,
                          hintText: 'Vui lòng chọn nhân viên',
                          value: _cubit.employeeChoose?.name,
                          // colorRequired: false,
                          // textStyle: Theme.of(context).textTheme.subTitle.copyWith(
                          // color: Utils.isEmpty(_cubit.cityChoose)
                          //     ? AppColors.enableButton: AppColors.dark1),
                          onClick: (currentValue) {
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (Utils.isEmptyArray(_cubit.listEmployee)) return;
                            showModalBottomSheet(
                                context: context,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16.r)),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                backgroundColor: Colors.transparent,
                                builder: (context) {
                                  final int? defaultIndex = _cubit.listEmployee
                                      ?.indexWhere((element) =>
                                          element.id ==
                                          _cubit.employeeChoose?.id);

                                  print(defaultIndex);
                                  return SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.6,
                                    child:
                                        SearchListSimpleItemPopup<EmployeeInfo>(
                                      listData: _cubit.listEmployee,
                                      title: 'Chọn nhân viên',
                                      showSearch: false,
                                      isShowButton: false,
                                      // pressSearch: true,
                                      defaultIndexes: defaultIndex != null &&
                                              defaultIndex >= 0
                                          ? [defaultIndex]
                                          : null,
                                      onSelect: (List<int> indexes) {
                                        print('check select');
                                        if (Utils.isEmptyArray(indexes)) {
                                          _cubit.chooseEmployee(null);

                                          return;
                                        } else {
                                          _cubit.chooseEmployee(_cubit
                                              .listEmployee[indexes.first]);
                                        }
                                        // NavigationUtils.popPage(context);
                                      },
                                      builder: (item) => item.name ?? '',
                                    ),
                                  );
                                });
                          },
                        ),
                        8.verticalSpace,
                        Row(
                          children: [
                            Text(
                              'Ngày đặt',
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
                          hintText: 'Chọn thời gian',
                        ),
                        8.verticalSpace,
                        DropDownFieldWidget(
                          borderRadius: 16.r,
                          isEnable: true,
                          titleText: 'Phòng ban',
                          require: true,
                          hintText: 'Vui lòng chọn phòng ban',
                          value: _cubit.infoDepartmentChoose?.name,
                          // colorRequired: false,
                          // textStyle: Theme.of(context).textTheme.subTitle.copyWith(
                          // color: Utils.isEmpty(_cubit.cityChoose)
                          //     ? AppColors.enableButton: AppColors.dark1),
                          onClick: (currentValue) {
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (Utils.isEmptyArray(_cubit.listDepartment))
                              return;
                            showModalBottomSheet(
                                context: context,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16.r)),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                backgroundColor: Colors.transparent,
                                builder: (context) {
                                  final int? defaultIndex = _cubit
                                      .listDepartment
                                      ?.indexWhere((element) =>
                                          element.id ==
                                          _cubit.infoDepartmentChoose?.id);

                                  print(defaultIndex);
                                  return SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.6,
                                    child: SearchListSimpleItemPopup<
                                        DepartmentInfo>(
                                      listData: _cubit.listDepartment,
                                      title: 'Chọn phòng ban',
                                      showSearch: false,
                                      isShowButton: false,
                                      // pressSearch: true,
                                      defaultIndexes: defaultIndex != null &&
                                              defaultIndex >= 0
                                          ? [defaultIndex]
                                          : null,
                                      onSelect: (List<int> indexes) {
                                        print('check select');
                                        if (Utils.isEmptyArray(indexes)) {
                                          _cubit.chooseRoom(null);

                                          return;
                                        } else {
                                          _cubit.chooseRoom(_cubit
                                              .listDepartment[indexes.first]);
                                        }
                                        // NavigationUtils.popPage(context);
                                      },
                                      builder: (item) => item.name ?? '',
                                    ),
                                  );
                                });
                          },
                        ),
                        8.verticalSpace,
                        Row(
                          children: [
                            Text(
                              'Văn phòng phẩm',
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
                          controller: _cubit.equipment,
                          maxLength: 500,
                          maxLines: 1,
                          hintText: 'Văn phòng phẩm',
                        ),
                        8.verticalSpace,
                        Row(
                          children: [
                            Text(
                              'Mục đích',
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
                          maxLength: 500,
                          maxLines: 4,
                          hintText: 'Mục đích',
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
                // _cubit.Submit();
              },
            ),
          ),
        ),
      ),
    );
  }
}
