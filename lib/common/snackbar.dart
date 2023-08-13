import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

showToast(String text) => SmartDialog.showToast(
      text,
      displayTime: const Duration(seconds: 3),
    );

showLoading() => SmartDialog.showLoading();

dismiss() => SmartDialog.dismiss();
