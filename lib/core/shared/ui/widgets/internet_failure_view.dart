import 'package:flutter/material.dart';

class InternetFailureView extends StatelessWidget {
  const InternetFailureView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.redAccent,
      ),
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(12),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.wifi_off, color: Colors.white),
          SizedBox(width: 8),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Sin conexión a Internet',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
