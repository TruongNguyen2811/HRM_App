import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm/configuration/colors.dart';
import 'package:hrm/presentation/account/contract_info/contract_cubit.dart';
import 'package:hrm/presentation/account/contract_info/contract_state.dart';
import 'package:hrm/presentation/account/contract_info/widget/contract_widget.dart';
import 'package:hrm/utils/utils.dart';
import 'package:hrm/widget/new_appbar_widget.dart';
import 'package:hrm/widget/show_loading_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ContractPage extends StatefulWidget {
  const ContractPage({super.key});

  @override
  State<ContractPage> createState() => _ContractPageState();
}

class _ContractPageState extends State<ContractPage> {
  late ContractCubit _cubit;
  late RefreshController _refreshController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cubit = ContractCubit();
    _cubit.getListContract();
    _refreshController = RefreshController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContractCubit, ContractState>(
        bloc: _cubit,
        listener: (context, state) {
          if (state is ContractFailure) {
            Utils.showToast(context, state.messageError);
            return;
          }
        },
        builder: (BuildContext context, ContractState state) {
          return _buildPage(context, state);
        });
  }

  Widget _buildPage(BuildContext context, ContractState state) {
    return ShowLoadingWidget(
      isLoading: state is ContractLoading,
      child: Scaffold(
        backgroundColor: AppColors.newBackgroundColor,
        body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          const NewAppBarWidget(
            title: 'Quản lý hợp đồng',
          ),
          Expanded(
            child: SmartRefresher(
              controller: _refreshController,
              onRefresh: () {
                _cubit.getListContract();
                _refreshController.refreshCompleted();
              },
              child: SingleChildScrollView(
                  child: ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                itemBuilder: (context, index) {
                  return ContractWidget(
                    item: _cubit.listContract[index],
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 8.h,
                  );
                },
                itemCount: _cubit.listContract.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
              )),
            ),
          )
        ]),
      ),
    );
  }
}
