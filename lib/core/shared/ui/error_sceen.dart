import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key, required this.message, this.tryAgainHandler});

  final String message;
  final void Function()? tryAgainHandler;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final largeStyle =
        theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600);
    final widthButton = MediaQuery.of(context).size.width * 0.7;

    return Scaffold(
      backgroundColor: Colors.indigo.shade800,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //icon
                Text("Whoops!!", style: largeStyle),
                Text(message, style: largeStyle, textAlign: TextAlign.justify),

                if (tryAgainHandler != null) ...[
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: tryAgainHandler,
                    child: Container(
                      width: widthButton,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(38),
                              bottomLeft: Radius.circular(14),
                              topRight: Radius.circular(14),
                              bottomRight: Radius.circular(38)),
                          color: Colors.redAccent),
                      child: Center(
                          child: Text(
                        "Intentar de nuevo",
                        style: largeStyle,
                      )),
                    ),
                  )
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
