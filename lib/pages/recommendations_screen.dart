part of '../main.dart';

class RecommendationsScreen extends StatefulWidget {
  const RecommendationsScreen({super.key, this.savedOnly = false});

  final bool savedOnly;

  @override
  State<RecommendationsScreen> createState() => _RecommendationsScreenState();
}

class _RecommendationsScreenState extends State<RecommendationsScreen> {
  static const roles = <CareerRole>[
    CareerRole(
      title: 'Software Engineer',
      summary: 'Build products used by millions',
      matchScore: 92,
      glyph: CareerGlyph.code,
      colorValue: 0xFF24D8FF,
      skills: ['Problem solving', 'Programming'],
      imageUrl:
          'https://images.unsplash.com/photo-1519389950473-47ba0277781c?auto=format&fit=crop&w=1200&q=80',
      salaryRange: '\$85k-\$145k',
      growth: '+17%',
      category: 'Technology',
      learningPath: [
        'Programming fundamentals',
        'Build and ship projects',
        'Practice system design',
        'Prepare for technical interviews',
      ],
    ),
    CareerRole(
      title: 'Data Scientist',
      summary: 'Find the story inside complex data',
      matchScore: 88,
      glyph: CareerGlyph.data,
      colorValue: 0xFF9C83FF,
      skills: ['Statistics', 'Python'],
      imageUrl:
          'https://images.unsplash.com/photo-1551288049-bebda4e38f71?auto=format&fit=crop&w=1200&q=80',
      salaryRange: '\$78k-\$132k',
      growth: '+20%',
      category: 'Data',
      learningPath: [
        'Learn Python and SQL',
        'Study statistics',
        'Build analysis projects',
        'Present a data portfolio',
      ],
    ),
    CareerRole(
      title: 'UX Designer',
      summary: 'Make digital products feel effortless',
      matchScore: 85,
      glyph: CareerGlyph.design,
      colorValue: 0xFFFFA76B,
      skills: ['Empathy', 'Prototyping'],
      imageUrl:
          'https://images.unsplash.com/photo-1586717791821-3f44a563fa4c?auto=format&fit=crop&w=1200&q=80',
      salaryRange: '\$72k-\$124k',
      growth: '+13%',
      category: 'Design',
      learningPath: [
        'Learn user research',
        'Practice interaction design',
        'Prototype a real workflow',
        'Publish case studies',
      ],
    ),
    CareerRole(
      title: 'AI / ML Engineer',
      summary: 'Create intelligent, adaptive systems',
      matchScore: 78,
      glyph: CareerGlyph.intelligence,
      colorValue: 0xFF72D8A4,
      skills: ['Machine learning', 'Mathematics'],
      imageUrl:
          'https://images.unsplash.com/photo-1677442136019-21780ecad995?auto=format&fit=crop&w=1200&q=80',
      salaryRange: '\$105k-\$175k',
      growth: '+24%',
      category: 'Technology',
      learningPath: [
        'Strengthen linear algebra',
        'Learn machine learning',
        'Train and evaluate models',
        'Deploy an AI project',
      ],
    ),
    CareerRole(
      title: 'Product Manager',
      summary: 'Guide ideas from insight to impact',
      matchScore: 72,
      glyph: CareerGlyph.product,
      colorValue: 0xFFFFC857,
      skills: ['Communication', 'Strategy'],
      imageUrl:
          'https://images.unsplash.com/photo-1556761175-b413da4baf72?auto=format&fit=crop&w=1200&q=80',
      salaryRange: '\$92k-\$158k',
      growth: '+12%',
      category: 'Business',
      learningPath: [
        'Understand customer research',
        'Practice product discovery',
        'Write clear product briefs',
        'Measure product outcomes',
      ],
    ),
  ];

  final _store = CareerPreferencesStore();
  Set<String> _savedIds = <String>{};
  String _query = '';
  String _category = 'All';
  late bool _savedOnly;

  @override
  void initState() {
    super.initState();
    _savedOnly = widget.savedOnly;
    _loadSaved();
  }

  Future<void> _loadSaved() async {
    final ids = await _store.loadSavedRoleIds();
    if (mounted) setState(() => _savedIds = ids);
  }

  Future<void> _toggleSaved(CareerRole role) async {
    final ids = await _store.toggleSavedRole(role.id);
    if (mounted) setState(() => _savedIds = ids);
  }

