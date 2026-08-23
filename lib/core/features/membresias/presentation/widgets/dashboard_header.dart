import 'package:flutter/material.dart';

const bgCard = Color(0xFF202020);
const muted = Color(0xFFB5B5B5);
const orange = Color(0xFFFF923D);

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 38,
      child: Row(
        children: [
          SizedBox(width: 10),
          Icon(Icons.chevron_left, color: orange, size: 16),
          SizedBox(width: 1),
          Text('Back', style: TextStyle(color: orange, fontSize: 9)),
          Spacer(),
          Text(
            'Dashboard',
            style: TextStyle(
              color: Colors.white,
              fontSize: 9,
              fontWeight: FontWeight.w500,
            ),
          ),
          Spacer(),
          SizedBox(width: 35),
        ],
      ),
    );
  }
}

class MemberHeader extends StatelessWidget {
  const MemberHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: Image.asset(
            'assets/images/profile.png',
            width: 48,
            height: 48,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 7),
        const Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.circle, color: Color(0xFF00E676), size: 5),
                  SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      'Simons Williams',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Text(
                'Muscle gain',
                style: TextStyle(color: muted, fontSize: 7),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class NotesCard extends StatelessWidget {
  const NotesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: orange,
        borderRadius: BorderRadius.circular(7),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Notes',
            style: TextStyle(
              color: Colors.black,
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Simons is going on vacation from the\n21st of June until the 18th of July.',
            style: TextStyle(
              color: Color(0xFF252525),
              fontSize: 6.5,
              height: 1.25,
            ),
          ),
        ],
      ),
    );
  }
}
