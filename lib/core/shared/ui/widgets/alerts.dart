import 'package:flutter/material.dart';

class Alerts {
  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
  }

  static void showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const AlertDialog(
        title: Text('Sin conexión'),
        content: Text('Parece que has perdido la conexión a Internet.'),
      ),
    );
  }
}
