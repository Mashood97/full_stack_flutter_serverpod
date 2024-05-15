import 'package:flutter/material.dart';

class AppSnackBar {
  void showErrorSnackBar(
      {required BuildContext context, required String error}) {
    ScaffoldMessenger.of(context).clearSnackBars();

    var snackBar = SnackBar(
      content: Text(
        error,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red.shade900,
      showCloseIcon: true,
      closeIconColor: Colors.white,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showSuccessSnackBar(
      {required BuildContext context, required String successMsg}) {
    ScaffoldMessenger.of(context).clearSnackBars();

    var snackBar = SnackBar(
      content: Text(
        successMsg,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.green.shade900,
      showCloseIcon: true,
      closeIconColor: Colors.white,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showSuccessDialog({
    required BuildContext context,
    required String successMsg,
    required VoidCallback actionButtonPressed,
  }) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        content: Text(
          successMsg,
        ),
        actions: [
          TextButton(
            child: const Text("Ok"),
            onPressed: actionButtonPressed,
          ),
        ],
      ),
    );
  }
}
