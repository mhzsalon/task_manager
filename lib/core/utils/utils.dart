// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:taskmanager/core/common_widgets/top_snackbar_widget.dart';
import 'package:taskmanager/core/enums/messageType_enum.dart';
import 'package:taskmanager/core/resources/app_colors.dart';
import 'dart:ui' as ui;

import 'package:taskmanager/core/utils/dimens.dart';

// ignore: deprecated_member_use
MediaQueryData mediaQueryData = MediaQueryData.fromView(ui.window);

const num DESIGN_WIDTH = 375;
const num DESIGN_HEIGHT = 812;
const num DESIGN_STATUS_BAR = 0;

class Utils {
  static double getScalingFactor(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    if (width >= 800) {
      return scalingFactor_800sw;
    } else if (width >= 600) {
      return scalingFactor600sw;
    } else if (width < 600 && width > 320) {
      return scalingFactorDefault;
    } else {
      return scalingFactor_320sw;
    }
  }

  ///This method is used to get device viewport width.
  get width {
    return mediaQueryData.size.width;
  }

  get height {
    return mediaQueryData.size.height;
  }

  ///This method is used to get device viewport height.
  get _height {
    num statusBar = mediaQueryData.viewPadding.top;
    num bottomBar = mediaQueryData.viewPadding.bottom;
    num screenHeight = mediaQueryData.size.height - statusBar - bottomBar;
    return screenHeight;
  }

  ///This method is used to set padding/margin (for the left and Right side) & width of the screen or widget according to the Viewport width.
  double getHorizontalSize(double px) {
    return ((px * width) / DESIGN_WIDTH);
  }

  ///This method is used to set padding/margin (for the top and bottom side) & height of the screen or widget according to the Viewport height.
  double getVerticalSize(double px) {
    return ((px * _height) / (DESIGN_HEIGHT - DESIGN_STATUS_BAR));
  }

  void showSnackBar(BuildContext context, MsgType msgType, String message) {
    showTopSnackBar(
      Overlay.of(context),
      context,
      message,
      msgType == MsgType.success
          ? AppColors.success
          : msgType == MsgType.error
          ? AppColors.error
          : AppColors.black,
      msgType == MsgType.success
          ? Icons.check_circle_outline_rounded
          : msgType == MsgType.error
          ? Icons.error_outline_rounded
          : Icons.warning_amber_rounded,
    );
  }

  static String? validate(String? value, {field, String? confirmPw}) {
    value ??= "";
    if (value.isEmpty) {
      if (field == "email") {
        return 'Enter your email address';
      } else if (field == "password" || field == "confirmPassword") {
        return 'Enter your password';
      } else if (field == "name") {
        return 'Enter your full name';
      } else if (field == "task") {
        return 'Please enter task name';
      } else if (field == "desc") {
        return 'Please enter task description';
      }
    } else {
      if (field == "password") {
        if (value.length < 6) {
          return "Password must be at least 6 characters";
        }
      }
      if (field == "confirmPassword") {
        if (value.length < 6) {
          return "Password must be at least 6 characters";
        } else if (value != confirmPw) {
          return "Password does not match.";
        }
      }
      if (field == "email") {
        String emailPattern =
            r'^[a-zA-Z0-9]+([._%+-]?[a-zA-Z0-9]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z]{2,})+$';
        RegExp regex = RegExp(emailPattern);
        if (!regex.hasMatch(value)) {
          return "Please enter a valid email address";
        }
      }
    }
    return null;
  }
}
