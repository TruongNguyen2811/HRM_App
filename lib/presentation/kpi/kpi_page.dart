import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm/configuration/colors.dart';
import 'package:hrm/presentation/kpi/kpi_cubit.dart';
import 'package:hrm/presentation/kpi/kpi_state.dart';
import 'package:hrm/utils/custom_theme.dart';
import 'package:hrm/utils/utils.dart';
import 'package:hrm/widget/new_appbar_widget.dart';
import 'package:hrm/widget/show_loading_widget.dart';
import 'package:hrm/widget/text_field_range_date_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class KpiPage extends StatefulWidget {
  const KpiPage({super.key});

  @override
  State<KpiPage> createState() => _KpiPageState();
}

class _KpiPageState extends State<KpiPage> {
  late KPICubit _cubit;
  late RefreshController _refreshController;
  @override
  void initState() {
    _cubit = KPICubit();
    _cubit.getKPIReport();
    _refreshController = RefreshController();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<KPICubit, KPIState>(
        bloc: _cubit,
        listener: (context, state) {
          if (state is KPIFailure) {
            Utils.showToast(context, state.messageError);
            return;
          }
        },
        builder: (BuildContext context, KPIState state) {
          return _buildPage(context, state);
        });
  }

  Widget _buildPage(BuildContext context, KPIState state) {
    return ShowLoadingWidget(
      isLoading: state is KPILoading,
      child: Scaffold(
        backgroundColor: AppColors.newBackgroundColor,
        body: Column(children: [
          NewAppBarWidget(
            title: 'Xem KPI',
          ),
          Expanded(
            child: Column(
              children: [
                // Container(
                //   color: AppColors.white,
                //   padding:
                //       EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                //   child: TextFieldRangeDateWidget(
                //     controller: _cubit.datePicker,
                //     hintText: 'Chọn ngày ',
                //     confirm: (() {
                //       // print('check confirm ${_cubit.datePicker.text}');
                //       // _cubit.getAttendance();
                //     }),
                //   ),
                // ),
                8.verticalSpace,
                Container(
                    color: AppColors.white,
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    child: Row(
                      children: [
                        Text(
                          'KPI tháng ${DateTime.now().month}',
                          style:
                              Theme.of(context).textTheme.text14W500.copyWith(),
                        ),
                      ],
                    )),
                Expanded(
                  child: Utils.isEmpty(_cubit.kpiResponse)
                      ? _emptyWidget()
                      : SmartRefresher(
                          controller: _refreshController,
                          onRefresh: () {
                            _refreshController.refreshCompleted();
                          },
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                8.verticalSpace,
                                Container(
                                  color: AppColors.white,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.w, vertical: 8.h),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        rowTextComponent(
                                            'Tên nhân viên',
                                            _cubit.kpiResponse[0]
                                                    .employee_name ??
                                                ''),
                                        8.verticalSpace,
                                        rowTextComponent(
                                            'Tên công ty',
                                            _cubit.kpiResponse[0]
                                                    .company_name ??
                                                ''),
                                        8.verticalSpace,
                                        rowTextComponent(
                                            'Phòng ban',
                                            _cubit.kpiResponse[0]
                                                    .department_name ??
                                                ''),
                                        8.verticalSpace,
                                        rowTextComponent(
                                            'Phạt tuần 1',
                                            _cubit.kpiResponse[0]
                                                    .compensation_amount_week_1
                                                    .toString() ??
                                                ''),
                                        8.verticalSpace,
                                        rowTextComponent(
                                            'Phạt tuần 2',
                                            _cubit.kpiResponse[0]
                                                    .compensation_amount_week_2
                                                    .toString() ??
                                                ''),
                                        8.verticalSpace,
                                        rowTextComponent(
                                            'Phạt tuần 3',
                                            _cubit.kpiResponse[0]
                                                    .compensation_amount_week_3
                                                    .toString() ??
                                                ''),
                                        8.verticalSpace,
                                        rowTextComponent(
                                            'Phạt tuần 4',
                                            _cubit.kpiResponse[0]
                                                    .compensation_amount_week_4
                                                    .toString() ??
                                                ''),
                                        8.verticalSpace,
                                        rowTextComponent(
                                            'Phạt tuần 5',
                                            _cubit.kpiResponse[0]
                                                    .compensation_amount_week_5
                                                    .toString() ??
                                                ''),
                                        8.verticalSpace,
                                        rowTextComponent(
                                            'Tổng phạt',
                                            _cubit.kpiResponse[0]
                                                    .total_compensation
                                                    .toString() ??
                                                ''),
                                        8.verticalSpace,
                                        rowTextComponent(
                                            'Trạng thái tuần 1',
                                            _cubit.kpiResponse[0]
                                                    .compensation_status_week_1
                                                    .toString() ??
                                                ''),
                                        8.verticalSpace,
                                        rowTextComponent(
                                            'Trạng thái tuần 2',
                                            _cubit.kpiResponse[0]
                                                    .compensation_status_week_2 ??
                                                ''),
                                        8.verticalSpace,
                                        rowTextComponent(
                                            'Trạng thái tuần 3',
                                            _cubit.kpiResponse[0]
                                                    .compensation_status_week_3 ??
                                                ''),
                                        8.verticalSpace,
                                        rowTextComponent(
                                            'Trạng thái tuần 4',
                                            _cubit.kpiResponse[0]
                                                    .compensation_status_week_4 ??
                                                ''),
                                        8.verticalSpace,
                                        rowTextComponent(
                                            'Trạng thái tuần 5',
                                            _cubit.kpiResponse[0]
                                                    .compensation_status_week_5
                                                    .toString() ??
                                                ''),
                                      ]),
                                )
                              ],
                            ),
                          ),
                        ),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }

  Widget rowTextComponent(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 120.w,
          child: Text(
            '${title}: ',
            style: Theme.of(context).textTheme.text14W500.copyWith(),
          ),
        ),
        24.horizontalSpace,
        Expanded(
            child: Text('${value}',
                style: Theme.of(context).textTheme.body2.copyWith()))
      ],
    );
  }

  Widget _emptyWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icon/ic_no_result.png',
            height: 140.w,
            width: 140.w,
          ),
          16.verticalSpace,
          Text(
            'Không tìm thấy kết quả',
            style: Theme.of(context)
                .textTheme
                .text16w500
                .copyWith(color: AppColors.dark7),
          ),
          100.verticalSpace,
        ],
      ),
    );
  }
}
