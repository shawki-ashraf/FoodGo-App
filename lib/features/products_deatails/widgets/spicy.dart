import 'package:flutter/material.dart';

class SpicyPortionSection extends StatelessWidget {
  final double spicyLevel;
  final int portion;
  final ValueChanged<double> onSpicyChanged;
  final ValueChanged<int> onPortionChanged;

  const SpicyPortionSection({
    required this.spicyLevel, required this.portion, required this.onSpicyChanged, required this.onPortionChanged, super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        /// ================= Spicy =================
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text("Spicy"),

              Slider(
                value: spicyLevel,
                onChanged: onSpicyChanged,
              ),
            ],
          ),
        ),

        /// ================= Portion =================
        Column(
          children: <Widget>[
            const Text("Portion"),
            Row(
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: portion > 1
                      ? () => onPortionChanged(portion - 1)
                      : null,
                ),
                Text(portion.toString()),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => onPortionChanged(portion + 1),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
