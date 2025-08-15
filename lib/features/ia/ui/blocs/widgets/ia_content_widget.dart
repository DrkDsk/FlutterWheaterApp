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
          height: 320,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                bottom: 5,
                right: 0,
                left: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.purpleAccent.withOpacity(0.15),
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(45),
                      top: Radius.circular(45)
                    ),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 1,
                    )
                  ),
                  child: const Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Text(
                              "data data data data data data"
                                  "data data data data data"
                                  "data data data data data data"
                                  "data data data data data"
                                  "data data data data "
                                  "data2 data data ",
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            ),

                          ],
                        ),
                      ),
                      PlantsCard(),
                    ],
                  ),
                )
              ),
              //const Positioned(bottom: 40, right: 0, left: 0, child: PlantsCard()),
            ],
          ),
        ),
      ),
    );
  }
}

class SeedCard extends StatelessWidget {
  const SeedCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
          color: Colors.brown.shade900,
          borderRadius: const BorderRadius.all(Radius.circular(45))),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50),
          Text("Seeds",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w600)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomPlantsColumn(
                color: Colors.green,
                figures: '3021',
                headings: 'Sown',
                icon: Icons.arrow_drop_down,
              ),
              CustomPlantsColumn(
                color: Colors.brown,
                figures: '131',
                headings: 'Harvest',
                icon: Icons.arrow_drop_up,
              )
            ],
          )
        ],
      ),
    );
  }
}

class PlantsCard extends StatelessWidget {
  const PlantsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
          color: Colors.brown.shade700,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(45),
              bottomRight: Radius.circular(45))),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 40),
          Text("Plants and trees",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w600)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomPlantsColumn(
                color: Colors.green,
                figures: '3021',
                headings: 'In Growing',
                icon: Icons.arrow_drop_down,
              ),
              CustomPlantsColumn(
                color: Colors.brown,
                figures: '131',
                headings: 'Custom by Man',
                icon: Icons.arrow_drop_up,
              )
            ],
          )
        ],
      ),
    );
  }
}

class CustomPlantsColumn extends StatelessWidget {
  final String headings;
  final String figures;
  final Color color;
  final IconData icon;

  const CustomPlantsColumn(
      {super.key,
      required this.headings,
      required this.figures,
      required this.color,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          headings,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Container(
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              child: Icon(icon, size: 14, color: Colors.white),
            ),
            const SizedBox(width: 10),
            Text(
              figures,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w500),
            )
          ],
        )
      ],
    );
  }
}
