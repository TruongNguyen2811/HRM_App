import 'package:flutter/material.dart';

class SingleTapDetector extends StatelessWidget {
  final Widget child;
  final GestureTapCallback? onTap;
  final int delayTimeInMillisecond;

  const SingleTapDetector(
      {Key? key,
      required this.child,
      this.onTap,
      this.delayTimeInMillisecond = 1000})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var clickTime = 0;
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: child,
        onTap: () {
          var currentTime = DateTime.now().millisecondsSinceEpoch;
          if (currentTime - clickTime > delayTimeInMillisecond) {
            if (onTap != null) {
              onTap!();
            }
          }
          clickTime = currentTime;
        });
  }
}
