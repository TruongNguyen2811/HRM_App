import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

class NavigationUtils {
  static Future pushAndRemoveUtilPage(BuildContext context, Widget widget) {
    return Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => widget),
        (Route<dynamic> route) => false);
  }

  static Future pushAndRemoveUtilKeepFirstPage(
      BuildContext context, Widget widget) {
    return Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => widget),
        ModalRoute.withName(Navigator.defaultRouteName));
  }

  static void popToFirst(BuildContext context) {
    return Navigator.of(context)
        .popUntil((Route<dynamic> route) => route.isFirst);
  }

  static void popUntilScreen(BuildContext context, Type screen) {
    Navigator.popUntil(context, ModalRoute.withName(screen.toString()));
  }

  static void popUntilPage(BuildContext context,
      {String? pageName, dynamic data}) {
    if (pageName == null) {
      return popToFirst(context);
    }
    return Navigator.of(context).popUntil((route) {
      if (route.settings.name == pageName) {
        if (route.settings.arguments is Map) {
          (route.settings.arguments as Map)['data'] = data;
        }
        return true;
      }
      return false;
    });
  }

  void popByTime(BuildContext context, {dynamic result}) async {
    Navigator.of(context).pop(result);
  }

  static void popUtil(BuildContext context) {
    return Navigator.of(context).popUntil((Route<dynamic> route) => false);
  }

  static void popDialog(BuildContext context) {
    return Navigator.of(context, rootNavigator: true).pop('dialog');
  }

  static Future navigatePage(BuildContext context, Widget widget,
      {Object? argument}) async {
    return Navigator.of(context).push(MaterialPageRoute(
        settings: RouteSettings(
            name: widget.runtimeType.toString(), arguments: argument),
        builder: (context) => widget));
  }

  static void popPage(
    BuildContext context, {
    dynamic result,
  }) async {
    return Navigator.of(context).pop(result);
  }

  static Future rootNavigatePage(BuildContext context, Widget widget,
      {bool isFirst = false}) async {
    return Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
        settings: RouteSettings(name: widget.runtimeType.toString()),
        builder: (context) => widget));
  }

  static Future rootNavigatePageWithArguments(
      BuildContext context, Widget widget,
      {Object? argument}) {
    return Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
        settings: RouteSettings(
            name: widget.runtimeType.toString(), arguments: argument),
        builder: (context) => widget));
  }

  static Future rootNavigatePageWithName(
      BuildContext context, Widget widget, String pageName,
      {Object? argument}) {
    return Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
        builder: (context) => widget,
        settings: RouteSettings(name: pageName, arguments: argument)));
  }

  static Future replacePage(BuildContext context, Widget widget) {
    return Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => widget));
  }

  // static Future<bool> navigatorPopWebView(
  //     WebViewController? webViewController) async {
  //   if (await webViewController!.canGoBack()) {
  //     webViewController.goBack();
  //     return false;
  //   }
  //   return true;
  // }
}
