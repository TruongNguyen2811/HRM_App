import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm/configuration/colors.dart';
import 'package:hrm/presentation/list_equipment/list_equipment_cubit.dart';
import 'package:hrm/presentation/list_equipment/list_equipment_state.dart';
import 'package:hrm/presentation/list_equipment/widget/equipment_info.dart';
import 'package:hrm/utils/custom_theme.dart';
import 'package:hrm/utils/utils.dart';
import 'package:hrm/widget/new_appbar_widget.dart';
import 'package:hrm/widget/show_loading_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListEquipmentPage extends StatefulWidget {
  const ListEquipmentPage({super.key});

  @override
  State<ListEquipmentPage> createState() => _ListEquipmentPageState();
}

class _ListEquipmentPageState extends State<ListEquipmentPage> {
  late ListEquipmentCubit _cubit;
  late RefreshController _refreshController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cubit = ListEquipmentCubit();
    _cubit.getListEquipment();
    _refreshController = RefreshController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListEquipmentCubit, ListEquipmentState>(
        bloc: _cubit,
        listener: (context, state) {
          if (state is ListEquipmentFailure) {
            Utils.showToast(context, state.messageError);
            return;
          }
        },
        builder: (BuildContext context, ListEquipmentState state) {
          return _buildPage(context, state);
        });
  }

  Widget _buildPage(BuildContext context, ListEquipmentState state) {
    return ShowLoadingWidget(
      isLoading: state is ListEquipmentLoading,
      child: Scaffold(
        backgroundColor: AppColors.newBackgroundColor,
        body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          const NewAppBarWidget(
            title: 'Danh sách đơn văn phòng phẩm',
          ),
          Expanded(
            child: SmartRefresher(
              controller: _refreshController,
              onRefresh: () {
                _cubit.getListEquipment();
                _refreshController.refreshCompleted();
              },
              child: SingleChildScrollView(
                  child: Utils.isEmptyArray(_cubit.listEquipment)
                      ? _emptyWidget()
                      : ListView.separated(
                          padding: EdgeInsets.symmetric(
                              vertical: 12.h, horizontal: 16.w),
                          itemBuilder: (context, index) {
                            return EquipmentInfoWidget(
                              item: _cubit.listEquipment[index],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 8.h,
                            );
                          },
                          itemCount: _cubit.listEquipment.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                        )),
            ),
          )
        ]),
      ),
    );
  }

  Widget _emptyWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          150.verticalSpace,
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
