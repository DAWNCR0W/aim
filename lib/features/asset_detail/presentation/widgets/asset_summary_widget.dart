import 'package:flutter/material.dart';

class AssetSummaryWidget extends StatelessWidget {
  final double stockRatio;
  final double bondRatio;
  final double etcRatio;

  const AssetSummaryWidget({
    Key? key,
    required this.stockRatio,
    required this.bondRatio,
    required this.etcRatio,
  }) : super(key: key);

  Widget _buildCategoryRow(String title, String subtitle, double ratio, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.grey, fontSize: 14)),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Text(subtitle, style: const TextStyle(color: Colors.white)),
            ),
            Text(
              "${ratio.toStringAsFixed(2)}%",
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          backgroundColor: Colors.white10,
          valueColor: AlwaysStoppedAnimation(color),
          value: (ratio / 100).clamp(0, 1),
          minHeight: 4,
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCategoryRow("주식형 자산", "선진시장 주식", stockRatio, Colors.cyanAccent),
        _buildCategoryRow("채권형 자산", "선진시장 채권", bondRatio, Colors.cyan),
        _buildCategoryRow("기타 자산", "미화 현금", etcRatio, Colors.amberAccent),
      ],
    );
  }
}
