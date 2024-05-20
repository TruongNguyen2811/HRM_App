import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm/configuration/colors.dart';
import 'package:hrm/model/response/contract_response.dart';
import 'package:hrm/utils/custom_theme.dart';
import 'package:hrm/utils/date_extension.dart';
import 'package:hrm/utils/string_extension.dart';

class ContractWidget extends StatelessWidget {
  final ContractInfo item;
  const ContractWidget({super.key, required this.item});

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
              '${item.employee_id?[1] ?? ''}',
              style: Theme.of(context).textTheme.buttonNormal.copyWith(),
            ),
            if (item.state == 'close') ...[
              Text(
                'Hết hạn',
                style: Theme.of(context)
                    .textTheme
                    .text12w600
                    .copyWith(color: AppColors.danger1),
              ),
            ] else if (item.state == 'draft') ...[
              Text(
                'Mới',
                style: Theme.of(context)
                    .textTheme
                    .text12w600
                    .copyWith(color: AppColors.blue),
              ),
            ] else if (item.state == 'open') ...[
              Text(
                'Đang chạy',
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Mã hợp đồng: ',
              style: Theme.of(context).textTheme.text14W700.copyWith(),
            ),
            Text(
              '${item.name ?? 'NA'}',
              style: Theme.of(context).textTheme.text14W400.copyWith(),
            ),
          ],
        ),
        4.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Mã nhân viên: ',
              style: Theme.of(context).textTheme.text14W700.copyWith(),
            ),
            Text(
              "${item.employee_code ?? 'N/A'}",
              style: Theme.of(context).textTheme.text14W400.copyWith(),
            ),
          ],
        ),
        4.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Công ty: ',
              style: Theme.of(context).textTheme.text14W700.copyWith(),
            ),
            Expanded(
              child: Text(
                "${item.company_id?[1] ?? ''}",
                maxLines: 4,
                style: Theme.of(context).textTheme.text14W400.copyWith(),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
        4.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Phòng ban: ',
              style: Theme.of(context).textTheme.text14W700.copyWith(),
            ),
            Text(
              "${item.department_id?[1] ?? ''}",
              style: Theme.of(context).textTheme.text14W400.copyWith(),
            ),
          ],
        ),
        4.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Chức vụ: ',
              style: Theme.of(context).textTheme.text14W700.copyWith(),
            ),
            Text(
              "${item.job_id?[1] ?? ''}",
              style: Theme.of(context).textTheme.text14W400.copyWith(),
            ),
          ],
        ),
        4.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Loại hợp đồng: ',
              style: Theme.of(context).textTheme.text14W700.copyWith(),
            ),
            Text(
              "${item.contract_type_id?[1] ?? ''}",
              style: Theme.of(context).textTheme.text14W400.copyWith(),
            ),
          ],
        ),
        4.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Giờ làm việc/tuần: ',
              style: Theme.of(context).textTheme.text14W700.copyWith(),
            ),
            Text(
              "${item.resource_calendar_id?[1] ?? ''}",
              style: Theme.of(context).textTheme.text14W400.copyWith(),
            ),
          ],
        ),
        4.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Thời gian bắt đầu: ',
              style: Theme.of(context).textTheme.text14W700.copyWith(),
            ),
            Text(
              "${item.date_start?.toDateFormatString(AppDateFormat.yearMonthDay, AppDateFormat.dayMonthYear) ?? ''}",
              style: Theme.of(context).textTheme.text14W400.copyWith(),
            ),
          ],
        ),
        4.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Thời gian kết thúc: ',
              style: Theme.of(context).textTheme.text14W700.copyWith(),
            ),
            Text(
              "${item.date_end?.toDateFormatString(AppDateFormat.yearMonthDay, AppDateFormat.dayMonthYear) ?? ''}",
              // '${item.date_to}',
              style: Theme.of(context).textTheme.text14W400.copyWith(),
            ),
          ],
        ),
        4.verticalSpace,
      ]),
    );
  }
}
