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
        child: SizedBox(
          height: 300,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.pinkAccent.withOpacity(0.10),
                borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(45), top: Radius.circular(45)),
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 1,
                )),
            child: Stack(
              children: [
                const Positioned(
                  top: 110,
                  left: 0,
                  right: 0,
                  child: IADescriptionCard(
                    color: Colors.transparent,
                  )
                ),
                Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: IADescriptionCard(
                      isTheFirstOne: true,
                      color: Colors.deepPurple.shade400.withOpacity(0.20),
                    )
                ),
            ]),
          ),
        ),
      ),
    );
  }
}

class IADescriptionCard extends StatelessWidget {

  final bool isTheFirstOne;

  final Color color;

  const IADescriptionCard({super.key, required this.color, this.isTheFirstOne = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 10),
      decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(45))),
      child: Padding(
        padding: isTheFirstOne ? EdgeInsets.zero : const EdgeInsets.only(top: 20.0),
        child: const Text(
            "Plants and trees"
            "Plants and trees"
            "Plants and trees"
            "Plants and trees"
            "Plants and trees"
            "Plants and trees"
            "Plants and trees"
            "Plants and trees"
            "Plants and trees",
            style: TextStyle(
                color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
