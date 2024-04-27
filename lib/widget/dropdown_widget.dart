import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm/configuration/colors.dart';
import 'package:hrm/utils/custom_theme.dart';
import 'package:hrm/widget/single_tap.dart';
import '../utils/utils.dart';

class DropDownFieldWidget extends StatelessWidget {
  final String? titleText;
  final String? value;
  final bool require;
  final String? hintText;
  final bool showIcon;
  final bool isEnable;
  final String? icon;
  final ValueChanged<String?>? onClick;
  final String? errorText;
  final Color? iconColor;
  final TextStyle? textStyle;
  final double borderRadius;

  const DropDownFieldWidget(
      {super.key,
      this.titleText,
      this.value,
      this.require = false,
      this.hintText,
      this.isEnable = true,
      this.showIcon = true,
      this.errorText,
      this.icon,
      this.onClick,
      this.iconColor,
      this.borderRadius = 8,
      this.textStyle});

  @override
  Widget build(BuildContext context) {
    return _buildInputName(context);
  }

  Widget _buildInputName(BuildContext context) {
    return SingleTapDetector(
      onTap: () {
        if (!isEnable) return;
        onClick?.call(value);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!Utils.isEmpty(titleText))
            Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: _buildLabelRequireWidget(context, titleText ?? ''),
            ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: showIcon ? 12.h : 14.h, horizontal: 16.w),
            decoration: BoxDecoration(
                color: isEnable ? AppColors.white : AppColors.dark12,
                border: Border.all(width: 1.h, color: AppColors.dark9),
                borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    !Utils.isEmpty(value) ? (value ?? '') : (hintText ?? ''),
                    style: textStyle ??
                        Theme.of(context).textTheme.subTitle.copyWith(
                            color: Utils.isEmpty(value) || !isEnable
                                ? AppColors.enableButton
                                : AppColors.dark1,
                            height: 0),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (showIcon) 15.horizontalSpace,
                if (showIcon)
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: 24.w,
                    color: iconColor,
                  )
              ],
            ),
          ),
          if (!Utils.isEmpty(errorText))
            Container(
                padding:
                    const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 18.0),
                child: Text(
                  errorText ?? "",
                  maxLines: 2,
                  style: Theme.of(context).textTheme.textRegular.copyWith(
                        color: AppColors.darkRed,
                      ),
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                ))
        ],
      ),
    );
  }

  _buildLabelRequireWidget(BuildContext context, String label) => RichText(
        textAlign: TextAlign.start,
        text: TextSpan(
            text: label,
            style: Theme.of(context)
                .textTheme
                .text14W400
                .copyWith(color: AppColors.dark3),
            children: [
              if (require)
                TextSpan(
                    text: " *",
                    style: Theme.of(context)
                        .textTheme
                        .body2Bold
                        .copyWith(color: AppColors.darkger1)),
            ]),
      );
}

class CustomDropDown<T> extends StatefulWidget {
  final List<customDropdownMenuItem<T?>> items;

  final ValueChanged<T?> onChanged;
  final String hintText;
  final double? borderRadius;
  final double maxListHeight;
  final double borderWidth;
  final int defaultSelectedIndex;
  final TextStyle? hintStyle;
  final Color? backgroundColor;
  final Widget? itemSelected;
  final bool enabled;
  final Color? iconColor;
  final bool? isBorder;

  const CustomDropDown({
    required this.items,
    required this.onChanged,
    this.hintText = "",
    this.borderRadius,
    this.borderWidth = 1,
    this.maxListHeight = 150,
    this.defaultSelectedIndex = -1,
    Key? key,
    this.enabled = true,
    this.backgroundColor,
    this.hintStyle,
    this.itemSelected,
    this.iconColor,
    this.isBorder = true,
  }) : super(key: key);

  @override
  _CustomDropDownState<T> createState() => _CustomDropDownState<T>();
}

