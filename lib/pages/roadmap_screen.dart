part of '../main.dart';

class RoadmapScreen extends StatefulWidget {
  const RoadmapScreen({super.key, this.role});

  final CareerRole? role;

  @override
  State<RoadmapScreen> createState() => _RoadmapScreenState();
}

class _RoadmapScreenState extends State<RoadmapScreen> {
  final _store = CareerPreferencesStore();
  Set<int> _completed = <int>{};

  CareerRole get _role =>
      widget.role ?? _RecommendationsScreenState.roles.first;

  String get _roleId => _role.id;

  List<CareerRoadmapStep> get _steps => _role.roadmap.isNotEmpty
      ? _role.roadmap
      : _role.learningPath
            .map(
              (step) => CareerRoadmapStep(
                title: step,
                description:
                    'Practice this skill, ask for feedback, and keep evidence of what you learn.',
                duration: 'Milestone',
              ),
            )
            .toList();

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final completed = await _store.loadCompletedSteps(_roleId);
    if (mounted) {
      setState(
        () => _completed = completed
            .where((index) => index >= 0 && index < _steps.length)
            .toSet(),
      );
    }
  }

  Future<void> _toggleStep(int index, bool value) async {
    final next = Set<int>.from(_completed);
    value ? next.add(index) : next.remove(index);
    setState(() => _completed = next);
    await _store.saveCompletedSteps(_roleId, next);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Career roadmap', style: TextStyle(fontSize: 16)),
      backgroundColor: Colors.transparent,
    ),
    body: ListView(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 26),
      children: [
        Text(
          _role.title,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 5),
        const Text(
          'A flexible guide: adapt the pace to your situation and local requirements.',
          style: TextStyle(color: _muted, fontSize: 12),
        ),
        const SizedBox(height: 13),
        AppPanel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: LinearProgressIndicator(
                        value: _steps.isEmpty
                            ? 0
                            : (_completed.length / _steps.length).clamp(
                                0.0,
                                1.0,
                              ),
                        minHeight: 7,
                        color: _cyan,
                        backgroundColor: _line,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '${_completed.length}/${_steps.length} done',
                    style: const TextStyle(fontSize: 11),
                  ),
                ],
              ),
              const SizedBox(height: 11),
              const Text(
                'Use each milestone to build skills, experience, and proof of your work. Check official local rules for regulated careers.',
                style: TextStyle(color: _muted, fontSize: 11, height: 1.45),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        ...List.generate(
          _steps.length,
          (index) => _RoadmapStep(
            index: index,
            step: _steps[index],
            isLast: index == _steps.length - 1,
            completed: _completed.contains(index),
            onChanged: (value) => _toggleStep(index, value),
          ),
        ),
        const SizedBox(height: 7),
        AppPanel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Make the plan work for you',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              for (final tip in [
                'Set a realistic weekly study goal and review it every month.',
                'Save evidence of projects, placements, feedback, and skills in one portfolio or folder.',
                'Ask teachers, career advisers, and people in the field for feedback and informational conversations.',
                'Compare course cost, entry requirements, financial aid, and local job demand before committing.',
                'Tailor your CV to each role; practice interviews and apply for internships or supervised entry-level experience.',
              ])
                Padding(
                  padding: const EdgeInsets.only(bottom: 9),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.check_circle_outline,
                        color: _cyan,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          tip,
                          style: const TextStyle(
                            color: _muted,
                            fontSize: 11,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        PrimaryButton(
          label: 'Mark all complete',
          onPressed: () async {
            final all = Set<int>.from(
              List<int>.generate(_steps.length, (i) => i),
            );
            setState(() => _completed = all);
            await _store.saveCompletedSteps(_roleId, all);
          },
        ),
      ],
    ),
  );
}

class _RoadmapStep extends StatelessWidget {
  const _RoadmapStep({
    required this.index,
    required this.step,
    required this.isLast,
    required this.completed,
    required this.onChanged,
  });

  final int index;
  final CareerRoadmapStep step;
  final bool isLast;
  final bool completed;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) => IntrinsicHeight(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          width: 31,
          child: Column(
            children: [
              CircleAvatar(
                radius: 13,
                backgroundColor: const Color(0xFF123B58),
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(
                    color: _cyan,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    color: const Color(0xFF147C8C),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(width: 11),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.fromLTRB(13, 12, 13, 13),
            decoration: BoxDecoration(
              color: _panel,
              borderRadius: BorderRadius.circular(9),
              border: Border.all(color: _line),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        step.title,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                          decoration: completed
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        step.description,
                        style: const TextStyle(color: _muted, fontSize: 11),
                      ),
                      const SizedBox(height: 7),
                      Text(
                        step.duration,
                        style: const TextStyle(color: _cyan, fontSize: 10),
                      ),
                    ],
                  ),
                ),
                Checkbox.adaptive(
                  value: completed,
                  onChanged: (value) => onChanged(value ?? false),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
