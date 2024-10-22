import 'package:flutter/material.dart';
import 'package:mvvm_advanced_sample_one/app/utils.dart';



Widget backButton({VoidCallback? onPressed, Color? color}) {
  return IconButton(
    onPressed: onPressed ?? () => navigationService.back(),
    icon: Image.asset(
      "assets/images/arrow-back.png",
      color: color,
    ),
    splashRadius: kToolbarHeight / 2,
  );
}