class _CustomDropDownState<T> extends State<CustomDropDown<T>>
    with WidgetsBindingObserver {
  bool _isOpen = false, _isAnyItemSelected = false, _isReverse = false;
  late OverlayEntry _overlayEntry;
  late RenderBox? _renderBox;
  Widget? _itemSelected;
  late Offset dropDownOffset;
  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          dropDownOffset = getOffset();
        });
      }
      if (widget.defaultSelectedIndex > -1) {
        if (widget.defaultSelectedIndex < widget.items.length) {
          if (mounted) {
            setState(() {
              _isAnyItemSelected = true;
              _itemSelected = widget.items[widget.defaultSelectedIndex];
              widget.onChanged
                  .call(widget.items[widget.defaultSelectedIndex].value);
            });
          }
        }
      }
    });
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  void _addOverlay() {
    if (mounted) {
      setState(() {
        _isOpen = true;
      });
    }

    _overlayEntry = _createOverlayEntry();
    Overlay.of(context)!.insert(_overlayEntry);
  }

  void _removeOverlay() {
    if (mounted) {
      setState(() {
        _isOpen = false;
      });
      _overlayEntry.remove();
    }
  }

  @override
  dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  OverlayEntry _createOverlayEntry() {
    _renderBox = context.findRenderObject() as RenderBox?;

    var size = _renderBox!.size;

    dropDownOffset = getOffset();

    return OverlayEntry(
        maintainState: false,
        builder: (context) => Align(
              alignment: Alignment.center,
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: dropDownOffset,
                child: SizedBox(
                  height: widget.maxListHeight,
                  width: size.width,
                  child: SingleChildScrollView(
                    child: Container(
                      constraints: BoxConstraints(
                          maxHeight: widget.maxListHeight,
                          maxWidth: size.width),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(widget.borderRadius ?? 8.r),
                        ),
                        child: Material(
                          elevation: 0,
                          // color: Colors.white,
                          child: ListView(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            children: widget.items
                                .map((item) => InkWell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: item.child,
                                      ),
                                      onTap: () {
                                        if (mounted) {
                                          setState(() {
                                            _isAnyItemSelected = true;
                                            _itemSelected = item.child;
                                            _removeOverlay();
                                            widget.onChanged.call(item.value);
                                            // widget.onChanged.call(item.value);
                                            // widget.onC
                                            // widget.onChanged(item.value);
                                          });
                                        }
                                      },
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }

  Offset getOffset() {
    RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    double y = renderBox!.localToGlobal(Offset.zero).dy;
    double spaceAvailable = _getAvailableSpace(y + renderBox.size.height);
    if (spaceAvailable > widget.maxListHeight) {
      _isReverse = false;
      return Offset(0, renderBox.size.height);
    } else {
      _isReverse = true;
      return Offset(
          0,
          renderBox.size.height -
              (widget.maxListHeight + renderBox.size.height));
    }
  }

  double _getAvailableSpace(double offsetY) {
    double safePaddingTop = MediaQuery.of(context).padding.top;
    double safePaddingBottom = MediaQuery.of(context).padding.bottom;

    double screenHeight =
        MediaQuery.of(context).size.height - safePaddingBottom - safePaddingTop;

    return screenHeight - offsetY;
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: widget.enabled
            ? () {
                _isOpen ? _removeOverlay() : _addOverlay();
              }
            : null,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: _getDecoration(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                flex: 3,
                child: _isAnyItemSelected
                    ? Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: widget.itemSelected!,
                      )
                    : Padding(
                        padding:
                            const EdgeInsets.only(left: 4.0), // change it here
                        child: Text(
                          widget.hintText,
                          style: widget.hintStyle ??
                              Theme.of(context)
                                  .textTheme
                                  .subTitle
                                  .copyWith(color: AppColors.dark5, height: 0),
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                        ),
                      ),
              ),
              Flexible(
                flex: 1,
                child: Icon(
                  Icons.keyboard_arrow_down_outlined,
                  size: 24.w,
                  color: widget.iconColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Decoration? _getDecoration() {
    return BoxDecoration(
        color: widget.backgroundColor ?? AppColors.white,
        boxShadow: widget.isBorder == true
            ? []
            : [
                BoxShadow(
                  color: AppColors.dark12,
                  blurRadius: 10,
                )
              ],
        border: widget.isBorder == true
            ? Border.all(width: 1.h, color: AppColors.dark9)
            : null,
        borderRadius:
            BorderRadius.all(Radius.circular(widget.borderRadius ?? 8.r)));
    // if (_isOpen && !_isReverse) {
    //   return BoxDecoration(
    //       borderRadius: BorderRadius.only(
    //           topLeft: Radius.circular(widget.borderRadius),
    //           topRight: Radius.circular(
    //             widget.borderRadius,
    //           )));
    // } else if (_isOpen && _isReverse) {
    //   return BoxDecoration(
    //       borderRadius: BorderRadius.only(
    //           bottomLeft: Radius.circular(widget.borderRadius),
    //           bottomRight: Radius.circular(
    //             widget.borderRadius,
    //           )));
    // } else if (!_isOpen) {
    //   return BoxDecoration(
    //       borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)));
    // }
    // return null;
  }
}

class customDropdownMenuItem<T> extends StatelessWidget {
  final T value;
  final Widget child;

  const customDropdownMenuItem(
      {super.key, required this.value, required this.child});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
