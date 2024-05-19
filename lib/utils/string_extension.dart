import 'package:hrm/utils/date_extension.dart';
import 'package:hrm/utils/utils.dart';
import 'package:intl/intl.dart';

extension StringExtension on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  DateTime toDate() {
    return DateTime.parse(this).toLocal();
  }

  DateTime toDateFormat(AppDateFormat format) {
    return DateFormat(format.formatString).parse(this).toLocal();
  }

  String toDateFormatString(AppDateFormat format, AppDateFormat formatString) {
    return DateFormat(format.formatString)
        .parse(this)
        .toLocal()
        .toStringFormat(formatString);
  }

  DateTime toDateFormatToLocal(AppDateFormat format, {bool utc = false}) {
    return DateFormat(format.formatString).parse(this, utc).toLocal();
  }

  bool get emailValid => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(this);

  int? toIntMoney(int minor) {
    if (isEmpty) {
      return null;
    }
    final numberFormat = NumberFormat.simpleCurrency(
        name: '', locale: 'en', decimalDigits: minor);
    return numberFormat.parse(this).toInt();
  }

  int? toInt() {
    return int.tryParse(this);
  }

  double? toDouble() {
    return double.tryParse(this);
  }

  String unsignedRegex() {
    const vietnamese = 'aAeEoOuUiIdDyY';
    final vietnameseRegex = <RegExp>[
      RegExp(r'à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ'),
      RegExp(r'À|Á|Ạ|Ả|Ã|Â|Ầ|Ấ|Ậ|Ẩ|Ẫ|Ă|Ằ|Ắ|Ặ|Ẳ|Ẵ'),
      RegExp(r'è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ'),
      RegExp(r'È|É|Ẹ|Ẻ|Ẽ|Ê|Ề|Ế|Ệ|Ể|Ễ'),
      RegExp(r'ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ'),
      RegExp(r'Ò|Ó|Ọ|Ỏ|Õ|Ô|Ồ|Ố|Ộ|Ổ|Ỗ|Ơ|Ờ|Ớ|Ợ|Ở|Ỡ'),
      RegExp(r'ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ'),
      RegExp(r'Ù|Ú|Ụ|Ủ|Ũ|Ư|Ừ|Ứ|Ự|Ử|Ữ'),
      RegExp(r'ì|í|ị|ỉ|ĩ'),
      RegExp(r'Ì|Í|Ị|Ỉ|Ĩ'),
      RegExp(r'đ'),
      RegExp(r'Đ'),
      RegExp(r'ỳ|ý|ỵ|ỷ|ỹ'),
      RegExp(r'Ỳ|Ý|Ỵ|Ỷ|Ỹ')
    ];

    var result = this;
    for (var i = 0; i < vietnamese.length; ++i) {
      result = result.replaceAll(vietnameseRegex[i], vietnamese[i]);
    }
    return result;
  }

  DateTime parseDateWithFormat(AppDateFormat format) {
    try {
      return DateFormat(format.formatString).parse(this);
    } catch (err) {
      return DateTime.now();
    }
  }

  String? getFullPathImage() {
    if (Utils.isEmpty(this)) return null;
    return Uri.encodeFull("");
  }

  bool isPhoneNoValid() {
    if (isEmpty) return false;
    final regExp = RegExp(r'(((^(\+84|84|0|0084){1})(3|5|7|8|9))+([0-9]{8})$)');
    return regExp.hasMatch(this);
  }
}
