import 'package:collection/collection.dart';
// ignore: implementation_imports
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm/configuration/colors.dart';
import 'package:hrm/utils/custom_theme.dart';
import 'package:hrm/widget/single_tap.dart';

import '../utils/navigation_utils.dart';
import '../utils/utils.dart';
import 'button_widget.dart';
import 'text_field_widget.dart';

typedef SearchListItemTitleBuilder<T> = String Function(T);

class SearchListSimpleItemPopup<T> extends StatefulWidget {
  final List<T> listData;
  final List<int>? defaultIndexes;
  final String title;
  final String? hintText;
  final Function(List<int> selectedIndexes) onSelect;
  final bool? showSearch;
  final bool isSingleChoice;
  final SearchListItemTitleBuilder<T> builder;
  final bool? isShowButton;

  const SearchListSimpleItemPopup({
    Key? key,
    required this.listData,
    this.defaultIndexes,
    this.hintText,
    required this.onSelect,
    required this.builder,
    required this.title,
    this.isSingleChoice = true,
    this.showSearch = true,
    this.isShowButton = true,
  }) : super(key: key);

  @override
  State<SearchListSimpleItemPopup> createState() =>
      _SearchListSimpleItemPopupState<T>();
}

class _SearchListSimpleItemPopupState<T>
    extends State<SearchListSimpleItemPopup<T>> {
  List<T> listDataOriginal = [];
  List<T> listData = [];
  final TextEditingController controller = TextEditingController();
  List<int> selectedIndexes = [];

  late ScrollController scrollController;

  @override
  void initState() {
    listDataOriginal = widget.listData;
    listData = widget.listData;
    selectedIndexes = widget.defaultIndexes ?? [];
    int currentIndex = widget.defaultIndexes?.firstOrNull ?? 0;
    if (currentIndex < 0) {
      currentIndex = 0;
    }
    // scroll to row by row height and separator height
    scrollController =
        ScrollController(initialScrollOffset: 36.h * currentIndex);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void updateListData(List<T> listData) {
    listDataOriginal = listData;
    this.listData = listData;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(68.h),
        child: Column(
          children: [
            8.verticalSpace,
            Container(
              height: 5.h,
              width: 48.w,
              decoration: BoxDecoration(
                color: AppColors.dark300,
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
            AppBar(
              title: Text(
                widget.title,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                maxLines: 1,
                style: Theme.of(context)
                    .textTheme
                    .labelHighLight
                    .copyWith(color: AppColors.neuturalText),
              ),
              elevation: 0,
              centerTitle: true,
              leading: SizedBox(),
              actions: [
                SingleTapDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                      padding: EdgeInsets.only(
                          right: 20.w, bottom: 5, top: 5, left: 5),
                      child: Icon(
                        Icons.close,
                        size: 20.w,
                      )),
                )
              ],
              backgroundColor: AppColors.white,
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (widget.showSearch == true)
              TextFieldWidget(
                autoFocus: false,
                controller: controller,
                // icon: '',
                textInputAction: TextInputAction.search,
                hintText: widget.hintText ?? 'Tìm kiếm',
                onChanged: (text) => _searchKeyword(text?.trim()),
              ),
            Expanded(
              child: Utils.isEmpty(listData) && !Utils.isEmpty(listDataOriginal)
                  ? Center(child: Text('Không có dữ liệu'))
                  : Scrollbar(
                      child: ListView.separated(
                        padding: EdgeInsets.only(top: 4.h),
                        controller: scrollController,
                        shrinkWrap: true,
                        itemCount: listData.length,
                        itemBuilder: (context, index) {
                          T item = listData[index];
                          return GestureDetector(
                            // behavior: HitTestBehavior.translucent,
                            onTap: () {
                              int index = listDataOriginal.indexOf(item);
                              if (selectedIndexes.contains(index)) {
                                selectedIndexes.remove(index);
                              } else {
                                if (widget.isSingleChoice) {
                                  selectedIndexes = [index];
                                } else {
                                  selectedIndexes.add(index);
                                }
                              }
                              // NavigationUtils.popPage(context);
                              setState(() {});
                              if (widget.isShowButton == false) {
                                print('select selectedIndexes');
                                widget.onSelect(selectedIndexes);
                                Navigator.of(context).pop();
                                // NavigationUtils.popPage(context);
                              }
                            },
                            child: Container(
                              height: 36.h,
                              decoration: BoxDecoration(
                                color: selectedIndexes.isNotEmpty &&
                                        selectedIndexes.contains(
                                            listDataOriginal.indexOf(item))
                                    ? AppColors.primary50
                                    : AppColors.white,
                                border: selectedIndexes.isNotEmpty &&
                                        selectedIndexes.contains(
                                            listDataOriginal.indexOf(item))
                                    ? Border.all(
                                        width: 1.w,
                                        color: AppColors.borderColor)
                                    : null,
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 8.h, horizontal: 8.w),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Text(
                                      widget.builder(item),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .body2
                                          .copyWith(
                                            color: (selectedIndexes
                                                        .isNotEmpty &&
                                                    selectedIndexes.contains(
                                                        listDataOriginal
                                                            .indexOf(item)))
                                                ? AppColors.dark1
                                                : AppColors.dark1,
                                            height: 0,
                                          ),
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Visibility(
                                      visible: selectedIndexes.isNotEmpty &&
                                          selectedIndexes.contains(
                                              listDataOriginal.indexOf(item)),
                                      child: Icon(
                                        CupertinoIcons.checkmark_alt,
                                        size: 20.w,
                                        color: AppColors.primaryMain,
                                      ))
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => Container(
                            // height: 1,
                            // color: AppColors.lightestGray,
                            ),
                      ),
                    ),
            ),
            if (widget.isShowButton == true) ...[
              if (!Utils.isEmpty(listData))
                ButtonWidget(
                    title: 'Chọn',
                    onPressed: () {
                      widget.onSelect(selectedIndexes);
                      NavigationUtils.popPage(context);
                    }),
              10.verticalSpace,
            ],
          ],
        ),
      ),
    );
  }

  void _searchKeyword(String? name) {
    if (Utils.isEmpty(name)) {
      listData = widget.listData;
    }
    listData = widget.listData
        .where(
          (e) =>
              Utils.convertVNtoText(widget.builder(e)).toLowerCase().contains(
                    Utils.convertVNtoText(name!).toLowerCase(),
                  ),
        )
        .toList();
    setState(() {});
  }
}
