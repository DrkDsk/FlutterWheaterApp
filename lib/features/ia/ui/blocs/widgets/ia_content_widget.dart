import 'package:flutter/material.dart';

class IAContentWidget extends StatelessWidget {
  const IAContentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(34),
        color: Colors.red.shade200,
        boxShadow: const [
          BoxShadow(
              color: Colors.grey,
              blurRadius: 4,
              offset: Offset(0, 3)
          )
        ]
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 4,
                          offset: Offset(0, 3)
                      )
                    ]
                ),
                child: const Text(
                      "data data data data data data"
                      "data data data data data"
                      "data data data data data data"
                      "data data data data data"
                      "data data data data "
                      "data2 data data ",
                  style: TextStyle(
                      color: Colors.black
                  ),
                )
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: const Text(
                  "data data data data data data"
                  "data data data data data"
                  "data data data data "
                  "data2 data data "),
            )
          ],
        ),
      ),
    );
  }
}