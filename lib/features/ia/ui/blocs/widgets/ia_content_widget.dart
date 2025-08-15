import 'dart:ui';

import 'package:flutter/material.dart';

class IAContentWidget extends StatelessWidget {
  const IAContentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.pinkAccent.withOpacity(0.10),
              borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(45), top: Radius.circular(45)),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1,
              )
          ),
          child: Column(children: [
            IADescriptionCard(
              text: "Ideal para ropa ligera pero lleva paraguas por si llueve.",
              color: Colors.deepPurple.shade200.withOpacity(0.10),
            ),
            IADescriptionCard(
              text: "Hoy hará calor y húmedo, con una ligera brisa",
              color: Colors.grey.shade400.withOpacity(0.20),
            ),
          ]),
        ),
      ),
    );
  }
}

class IADescriptionCard extends StatelessWidget {
  final Color color;
  final String text;

  const IADescriptionCard(
      {super.key,
      required this.color,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 10),
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w600
            )
          ),
      ),
    );
  }
}
