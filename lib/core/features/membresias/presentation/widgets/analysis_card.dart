import 'package:flutter/material.dart';
import 'dashboard_header.dart';

class AnalysisCard extends StatelessWidget {
  const AnalysisCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(9, 8, 9, 6),
      decoration: BoxDecoration(
        color: bgCard,
        borderRadius: BorderRadius.circular(7),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Analysis',
            style: TextStyle(
              color: Colors.white,
              fontSize: 9,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 5),
          _BioAge(),
          _AnalysisMetric(
            title: 'Strength',
            value: '26',
            asset: 'assets/images/strength.png',
          ),
          _AnalysisMetric(
            title: 'Metabolism',
            value: '24',
            asset: 'assets/images/metabolism.png',
          ),
          _AnalysisMetric(
            title: 'Cardio',
            value: '28',
            asset: 'assets/images/cardio.png',
          ),
        ],
      ),
    );
  }
}

class _BioAge extends StatelessWidget {
  const _BioAge();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 91,
      child: Stack(
        children: [
          const Positioned(
            left: 0,
            top: 3,
            child: Text(
              'BioAge',
              style: TextStyle(color: Colors.white, fontSize: 8),
            ),
          ),
          const Positioned(
            left: 0,
            top: 19,
            child: Text(
              '26',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Positioned(
            left: 27,
            top: 27,
            child: Text(
              'years',
              style: TextStyle(color: muted, fontSize: 6),
            ),
          ),
          Positioned(
            right: 1,
            top: 0,
            child: Image.asset(
              'assets/images/bioage.png',
              width: 61,
              height: 66,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}

class _AnalysisMetric extends StatelessWidget {
  final String title;
  final String value;
  final String asset;

  const _AnalysisMetric({
    required this.title,
    required this.value,
    required this.asset,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: muted, fontSize: 6)),
                const SizedBox(height: 1),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      value,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 2),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 2),
                      child: Text('years', style: TextStyle(color: muted, fontSize: 5)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Image.asset(asset, width: 49, height: 33, fit: BoxFit.contain),
        ],
      ),
    );
  }
}
