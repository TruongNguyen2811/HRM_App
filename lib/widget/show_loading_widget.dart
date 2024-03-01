import 'package:flutter/material.dart';

import 'loading_widget.dart';

class ShowLoadingWidget extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final Color? overlayColor;
  final Widget? overlayItem;

  const ShowLoadingWidget(
      {Key? key,
      required this.child,
      this.isLoading = false,
      this.overlayColor,
      this.overlayItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
      },
      child: Stack(
        children: [
          child,
          Visibility(
            visible: isLoading,
            child: LoadingWidget(
              overlayColor: overlayColor,
              overlayItem: overlayItem,
            ),
          ),
        ],
      ),
    );
  }
}
