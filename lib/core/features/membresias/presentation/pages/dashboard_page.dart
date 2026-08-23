import 'package:flutter/material.dart';
import '../widgets/analysis_card.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/stat_card.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            const DashboardHeader(),
            Expanded(
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 6),
                child: _DashboardGrid(),
              ),
            ),
            const BottomNav(),
          ],
        ),
      ),
    );
  }
}

class _DashboardGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final gap = 7.0;
        final left = (constraints.maxWidth - gap) * .48;
        final right = constraints.maxWidth - gap - left;

        return Column(
          children: [
            _TopRow(left: left, right: right, gap: gap),
            const SizedBox(height: 7),
            SizedBox(
              height: 226,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(width: left, child: const _LeftLower()),
                  SizedBox(width: gap),
                  SizedBox(width: right, child: const AnalysisCard()),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _TopRow extends StatelessWidget {
  final double left;
  final double right;
  final double gap;

  const _TopRow({
    required this.left,
    required this.right,
    required this.gap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 72,
          child: Row(
            children: [
              SizedBox(width: left, child: const MemberHeader()),
              SizedBox(width: gap),
              SizedBox(width: right, child: const NotesCard()),
            ],
          ),
        ),
        const SizedBox(height: 7),
        SizedBox(
          height: 72,
          child: Row(
            children: [
              SizedBox(width: left, child: const ActivitiesCard()),
              SizedBox(width: gap),
              SizedBox(width: right, child: const HealthCard()),
            ],
          ),
        ),
      ],
    );
  }
}

class _LeftLower extends StatelessWidget {
  const _LeftLower();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(height: 72, child: TasksCard()),
        SizedBox(height: 7),
        Expanded(child: TrainingPlanCard()),
      ],
    );
  }
}
