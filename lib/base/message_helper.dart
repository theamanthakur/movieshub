import '../config/config.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import '../config/app_colors.dart';
import '../utils/widgets/app_text.dart';

enum MessageType { info, warn, success, error, others }

class MessageHelper {
  GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey<ScaffoldMessengerState>();

  void hide() => messengerKey.currentState?.removeCurrentSnackBar();

  void showError(String message, {Duration? duration}) => _showMessage(message, MessageType.error, duration: duration);

  void showInfo(String message, {Duration? duration}) => _showMessage(message, MessageType.info, duration: duration);

  void showWarn(String message, {Duration? duration}) => _showMessage(message, MessageType.warn, duration: duration);

  void showSuccess(String message, {Duration? duration}) => _showMessage(message, MessageType.success, duration: duration);

  void showRetryError(String message, {Duration? duration, String btnText = 'Retry', VoidCallback? onBtnPress}) =>
      _showMessage(message, MessageType.others, duration: duration, btnText: btnText, onBtnPress: onBtnPress);

  void _showMessage(String message, MessageType type, {Duration? duration, String btnText = 'Close', VoidCallback? onBtnPress}) {
    if (message.isEmpty) return;
    messengerKey.currentState?.removeCurrentSnackBar();

    duration ??= const Duration(milliseconds: 2000);
    Color? backgroundColor;
    switch (type) {
      case MessageType.info:
        backgroundColor = AppColor.blueLight;
        break;
      case MessageType.warn:
        backgroundColor = AppColor.warning;
        break;
      case MessageType.success:
        backgroundColor = AppColor.blueLight;
        break;
      case MessageType.error:
        backgroundColor = AppColor.error;
        break;
      case MessageType.others:
        break;
    }
    showToastWidget(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        margin: const EdgeInsets.symmetric(horizontal: 36),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), color: AppColor.white),
        child: Row(children: [Flexible(child: AppText.regular(message, size: 14, color: AppColor.purpleDark))]),
      ),
      animation: StyledToastAnimation.fade,
      reverseAnimation: StyledToastAnimation.fade,
      dismissOtherToast: true,
    );
    return;
  }
}
