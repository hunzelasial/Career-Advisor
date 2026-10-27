part of '../main.dart';

Future<void> _openGoogleSearch(BuildContext context, String query) async {
  final uri = Uri.https('www.google.com', '/search', {'q': query});
  final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
  if (!opened && context.mounted) {
    showMessage(context, 'Could not open Google Search. Please try again.');
  }
}

class FeatureHubScreen extends StatelessWidget {
  const FeatureHubScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Career toolkit')),
    body: ListView(
      padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),
      children: [
        const Text(
          'Make your next move',
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 6),
        const Text(
          'Explore opportunities, build skills, and prepare with confidence.',
          style: TextStyle(color: _muted, fontSize: 12, height: 1.5),
        ),
        const SizedBox(height: 18),
        _FeatureCard(
          title: 'Find internships',
          description: 'Search current opportunities on Google.',
          image:
              'https://images.unsplash.com/photo-1521737711867-e3b97375f902?auto=format&fit=crop&w=1000&q=80',
          icon: Icons.work_outline,
          color: _cyan,
          onTap: () => _push(context, const InternshipFinderScreen()),
        ),
        _FeatureCard(
          title: 'Analyze your skill gaps',
          description: 'Compare your strengths with a career’s key skills.',
          image:
              'https://images.unsplash.com/photo-1434030216411-0b793f4b4173?auto=format&fit=crop&w=1000&q=80',
          icon: Icons.psychology_outlined,
          color: const Color(0xFFB897FF),
          onTap: () => _push(context, const SkillGapScreen()),
        ),
        _FeatureCard(
          title: 'CV builder',
          description: 'Draft a clear, role-focused CV with a live preview.',
          image:
              'https://images.unsplash.com/photo-1586281380349-632531db7ed4?auto=format&fit=crop&w=1000&q=80',
          icon: Icons.description_outlined,
          color: const Color(0xFF78D9FF),
          onTap: () => _push(context, const CvBuilderScreen()),
        ),
        _FeatureCard(
          title: 'Practice interviews',
          description: 'Review common questions and practical answer tips.',
          image:
              'https://images.unsplash.com/photo-1560472354-b33ff0c44a43?auto=format&fit=crop&w=1000&q=80',
          icon: Icons.record_voice_over_outlined,
          color: const Color(0xFFFFA76B),
          onTap: () => _push(context, const InterviewPrepScreen()),
        ),
        _FeatureCard(
          title: 'Career aptitude quiz',
          description: 'Reflect on the activities and environments you enjoy.',
          image:
              'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?auto=format&fit=crop&w=1000&q=80',
          icon: Icons.quiz_outlined,
          color: const Color(0xFF72D8A4),
          onTap: () => _push(context, const AptitudeTestScreen()),
        ),
        _FeatureCard(
          title: 'Learning challenges',
          description: 'Turn your goal into small, trackable actions.',
          image:
              'https://images.unsplash.com/photo-1456324504439-367cee3b3c32?auto=format&fit=crop&w=1000&q=80',
          icon: Icons.flag_outlined,
          color: const Color(0xFFFFC857),
          onTap: () => _push(context, const LearningChallengesScreen()),
        ),
        _FeatureCard(
          title: 'Degrees & universities',
          description: 'Find programs and check official entry requirements.',
          image:
              'https://images.unsplash.com/photo-1523050854058-8df90110c9f1?auto=format&fit=crop&w=1000&q=80',
          icon: Icons.account_balance_outlined,
          color: const Color(0xFF78D9FF),
          onTap: () => _push(context, const UniversityGuideScreen()),
        ),
        _FeatureCard(
          title: 'Market insights',
          description: 'Explore an illustrative snapshot of career trends.',
          image:
              'https://images.unsplash.com/photo-1551288049-bebda4e38f71?auto=format&fit=crop&w=1000&q=80',
          icon: Icons.query_stats,
          color: const Color(0xFFFFA76B),
          onTap: () => _push(context, const InsightsScreen()),
        ),
      ],
    ),
  );

  void _push(BuildContext context, Widget page) =>
      Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => page));
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
    required this.title,
    required this.description,
    required this.image,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String title;
  final String description;
  final String image;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 11),
    child: Material(
      color: _panel,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          height: 118,
          child: Stack(
            fit: StackFit.expand,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      ColoredBox(color: color.withValues(alpha: .12)),
                ),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    colors: [Color(0xF0050B18), Color(0x25050B18)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: [0, 1],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: color.withValues(alpha: .17),
                      child: Icon(icon, color: color),
                    ),
                    const SizedBox(width: 13),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            description,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, size: 15),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class InternshipFinderScreen extends StatefulWidget {
  const InternshipFinderScreen({super.key});

  @override
  State<InternshipFinderScreen> createState() => _InternshipFinderScreenState();
}

