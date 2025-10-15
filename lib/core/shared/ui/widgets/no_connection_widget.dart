import 'package:flutter/material.dart';

class InternetFailureWidget extends StatelessWidget {
  const InternetFailureWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          color: Colors.redAccent,
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
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
