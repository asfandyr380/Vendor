import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

showSnackMsg(BuildContext ctx, String msg, String errMsg, bool val) {
  if (val)
    showTopSnackBar(
      ctx,
      CustomSnackBar.success(message: '$msg'),
    );
  else
    showTopSnackBar(
      ctx,
      CustomSnackBar.error(message: '$errMsg'),
    );
}
