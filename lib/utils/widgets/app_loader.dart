import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/app_colors.dart';

int noOfCallRunning = 0;

showAppLoader({bool isCancelable = false, double? loaderTopPadding}) {
  if (!(Get.isDialogOpen ?? false)) noOfCallRunning = 0;
  noOfCallRunning++;
  if (noOfCallRunning == 1) _showLoadingDialog(isCancelable, loaderTopPadding);
}

dismissAppLoader() {
  if (noOfCallRunning == 1) Get.back();
  noOfCallRunning--;
}

void _showLoadingDialog(bool isCancelable, double? loaderTopPadding) {
  Get.dialog(
    WillPopScope(
      onWillPop: () => Future.value(isCancelable),
      child: Builder(builder: (context) {
        return Material(
          color: Colors.transparent,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.center,
            child: const CircularProgressIndicator(color: AppColor.textPurple),
          ),
        );
      }),
    ),
    barrierDismissible: isCancelable,
  );
}
