import 'package:flutter/material.dart';

class IASuggestionButton extends StatelessWidget {
  const IASuggestionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 20.0, top: 10),
        child: Image.asset(
          "assets/icons/ia_icon.png",
          color: Colors.amber,
        ),
      ),
    );
  }
}