class _InternshipFinderScreenState extends State<InternshipFinderScreen> {
  final _keyword = TextEditingController();
  final _location = TextEditingController();
  String _category = 'Any field';

  @override
  void dispose() {
    _keyword.dispose();
    _location.dispose();
    super.dispose();
  }

  Future<void> _search({bool remote = false}) async {
    final terms = <String>[
      if (_keyword.text.trim().isNotEmpty) _keyword.text.trim(),
      if (_category != 'Any field') _category,
      'internship',
      if (remote) 'remote',
      if (!remote && _location.text.trim().isNotEmpty) _location.text.trim(),
      'careers apply',
    ];
    await _openGoogleSearch(context, terms.join(' '));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Internship finder')),
    body: ListView(
      padding: const EdgeInsets.fromLTRB(18, 10, 18, 24),
      children: [
        const _FeatureIntro(
          title: 'Find your first opportunity',
          text:
              'Search Google for current internships. Listings open in your browser; verify each role and employer before applying.',
          image:
              'https://images.unsplash.com/photo-1521737711867-e3b97375f902?auto=format&fit=crop&w=1200&q=80',
        ),
        const SizedBox(height: 18),
        const FieldLabel('Role or keywords'),
        TextField(
          controller: _keyword,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search),
            hintText: 'e.g. software developer',
          ),
        ),
        const SizedBox(height: 14),
        const FieldLabel('Field'),
        DropdownButtonFormField<String>(
          initialValue: _category,
          items:
              const [
                    'Any field',
                    'Technology',
                    'Data science',
                    'Design',
                    'Business',
                    'Healthcare',
                    'Education',
                    'Engineering',
                  ]
                  .map(
                    (value) =>
                        DropdownMenuItem(value: value, child: Text(value)),
                  )
                  .toList(),
          onChanged: (value) =>
              setState(() => _category = value ?? 'Any field'),
        ),
        const SizedBox(height: 14),
        const FieldLabel('Location'),
        TextField(
          controller: _location,
          textInputAction: TextInputAction.search,
          onSubmitted: (_) => _search(),
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.location_on_outlined),
            hintText: 'City, region, or country',
          ),
        ),
        const SizedBox(height: 15),
        PrimaryButton(
          label: 'Search internships on Google',
          onPressed: _search,
        ),
        const SizedBox(height: 8),
        OutlinedButton.icon(
          onPressed: () => _search(remote: true),
          icon: const Icon(Icons.public),
          label: const Text('Find remote internships'),
        ),
        const SizedBox(height: 8),
        OutlinedButton.icon(
          onPressed: _addOpportunity,
          icon: const Icon(Icons.bookmark_add_outlined),
          label: const Text('Save an opportunity / track an application'),
        ),
        TextButton.icon(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => const InternshipTrackerScreen(),
            ),
          ),
          icon: const Icon(Icons.list_alt_outlined),
          label: const Text('Saved internships & applications'),
        ),
        const SizedBox(height: 18),
        const AppPanel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Application checklist',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 9),
              _TipRow('Confirm the company and job post on its official site.'),
              _TipRow('Check dates, eligibility, compensation, and location.'),
              _TipRow('Never pay to apply or share account passwords.'),
            ],
          ),
        ),
      ],
    ),
  );

  Future<void> _addOpportunity() async {
    final title = TextEditingController();
    final company = TextEditingController();
    final location = TextEditingController();
    final link = TextEditingController();
    final entry = await showDialog<Map<String, String>>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: _panel,
        title: const Text('Save an opportunity'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: title,
                decoration: const InputDecoration(labelText: 'Role title'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: company,
                decoration: const InputDecoration(labelText: 'Company'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: location,
                decoration: const InputDecoration(labelText: 'Location'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: link,
                keyboardType: TextInputType.url,
                decoration: const InputDecoration(
                  labelText: 'Listing URL (optional)',
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final role = title.text.trim();
              final employer = company.text.trim();
              final listingUrl = link.text.trim();
              final parsedUrl = Uri.tryParse(listingUrl);
              if (role.isEmpty || employer.isEmpty) {
                showMessage(context, 'Enter both a role title and company.');
                return;
              }
              if (listingUrl.isNotEmpty &&
                  (parsedUrl == null ||
                      !{'http', 'https'}.contains(parsedUrl.scheme))) {
                showMessage(
                  context,
                  'Enter a valid http or https listing URL.',
                );
                return;
              }
              Navigator.pop(context, {
                'id': DateTime.now().microsecondsSinceEpoch.toString(),
                'title': role,
                'company': employer,
                'location': location.text.trim(),
                'url': link.text.trim(),
                'status': 'Saved',
              });
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
    title.dispose();
    company.dispose();
    location.dispose();
    link.dispose();
    if (entry == null || !mounted) return;
    final store = CareerPreferencesStore();
    final saved = await store.loadInternshipTracker();
    await store.saveInternshipTracker([entry, ...saved]);
    if (mounted) showMessage(context, 'Opportunity saved on this device.');
  }
}

class InternshipTrackerScreen extends StatefulWidget {
  const InternshipTrackerScreen({super.key});

  @override
  State<InternshipTrackerScreen> createState() =>
      _InternshipTrackerScreenState();
}

class _InternshipTrackerScreenState extends State<InternshipTrackerScreen> {
  final _store = CareerPreferencesStore();
  List<Map<String, String>> _entries = <Map<String, String>>[];
  bool _loading = true;
  String _filter = 'Saved';

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final entries = await _store.loadInternshipTracker();
    if (mounted) {
      setState(() {
        _entries = entries;
        _loading = false;
      });
    }
  }

  Future<void> _setStatus(Map<String, String> entry, String status) async {
    final updated = _entries
        .map(
          (item) => item['id'] == entry['id']
              ? <String, String>{...item, 'status': status}
              : item,
        )
        .toList();
    await _store.saveInternshipTracker(updated);
    if (mounted) setState(() => _entries = updated);
  }

  Future<void> _remove(Map<String, String> entry) async {
    final updated = _entries
        .where((item) => item['id'] != entry['id'])
        .toList();
    await _store.saveInternshipTracker(updated);
    if (mounted) setState(() => _entries = updated);
  }

  @override
  Widget build(BuildContext context) {
    final visible = _entries.where((item) {
      final applied = item['status'] == 'Applied';
      return _filter == 'Applied' ? applied : !applied;
    }).toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Internship tracker')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.fromLTRB(18, 12, 18, 24),
              children: [
                const Text(
                  'Keep your search organized',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Saved locally on this device. Add an opportunity from its official listing.',
                  style: TextStyle(color: _muted, fontSize: 11, height: 1.5),
                ),
                const SizedBox(height: 15),
                SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(value: 'Saved', label: Text('Saved')),
                    ButtonSegment(value: 'Applied', label: Text('Applied')),
                  ],
                  selected: {_filter},
                  onSelectionChanged: (selection) =>
                      setState(() => _filter = selection.first),
                ),
                const SizedBox(height: 13),
                if (visible.isEmpty)
                  AppPanel(
                    child: Text(
                      _filter == 'Saved'
                          ? 'No saved internships yet. Search Google, then add a listing to keep track of it here.'
                          : 'No applications tracked yet.',
                      style: const TextStyle(
                        color: _muted,
                        fontSize: 12,
                        height: 1.5,
                      ),
                    ),
                  ),
                for (final entry in visible)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 9),
                    child: AppPanel(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const CircleAvatar(
                                backgroundColor: _panelLight,
                                child: Icon(Icons.work_outline, color: _cyan),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      entry['title'] ?? 'Internship',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${entry['company'] ?? ''}${(entry['location'] ?? '').isEmpty ? '' : ' · ${entry['location']}'}',
                                      style: const TextStyle(
                                        color: _muted,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                tooltip: 'Remove',
                                onPressed: () => _remove(entry),
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: _muted,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 9),
                          Row(
                            children: [
                              if ((entry['url'] ?? '').isNotEmpty)
                                TextButton.icon(
                                  onPressed: () async {
                                    final uri = Uri.tryParse(entry['url']!);
                                    if (uri == null ||
                                        !{
                                          'http',
                                          'https',
                                        }.contains(uri.scheme) ||
                                        !await launchUrl(
                                          uri,
                                          mode: LaunchMode.externalApplication,
                                        )) {
                                      if (context.mounted) {
                                        showMessage(
                                          context,
                                          'Could not open the saved listing.',
                                        );
                                      }
                                    }
                                  },
                                  icon: const Icon(Icons.open_in_new, size: 15),
                                  label: const Text('Open listing'),
                                ),
                              const Spacer(),
                              TextButton(
                                onPressed: () => _setStatus(
                                  entry,
                                  _filter == 'Saved' ? 'Applied' : 'Saved',
                                ),
                                child: Text(
                                  _filter == 'Saved'
                                      ? 'Mark applied'
                                      : 'Move to saved',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}

class SkillGapScreen extends StatefulWidget {
  const SkillGapScreen({super.key});

  @override
  State<SkillGapScreen> createState() => _SkillGapScreenState();
}

class _SkillGapScreenState extends State<SkillGapScreen> {
  CareerRole _role = _RecommendationsScreenState.roles.first;
  final Set<String> _skills = <String>{};

  @override
  Widget build(BuildContext context) {
    final total = _role.skills.length;
    final matched = _role.skills.where(_skills.contains).length;
    final value = total == 0 ? 0.0 : matched / total;
    final missing = _role.skills.where((skill) => !_skills.contains(skill));
    return Scaffold(
      appBar: AppBar(title: const Text('Skill gap analyzer')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 10, 18, 24),
        children: [
          const _FeatureIntro(
            title: 'Build your next skill',
            text:
                'Choose a career and mark the skills you already feel confident using. This is a self-assessment, not a formal test.',
            image:
                'https://images.unsplash.com/photo-1434030216411-0b793f4b4173?auto=format&fit=crop&w=1200&q=80',
          ),
          const SizedBox(height: 17),
          const FieldLabel('Target career'),
          DropdownButtonFormField<CareerRole>(
            initialValue: _role,
            isExpanded: true,
            items: _RecommendationsScreenState.roles
                .map(
                  (role) => DropdownMenuItem(
                    value: role,
                    child: Text(role.title, overflow: TextOverflow.ellipsis),
                  ),
                )
                .toList(),
            onChanged: (role) {
              if (role != null) {
                setState(() {
                  _role = role;
                  _skills.removeWhere((skill) => !role.skills.contains(skill));
                });
              }
            },
          ),
          const SizedBox(height: 17),
          AppPanel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Your self-assessed match',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    Text(
                      '${(value * 100).round()}%',
                      style: const TextStyle(
                        color: _cyan,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: value,
                    minHeight: 7,
                    backgroundColor: _line,
                    color: _cyan,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  '$matched of $total skills selected',
                  style: const TextStyle(color: _muted, fontSize: 11),
                ),
              ],
            ),
          ),
          const SizedBox(height: 17),
          const SectionTitle('Skills you already have'),
          const SizedBox(height: 5),
          const Text(
            'Select skills you can demonstrate with examples.',
            style: TextStyle(color: _muted, fontSize: 11),
          ),
          const SizedBox(height: 7),
          for (final skill in _role.skills)
            CheckboxListTile.adaptive(
              value: _skills.contains(skill),
              onChanged: (checked) => setState(() {
                checked == true ? _skills.add(skill) : _skills.remove(skill);
              }),
              title: Text(skill, style: const TextStyle(fontSize: 12)),
              activeColor: _blue,
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
            ),
          const SizedBox(height: 12),
          const SectionTitle('Suggested learning focus'),
          const SizedBox(height: 8),
          if (missing.isEmpty)
            const AppPanel(
              child: Text(
                'Great progress. Keep practicing these skills and add evidence to your portfolio.',
                style: TextStyle(color: _muted, height: 1.5),
              ),
            )
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: missing.map((skill) => SkillPill(skill)).toList(),
            ),
          const SizedBox(height: 17),
          PrimaryButton(
            label: 'Open ${_role.title} roadmap',
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => RoadmapScreen(role: _role),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InterviewPrepScreen extends StatefulWidget {
  const InterviewPrepScreen({super.key});

  @override
  State<InterviewPrepScreen> createState() => _InterviewPrepScreenState();
}

class _InterviewPrepScreenState extends State<InterviewPrepScreen> {
  String _category = 'General';

  static const _questions = <String, List<(String, String)>>{
    'General': [
      (
        'Tell me about yourself.',
        'Connect your current focus, one relevant example, and why this role is a logical next step.',
      ),
      (
        'Describe a challenge you worked through.',
        'Use a clear situation, your specific actions, the outcome, and what you learned.',
      ),
      (
        'What would you like to learn in this role?',
        'Name a realistic skill and show how it connects to the team’s work.',
      ),
    ],
    'Behavioral': [
      (
        'Tell me about a time you worked with different viewpoints.',
        'Explain how you listened, found shared goals, and helped the group move forward.',
      ),
      (
        'Describe a mistake and what you did next.',
        'Be accountable, focus on the response, and show how you changed your approach.',
      ),
      (
        'How do you prioritize competing deadlines?',
        'Describe how you clarify impact, communicate trade-offs, and check progress.',
      ),
    ],
    'Technical': [
      (
        'How do you approach a problem you have not seen before?',
        'Clarify requirements, break the task into steps, state assumptions, and test your solution.',
      ),
      (
        'Tell me about a project you are proud of.',
        'Explain the goal, your contribution, one technical decision, and a lesson learned.',
      ),
      (
        'How do you respond to feedback on your work?',
        'Give an example of how you understood feedback, acted on it, and checked the result.',
      ),
    ],
  };

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Interview preparation')),
    body: ListView(
      padding: const EdgeInsets.fromLTRB(18, 10, 18, 24),
      children: [
        const _FeatureIntro(
          title: 'Practice with purpose',
          text:
              'Pick a question, plan a concise example, and practice aloud. Tips are prompts—not scripts.',
          image:
              'https://images.unsplash.com/photo-1560472354-b33ff0c44a43?auto=format&fit=crop&w=1200&q=80',
        ),
        const SizedBox(height: 17),
        SegmentedButton<String>(
          segments: const [
            ButtonSegment(value: 'General', label: Text('General')),
            ButtonSegment(value: 'Behavioral', label: Text('Behavioral')),
            ButtonSegment(value: 'Technical', label: Text('Technical')),
          ],
          selected: {_category},
          onSelectionChanged: (value) =>
              setState(() => _category = value.first),
        ),
        const SizedBox(height: 14),
        for (final item in _questions[_category]!)
          Padding(
            padding: const EdgeInsets.only(bottom: 9),
            child: AppPanel(
              child: ExpansionTile(
                tilePadding: EdgeInsets.zero,
                childrenPadding: const EdgeInsets.only(bottom: 7),
                title: Text(
                  item.$1,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      item.$2,
                      style: const TextStyle(
                        color: _muted,
                        fontSize: 11,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        const SizedBox(height: 8),
        const AppPanel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Before you go',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 8),
              _TipRow('Research the employer and role using trusted sources.'),
              _TipRow(
                'Prepare a few questions about the team and expectations.',
              ),
              _TipRow(
                'Use truthful examples and protect confidential information.',
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class CvBuilderScreen extends StatefulWidget {
  const CvBuilderScreen({super.key});

  @override
  State<CvBuilderScreen> createState() => _CvBuilderScreenState();
}

class _CvBuilderScreenState extends State<CvBuilderScreen> {
  final _name = TextEditingController();
  final _contact = TextEditingController();
  final _headline = TextEditingController();
  final _summary = TextEditingController();
  final _skills = TextEditingController();
  final _experience = TextEditingController();
  final _education = TextEditingController();
  final _project = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _contact.dispose();
    _headline.dispose();
    _summary.dispose();
    _skills.dispose();
    _experience.dispose();
    _education.dispose();
    _project.dispose();
    super.dispose();
  }

  void _preview() {
    if (_name.text.trim().isEmpty || _headline.text.trim().isEmpty) {
      showMessage(context, 'Add your name and target role to preview your CV.');
      return;
    }
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: _panel,
      builder: (context) => SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(22, 22, 22, 28),
          children: [
            Text(
              _name.text.trim(),
              style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 4),
            Text(
              _headline.text.trim(),
              style: const TextStyle(color: _cyan, fontSize: 14),
            ),
            if (_contact.text.trim().isNotEmpty) ...[
              const SizedBox(height: 5),
              Text(
                _contact.text.trim(),
                style: const TextStyle(color: _muted, fontSize: 11),
              ),
            ],
            const Divider(height: 24),
            _cvSection('PROFILE', _summary.text),
            _cvSection('KEY SKILLS', _skills.text),
            _cvSection('EXPERIENCE', _experience.text),
            _cvSection('EDUCATION', _education.text),
            _cvSection('PROJECTS', _project.text),
            const SizedBox(height: 9),
            const Text(
              'Review for accuracy and tailor this draft to each application.',
              style: TextStyle(color: _muted, fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cvSection(String title, String content) {
    final value = content.trim();
    if (value.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: _cyan,
              fontWeight: FontWeight.w700,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 5),
          Text(value, style: const TextStyle(fontSize: 12, height: 1.5)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('CV builder')),
    body: ListView(
      padding: const EdgeInsets.fromLTRB(18, 10, 18, 26),
      children: [
        const _FeatureIntro(
          title: 'Create a focused first draft',
          text:
              'Add concise, truthful details and preview a clean CV layout. Your draft stays in this screen and is not uploaded.',
          image:
              'https://images.unsplash.com/photo-1586281380349-632531db7ed4?auto=format&fit=crop&w=1200&q=80',
        ),
        const SizedBox(height: 16),
        const FieldLabel('Full name'),
        TextField(
          controller: _name,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(hintText: 'Your name'),
        ),
        const SizedBox(height: 12),
        const FieldLabel('Email or contact details'),
        TextField(
          controller: _contact,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            hintText: 'Email, phone, or professional profile',
          ),
        ),
        const SizedBox(height: 12),
        const FieldLabel('Target role / professional headline'),
        TextField(
          controller: _headline,
          decoration: const InputDecoration(
            hintText: 'e.g. Entry-level Data Analyst',
          ),
        ),
        const SizedBox(height: 12),
        const FieldLabel('Professional summary'),
        TextField(
          controller: _summary,
          minLines: 3,
          maxLines: 5,
          decoration: const InputDecoration(
            hintText: 'Summarize your strengths and relevant experience.',
          ),
        ),
        const SizedBox(height: 12),
        const FieldLabel('Skills'),
        TextField(
          controller: _skills,
          minLines: 2,
          maxLines: 3,
          decoration: const InputDecoration(
            hintText: 'Separate skills with commas.',
          ),
        ),
        const SizedBox(height: 12),
        const FieldLabel('Experience'),
        TextField(
          controller: _experience,
          minLines: 3,
          maxLines: 5,
          decoration: const InputDecoration(
            hintText:
                'Role, organization, dates, and measurable contributions.',
          ),
        ),
        const SizedBox(height: 12),
        const FieldLabel('Education'),
        TextField(
          controller: _education,
          minLines: 2,
          maxLines: 4,
          decoration: const InputDecoration(
            hintText: 'Qualification, institution, and dates.',
          ),
        ),
        const SizedBox(height: 12),
        const FieldLabel('Projects'),
        TextField(
          controller: _project,
          minLines: 2,
          maxLines: 4,
          decoration: const InputDecoration(
            hintText: 'Project, your contribution, tools, and outcome.',
          ),
        ),
        const SizedBox(height: 18),
        PrimaryButton(label: 'Preview CV', onPressed: _preview),
      ],
    ),
  );
}

class AptitudeTestScreen extends StatefulWidget {
  const AptitudeTestScreen({super.key});

  @override
  State<AptitudeTestScreen> createState() => _AptitudeTestScreenState();
}

class _AptitudeTestScreenState extends State<AptitudeTestScreen> {
  static const _questions = <(String, List<(String, String)>)>[
    (
      'Which activity sounds most satisfying?',
      [
        ('Solving a logic puzzle', 'Technology'),
        ('Helping someone learn', 'Education'),
        ('Making something visually clear', 'Design'),
        ('Organizing a team project', 'Business'),
      ],
    ),
    (
      'What would you choose for a free project?',
      [
        ('Explore a dataset', 'Technology'),
        ('Plan a helpful workshop', 'Education'),
        ('Prototype an app screen', 'Design'),
        ('Coordinate a community event', 'Business'),
      ],
    ),
    (
      'What kind of challenge motivates you?',
      [
        ('Finding patterns and causes', 'Technology'),
        ('Explaining difficult ideas', 'Education'),
        ('Improving an experience', 'Design'),
        ('Bringing people and plans together', 'Business'),
      ],
    ),
    (
      'Which strength do you most enjoy using?',
      [
        ('Analytical thinking', 'Technology'),
        ('Patience and encouragement', 'Education'),
        ('Creativity and empathy', 'Design'),
        ('Planning and communication', 'Business'),
      ],
    ),
    (
      'Which outcome feels most rewarding?',
      [
        ('A tool that works reliably', 'Technology'),
        ('Someone gaining confidence', 'Education'),
        ('A solution people love using', 'Design'),
        ('A group reaching its goal', 'Business'),
      ],
    ),
  ];

  final Map<int, String> _answers = <int, String>{};
  int _question = 0;
  bool _finished = false;

  void _answer(String field) {
    setState(() {
      _answers[_question] = field;
      if (_question == _questions.length - 1) {
        _finished = true;
      } else {
        _question++;
      }
    });
  }

  String get _result {
    final counts = <String, int>{};
    for (final field in _answers.values) {
      counts[field] = (counts[field] ?? 0) + 1;
    }
    return counts.entries.reduce((a, b) => a.value >= b.value ? a : b).key;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Career aptitude quiz')),
    body: ListView(
      padding: const EdgeInsets.fromLTRB(18, 10, 18, 24),
      children: [
        const _FeatureIntro(
          title: 'Explore what energizes you',
          text:
              'There are no right answers. This short reflection is a starting point, not a scientific assessment or hiring test.',
          image:
              'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?auto=format&fit=crop&w=1200&q=80',
        ),
        const SizedBox(height: 18),
        if (_finished)
          AppPanel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.auto_awesome, color: _cyan, size: 28),
                const SizedBox(height: 10),
                const Text(
                  'A direction to explore',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 7),
                Text(
                  _result,
                  style: const TextStyle(
                    color: _cyan,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 7),
                const Text(
                  'Use this as a conversation starter. Explore several paths and compare them with your interests, circumstances, and local opportunities.',
                  style: TextStyle(color: _muted, fontSize: 12, height: 1.5),
                ),
                const SizedBox(height: 15),
                PrimaryButton(
                  label: 'Explore careers',
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const RecommendationsScreen(),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => setState(() {
                    _answers.clear();
                    _question = 0;
                    _finished = false;
                  }),
                  child: const Text('Retake quiz'),
                ),
              ],
            ),
          )
        else ...[
          LinearProgressIndicator(
            value: (_question + 1) / _questions.length,
            minHeight: 6,
            backgroundColor: _line,
            borderRadius: BorderRadius.circular(5),
            color: _cyan,
          ),
          const SizedBox(height: 10),
          Text(
            'QUESTION ${_question + 1} OF ${_questions.length}',
            style: const TextStyle(color: _muted, fontSize: 10),
          ),
          const SizedBox(height: 9),
          Text(
            _questions[_question].$1,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 14),
          for (final option in _questions[_question].$2)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => _answer(option.$2),
                  style: OutlinedButton.styleFrom(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.all(14),
                    side: const BorderSide(color: _line),
                  ),
                  child: Text(option.$1),
                ),
              ),
            ),
        ],
      ],
    ),
  );
}

class LearningChallengesScreen extends StatefulWidget {
  const LearningChallengesScreen({super.key});

  @override
  State<LearningChallengesScreen> createState() =>
      _LearningChallengesScreenState();
}

class _LearningChallengesScreenState extends State<LearningChallengesScreen> {
  static const _challenges = <(String, String, IconData)>[
    (
      'Choose one skill to practice',
      'Pick a small, specific skill related to your career goal.',
      Icons.lightbulb_outline,
    ),
    (
      'Complete a 25-minute learning session',
      'Focus on one lesson, exercise, or tutorial without multitasking.',
      Icons.timer_outlined,
    ),
    (
      'Make something small',
      'Create a short project or work sample that shows what you learned.',
      Icons.build_outlined,
    ),
    (
      'Ask for constructive feedback',
      'Share your work with a trusted peer, mentor, or instructor.',
      Icons.forum_outlined,
    ),
    (
      'Reflect and plan the next step',
      'Write down one thing you learned and what you will try next.',
      Icons.edit_note_outlined,
    ),
  ];

  final _store = CareerPreferencesStore();
  Set<String> _completed = <String>{};
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final saved = await _store.loadCompletedChallenges();
    if (mounted) {
      setState(() {
        _completed = saved;
        _loading = false;
      });
    }
  }

  Future<void> _toggle(String title, bool value) async {
    final next = Set<String>.from(_completed);
    value ? next.add(title) : next.remove(title);
    setState(() => _completed = next);
    await _store.saveCompletedChallenges(next);
  }

  @override
  Widget build(BuildContext context) {
    final progress = _completed.length / _challenges.length;
    return Scaffold(
      appBar: AppBar(title: const Text('Learning challenges')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.fromLTRB(18, 10, 18, 24),
              children: [
                const _FeatureIntro(
                  title: 'Small steps add up',
                  text:
                      'Build a repeatable learning habit. Your progress is saved on this device.',
                  image:
                      'https://images.unsplash.com/photo-1456324504439-367cee3b3c32?auto=format&fit=crop&w=1200&q=80',
                ),
                const SizedBox(height: 17),
                AppPanel(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Your progress',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ),
                          Text(
                            '${_completed.length}/${_challenges.length}',
                            style: const TextStyle(
                              color: _cyan,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 9),
                      LinearProgressIndicator(
                        value: progress,
                        minHeight: 6,
                        backgroundColor: _line,
                        color: _cyan,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                for (final (title, detail, icon) in _challenges)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 9),
                    child: AppPanel(
                      child: CheckboxListTile.adaptive(
                        contentPadding: EdgeInsets.zero,
                        controlAffinity: ListTileControlAffinity.leading,
                        value: _completed.contains(title),
                        onChanged: (value) => _toggle(title, value == true),
                        activeColor: _blue,
                        secondary: Icon(icon, color: _cyan),
                        title: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            detail,
                            style: const TextStyle(
                              color: _muted,
                              fontSize: 10,
                              height: 1.45,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}

class UniversityGuideScreen extends StatefulWidget {
  const UniversityGuideScreen({super.key});

  @override
  State<UniversityGuideScreen> createState() => _UniversityGuideScreenState();
}

class _UniversityGuideScreenState extends State<UniversityGuideScreen> {
  final _program = TextEditingController();
  final _location = TextEditingController();

  @override
  void dispose() {
    _program.dispose();
    _location.dispose();
    super.dispose();
  }

  Future<void> _search() async {
    final query = [
      if (_program.text.trim().isNotEmpty) _program.text.trim(),
      'degree university program',
      if (_location.text.trim().isNotEmpty) _location.text.trim(),
      'official admissions',
    ].join(' ');
    await _openGoogleSearch(context, query);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Degrees & universities')),
    body: ListView(
      padding: const EdgeInsets.fromLTRB(18, 10, 18, 24),
      children: [
        const _FeatureIntro(
          title: 'Choose a learning pathway',
          text:
              'Search the web for programs, then verify admissions, accreditation, and costs directly with the institution and local regulator.',
          image:
              'https://images.unsplash.com/photo-1523050854058-8df90110c9f1?auto=format&fit=crop&w=1200&q=80',
        ),
        const SizedBox(height: 17),
        const FieldLabel('Subject or qualification'),
        TextField(
          controller: _program,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.menu_book_outlined),
            hintText: 'e.g. computer science degree',
          ),
        ),
        const SizedBox(height: 14),
        const FieldLabel('Country or region'),
        TextField(
          controller: _location,
          textInputAction: TextInputAction.search,
          onSubmitted: (_) => _search(),
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.public),
            hintText: 'Where would you like to study?',
          ),
        ),
        const SizedBox(height: 15),
        PrimaryButton(label: 'Search programs on Google', onPressed: _search),
        const SizedBox(height: 18),
        const AppPanel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Before choosing a program',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 9),
              _TipRow('Check accreditation with the relevant official body.'),
              _TipRow(
                'Compare total tuition, living costs, and financial aid.',
              ),
              _TipRow('Confirm entry requirements and graduate outcomes.'),
              _TipRow('For regulated careers, confirm local licensing rules.'),
            ],
          ),
        ),
      ],
    ),
  );
}

class AboutHelpScreen extends StatelessWidget {
  const AboutHelpScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('About & help')),
    body: ListView(
      padding: const EdgeInsets.all(18),
      children: const [
        _FeatureIntro(
          title: 'Career Advisor',
          text:
              'A practical workspace for exploring career paths, building skills, and planning next steps.',
          image:
              'https://images.unsplash.com/photo-1522071820081-009f0129c71c?auto=format&fit=crop&w=1200&q=80',
        ),
        SizedBox(height: 16),
        AppPanel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'A note about information',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 8),
              Text(
                'Career pathways and market snapshots in the app are general guidance, not guaranteed vacancies, salary estimates, or professional advice. Google Search opens external results; check the publisher, date, and official organization before relying on information.',
                style: TextStyle(color: _muted, height: 1.55, fontSize: 12),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        AppPanel(
          child: Text(
            'Protect your personal information. Do not share passwords, payment details, or sensitive documents with an employer until you have verified the organization and its application process.',
            style: TextStyle(color: _muted, height: 1.55, fontSize: 12),
          ),
        ),
      ],
    ),
  );
}

class _FeatureIntro extends StatelessWidget {
  const _FeatureIntro({
    required this.title,
    required this.text,
    required this.image,
  });

  final String title;
  final String text;
  final String image;

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: SizedBox(
      height: 154,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            image,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                const ColoredBox(color: Color(0xFF123356)),
          ),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [Color(0xEF050B18), Color(0x15050B18)],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 11,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _TipRow extends StatelessWidget {
  const _TipRow(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 7),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.check_circle_outline, color: _cyan, size: 15),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(color: _muted, fontSize: 11, height: 1.4),
          ),
        ),
      ],
    ),
  );
}
