import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/constants/constants.dart';

class SnackbarService {
  final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  /// A method to show a [SnackBar] for successful activity
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSuccessSnackBar(
    String text,
  ) {
    return scaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        backgroundColor: AppColors.green,
        content: Text(
          text,
          style: const TextStyle(fontSize: 15),
        ),
      ),
    );
  }

  /// A method to show a [SnackBar] for successful activity
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showErrorSnackBar(
    String text,
  ) {
    return scaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          text,
          style: const TextStyle(fontSize: 15),
        ),
      ),
    );
  }
}

final snackbarService = Provider(
  ((ref) => SnackbarService()),
);
