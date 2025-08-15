import 'dart:ui';

import 'package:clima_app/features/ia/ui/blocs/ia_cubit.dart';
import 'package:clima_app/features/ia/ui/blocs/ia_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        child: BlocBuilder<IACubit, IAState>(
          builder: (context, state) {
            if (state.status == IAClientStatus.success) {
              return Container(
                decoration: BoxDecoration(
                    color: Colors.deepPurple.withOpacity(0.10),
                    borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(45), top: Radius.circular(45)),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 1,
                    )),
                child: Column(children: [
                  IADescriptionCard(
                    text: state.recommendation,
                  ),
                  const SizedBox(height: 20),
                ]),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class IADescriptionCard extends StatelessWidget {
  final String text;

  const IADescriptionCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(45),
              topRight: Radius.circular(45),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30))),
      child: SingleChildScrollView(
        child: Text(text,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w600)),
      ),
    );
  }
}
