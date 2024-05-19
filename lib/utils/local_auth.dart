import 'package:flutter/services.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthApi {
  static final _auth = LocalAuthentication();

  static Future<bool> hasBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      return false;
    }
  }

  static Future<List<BiometricType>> getBiometrics() async {
    try {
      return await _auth.getAvailableBiometrics();
    } catch (e) {
      return <BiometricType>[];
    }
  }

  static Future<bool> authenticate() async {
    final isAvail = await hasBiometrics();
    if (!isAvail) return false;

    try {
      return await _auth.authenticate(
        biometricOnly: true,
        useErrorDialogs: true,
        stickyAuth: false,
        iOSAuthStrings: const IOSAuthMessages(
            cancelButton: "Bỏ qua",
            goToSettingsButton: "Cài đặt",
            goToSettingsDescription:
                "Thiết bị của bạn chưa cài đặt vân tay hoặc khuôn mặt"),
        androidAuthStrings: const AndroidAuthMessages(
            cancelButton: "Bỏ qua",
            signInTitle: "Yêu cầu đăng nhập",
            biometricSuccess: "Quét thành công",
            biometricNotRecognized: "Quét không đúng",
            biometricHint: "",
            goToSettingsButton: "Cài đặt",
            goToSettingsDescription:
                "Thiết bị của bạn chưa cài đặt vân tay hoặc khuôn mặt",
            deviceCredentialsRequiredTitle: "abc",
            deviceCredentialsSetupDescription: "abc"),
        localizedReason: 'Vui lòng quét sinh trắc để đăng nhập ',
      );
    } catch (e) {
      return false;
    }
  }
}
