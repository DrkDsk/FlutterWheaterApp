import 'dart:ui';

import 'package:clima_app/core/extensions/string_extension.dart';
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
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: BlocBuilder<IACubit, IAState>(
          builder: (context, state) {

            if (state.recommendations.isEmpty) {
              return const SizedBox.shrink();
            }

            return Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade100.withOpacity(0.1),
                  borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(45), top: Radius.circular(45)),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 1,
                  )
              ),
              child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20.0, top: 10),
                        child: Image.asset("assets/icons/ia_icon.png", color: Colors.amber),
                      ),
                    ),
                    IADescriptionCard(
                      recommendations: state.recommendations,
                    ),
                    const SizedBox(height: 20),
                  ]
              ),
            );
          },
        ),
      ),
    );
  }
}

class IADescriptionCard extends StatelessWidget {
  final List<String> recommendations;

  const IADescriptionCard({super.key, required this.recommendations});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
      child: ListView.separated(
        itemCount: recommendations.length,
        separatorBuilder: (context, index) => const SizedBox(height: 15),
          itemBuilder: (context, index) {
            final text = recommendations[index];

            return Text(text.firstUppercase(),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w400)
            );
          },
      ),
    );
  }
}
