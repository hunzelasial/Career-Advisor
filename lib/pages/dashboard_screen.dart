part of '../main.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({
    super.key,
    required this.profile,
    required this.onOpenTab,
  });

  final Map<String, dynamic> profile;
  final ValueChanged<int> onOpenTab;

  @override
  Widget build(BuildContext context) {
    final name = (profile['firstName'] ?? profile['fullName'] ?? 'there')
        .toString()
        .split(' ')
        .first;
    const profileFields = [
      'fullName',
      'email',
      'phoneNumber',
      'dateOfBirth',
      'gender',
      'professionalTitle',
    ];
    final completedFields = profileFields
        .where((field) => profile[field]?.toString().trim().isNotEmpty ?? false)
        .length;
    final completion = (completedFields / profileFields.length * 100).round();
    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 22),
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello, $name',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 3),
                  const Text(
                    'Your next chapter starts here.',
                    style: TextStyle(color: _muted, fontSize: 12),
                  ),
                ],
              ),
            ),
            const CircleAvatar(
              backgroundColor: _panelLight,
              child: Icon(Icons.notifications_none, color: Colors.white),
            ),
          ],
        ),
        const SizedBox(height: 19),
        CareerHero(onTap: () => onOpenTab(1)),
        const SizedBox(height: 16),
        FutureBuilder<String>(
          future: CareerPreferencesStore().loadCareerGoal(),
          builder: (context, snapshot) => AppPanel(
            child: Row(
              children: [
                const Icon(Icons.track_changes, color: _cyan),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'CURRENT GOAL',
                        style: TextStyle(color: _muted, fontSize: 9),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        snapshot.data ?? 'Software Engineer',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () => onOpenTab(4),
                  child: const Text('Edit'),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        ProgressCard(completion: completion, onTap: () => onOpenTab(4)),
        const SizedBox(height: 22),
        const SectionTitle('Your workspace'),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.48,
          children: [
            ToolTile(
              icon: Icons.school_outlined,
              title: 'Jobs & career paths',
              color: _cyan,
              imageUrl:
                  'https://images.unsplash.com/photo-1519389950473-47ba0277781c?auto=format&fit=crop&w=800&q=80',
              onTap: () => onOpenTab(1),
            ),
            ToolTile(
              icon: Icons.query_stats,
              title: 'Job market',
              color: const Color(0xFFFFC857),
              imageUrl:
                  'https://images.unsplash.com/photo-1551288049-bebda4e38f71?auto=format&fit=crop&w=800&q=80',
              onTap: () => onOpenTab(2),
            ),
            ToolTile(
              icon: Icons.chat_bubble_outline,
              title: 'AI assistant',
              color: const Color(0xFFB897FF),
              imageUrl:
                  'https://images.unsplash.com/photo-1556761175-b413da4baf72?auto=format&fit=crop&w=800&q=80',
              onTap: () => onOpenTab(3),
            ),
            ToolTile(
              icon: Icons.route_outlined,
              title: 'Career roadmap',
              color: const Color(0xFF69E2B0),
              imageUrl:
                  'https://images.unsplash.com/photo-1586717791821-3f44a563fa4c?auto=format&fit=crop&w=800&q=80',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute<void>(builder: (_) => const RoadmapScreen()),
              ),
            ),
          ],
        ),
        const SizedBox(height: 22),
        const SectionTitle('Featured insight'),
        const SizedBox(height: 11),
        InsightHighlight(onTap: () => onOpenTab(2)),
        const SizedBox(height: 22),
        Row(
          children: [
            const Expanded(child: SectionTitle('Explore different fields')),
            TextButton(
              onPressed: () => onOpenTab(1),
              child: const Text('See all'),
            ),
          ],
        ),
        const CareerRow(
          name: 'Nurse',
          detail: 'Healthcare',
          icon: Icons.health_and_safety_outlined,
          color: _cyan,
        ),
        const CareerRow(
          name: 'Teacher / Educator',
          detail: 'Education',
          icon: Icons.menu_book_outlined,
          color: Color(0xFFFFC857),
        ),
        const CareerRow(
          name: 'Accountant',
          detail: 'Business & Finance',
          icon: Icons.account_balance_outlined,
          color: Color(0xFF9C83FF),
        ),
        FutureBuilder<Set<String>>(
          future: CareerPreferencesStore().loadSavedRoleIds(),
          builder: (context, snapshot) => Padding(
            padding: const EdgeInsets.only(top: 7),
            child: Text(
              '${snapshot.data?.length ?? 0} saved career${snapshot.data?.length == 1 ? '' : 's'}',
              style: const TextStyle(color: _muted, fontSize: 11),
            ),
          ),
        ),
      ],
    );
  }
}
