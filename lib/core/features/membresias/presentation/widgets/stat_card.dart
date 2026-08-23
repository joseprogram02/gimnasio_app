import 'package:flutter/material.dart';
import 'dashboard_header.dart';

class ActivitiesCard extends StatelessWidget {
  const ActivitiesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return _Card(
      title: 'Activities',
      child: const Row(
        children: [
          _Metric(value: '42x', label: 'Activities in the last\n4 weeks'),
          _Divider(),
          _Metric(value: '8x', label: 'Visits in the last\n4 weeks'),
        ],
      ),
    );
  }
}

class HealthCard extends StatelessWidget {
  const HealthCard({super.key});

  @override
  Widget build(BuildContext context) {
    return _Card(
      title: 'Health Information',
      child: Row(
        children: const [
          _Metric(value: '2', label: 'Issues'),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _HealthLine(label: 'Spine'),
                SizedBox(height: 6),
                _HealthLine(label: 'Asthma'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TasksCard extends StatelessWidget {
  const TasksCard({super.key});

  @override
  Widget build(BuildContext context) {
    return _Card(
      title: 'Tasks',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          _Task(value: '1', label: 'Overdue', color: Color(0xFFFF304F)),
          _Task(value: '1', label: 'Open', color: Color(0xFFFFB800)),
          _Task(value: '3', label: 'Coming\nup', color: Colors.white),
        ],
      ),
    );
  }
}

class TrainingPlanCard extends StatelessWidget {
  const TrainingPlanCard({super.key});

  @override
  Widget build(BuildContext context) {
    return _Card(
      title: 'Training plan',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Upper/Lower Body Split\n(4 days)',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              height: 1.1,
            ),
          ),
          Spacer(),
          Text(
            '144 days left',
            style: TextStyle(
              color: Colors.white,
              fontSize: 8,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 3),
          Text(
            '1 Jan 2019 - 1 Jul 2019 (25 weeks)',
            style: TextStyle(color: muted, fontSize: 6.5),
          ),
          SizedBox(height: 6),
          LinearProgressIndicator(
            value: .22,
            minHeight: 2,
            backgroundColor: Color(0xFF3B3B3B),
            valueColor: AlwaysStoppedAnimation<Color>(orange),
          ),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final String title;
  final Widget child;

  const _Card({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(9, 8, 9, 8),
      decoration: BoxDecoration(
        color: bgCard,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 9,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 7),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  final String value;
  final String label;

  const _Metric({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 1),
          Text(label, style: const TextStyle(color: muted, fontSize: 6.5)),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 31, color: const Color(0xFF444444));
  }
}

class _Task extends StatelessWidget {
  final String value;
  final String label;
  final Color color;

  const _Task({
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: TextStyle(color: color, fontSize: 19)),
        Text(label, style: const TextStyle(color: muted, fontSize: 6)),
      ],
    );
  }
}

class _HealthLine extends StatelessWidget {
  final String label;

  const _HealthLine({required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.warning_amber_rounded, color: Color(0xFFFF3B4D), size: 12),
        const SizedBox(width: 3),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 7)),
      ],
    );
  }
}