  List<CareerRole> get _filteredRoles => roles.where((role) {
    final matchesQuery =
        _query.isEmpty ||
        '${role.title} ${role.summary} ${role.skills.join(' ')}'
            .toLowerCase()
            .contains(_query.toLowerCase());
    final matchesCategory = _category == 'All' || role.category == _category;
    final matchesSaved = !_savedOnly || _savedIds.contains(role.id);
    return matchesQuery && matchesCategory && matchesSaved;
  }).toList();

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.fromLTRB(18, 20, 18, 24),
    children: [
      const Text(
        'Career recommendations',
        style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800),
      ),
      const SizedBox(height: 5),
      const Text(
        'Based on your interests and strengths',
        style: TextStyle(color: _muted, fontSize: 12),
      ),
      const SizedBox(height: 18),
      TextField(
        onChanged: (value) => setState(() => _query = value.trim()),
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: 'Search roles or skills',
          isDense: true,
        ),
      ),
      const SizedBox(height: 12),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (final category in [
              'All',
              'Technology',
              'Data',
              'Design',
              'Business',
            ])
              Padding(
                padding: const EdgeInsets.only(right: 7),
                child: ChoiceChip(
                  label: Text(category),
                  selected: category == _category,
                  showCheckmark: false,
                  onSelected: (_) => setState(() => _category = category),
                ),
              ),
          ],
        ),
      ),
      Align(
        alignment: Alignment.centerLeft,
        child: FilterChip(
          avatar: const Icon(Icons.bookmark_outline, size: 16),
          label: const Text('Saved roles'),
          selected: _savedOnly,
          onSelected: (value) => setState(() => _savedOnly = value),
        ),
      ),
      const SizedBox(height: 12),
      if (_filteredRoles.isEmpty)
        const AppPanel(
          child: Text(
            'No roles match these filters.',
            style: TextStyle(color: _muted),
          ),
        ),
      ..._filteredRoles.map(
        (role) => _RoleCard(
          role: role,
          isSaved: _savedIds.contains(role.id),
          onToggleSaved: () => _toggleSaved(role),
        ),
      ),
    ],
  );
}

class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.role,
    required this.isSaved,
    required this.onToggleSaved,
  });

  final CareerRole role;
  final bool isSaved;
  final VoidCallback onToggleSaved;

  @override
  Widget build(BuildContext context) {
    final color = Color(role.colorValue);
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Material(
        color: _panel,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () => showModalBottomSheet<void>(
            context: context,
            backgroundColor: _panel,
            isScrollControlled: true,
            builder: (_) => _RoleDetails(role: role),
          ),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _line),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    CareerPhoto(
                      imageUrl: role.imageUrl,
                      icon: _careerIcon(role.glyph),
                      color: color,
                      height: 120,
                    ),
                    Positioned(
                      right: 7,
                      top: 7,
                      child: IconButton.filledTonal(
                        tooltip: isSaved ? 'Remove saved role' : 'Save role',
                        onPressed: onToggleSaved,
                        icon: Icon(
                          isSaved ? Icons.bookmark : Icons.bookmark_border,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 11),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: color.withValues(alpha: .13),
                      child: Icon(
                        _careerIcon(role.glyph),
                        color: color,
                        size: 19,
                      ),
                    ),
                    const SizedBox(width: 11),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            role.title,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Match ${role.matchScore}%  ·  ${role.growth} growth',
                            style: const TextStyle(color: _cyan, fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: _muted, size: 19),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  role.summary,
                  style: const TextStyle(color: _muted, fontSize: 11),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RoleDetails extends StatelessWidget {
  const _RoleDetails({required this.role});

  final CareerRole role;

  @override
  Widget build(BuildContext context) => SafeArea(
    child: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          22,
          24,
          22,
          22 + MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              _careerIcon(role.glyph),
              color: Color(role.colorValue),
              size: 30,
            ),
            const SizedBox(height: 12),
            Text(
              role.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 7),
            Text(role.summary, style: const TextStyle(color: _muted)),
            const SizedBox(height: 18),
            Text(
              'Your match score  ${role.matchScore}%',
              style: const TextStyle(color: _cyan, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 17),
            const Text(
              'Key skills',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 9),
            Wrap(
              spacing: 8,
              children: [
                ...role.skills.map((skill) => SkillPill(skill)),
                const SkillPill('Communication'),
              ],
            ),
            const SizedBox(height: 22),
            PrimaryButton(
              label: 'Explore career roadmap',
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => RoadmapScreen(role: role),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    ),
  );
}

IconData _careerIcon(CareerGlyph glyph) => switch (glyph) {
  CareerGlyph.code => Icons.terminal,
  CareerGlyph.data => Icons.insights,
  CareerGlyph.design => Icons.draw_outlined,
  CareerGlyph.intelligence => Icons.memory,
  CareerGlyph.product => Icons.view_kanban_outlined,
};
