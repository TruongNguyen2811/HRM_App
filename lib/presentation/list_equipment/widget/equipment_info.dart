import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm/configuration/colors.dart';
import 'package:hrm/model/response/list_equipment_response.dart';
import 'package:hrm/utils/custom_theme.dart';

// ignore: must_be_immutable
class EquipmentInfoWidget extends StatelessWidget {
  Equipment item;
  EquipmentInfoWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.primaryColor)),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${item.employee_name_id?[1] ?? ''}',
              style: Theme.of(context).textTheme.buttonNormal.copyWith(),
            ),
            if (item.status == 'reject') ...[
              Text(
                'Từ chối',
                style: Theme.of(context)
                    .textTheme
                    .text12w600
                    .copyWith(color: AppColors.danger1),
              ),
            ] else if (item.status == 'waiting') ...[
              Text(
                'Chờ duyệt',
                style: Theme.of(context)
                    .textTheme
                    .text12w600
                    .copyWith(color: AppColors.orange),
              ),
            ] else ...[
              Text(
                'Xác nhận',
                style: Theme.of(context)
                    .textTheme
                    .text12w600
                    .copyWith(color: AppColors.success1),
              ),
            ]
          ],
        ),
        4.verticalSpace,
        Row(
          children: [
            Text(
              'Phòng ban: ',
              style: Theme.of(context).textTheme.text14W700.copyWith(),
            ),
            Text(
              '${item.department_name_id?[1] ?? 'N/A'}',
              style: Theme.of(context).textTheme.text14W400.copyWith(),
            ),
          ],
        ),
        ListView.separated(
          padding: EdgeInsets.symmetric(vertical: 4.h),
          itemBuilder: (context, index) {
            return Row(
              children: [
                Text(
                  'Dụng cụ: ',
                  style: Theme.of(context).textTheme.text14W700.copyWith(),
                ),
                Text(
                  '${item.equipment_request_ids?[index].product_name ?? 'N/A'}',
                  style: Theme.of(context).textTheme.text14W400.copyWith(),
                ),
              ],
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 4.h,
            );
          },
          itemCount: item.equipment_request_ids?.length ?? 0,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
        ),
      ]),
    );
  }
}
