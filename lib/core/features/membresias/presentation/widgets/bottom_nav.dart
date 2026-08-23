import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      color: const Color(0xFF111111),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _NavItem(Icons.format_list_bulleted, 'Tasks'),
          _NavItem(Icons.group_outlined, 'Members', active: true),
          _NavItem(Icons.description_outlined, 'Templates'),
          _NavItem(Icons.person_outline, 'My Profile'),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;

  const _NavItem(this.icon, this.label, {this.active = false});

  @override
  Widget build(BuildContext context) {
    final color = active ? const Color(0xFFFF923D) : const Color(0xFF777777);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: 11),
        const SizedBox(height: 1),
        Text(
          label,
          style: TextStyle(color: color, fontSize: 5.5),
        ),
      ],
    );
  }
}
