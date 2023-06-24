import 'package:flutter_platform_alert/flutter_platform_alert.dart';

class CoreUtils {
  const CoreUtils._();

  static Future<void> showErrorAlert({
    required String message,
  }) async {
    await FlutterPlatformAlert.playAlertSound();
    await FlutterPlatformAlert.showAlert(
      windowTitle: 'Error',
      text: message,
      iconStyle: IconStyle.error,
    );
  }
}
