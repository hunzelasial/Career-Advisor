part of '../main.dart';

class RoadmapScreen extends StatefulWidget {
  const RoadmapScreen({super.key, this.role});

  final CareerRole? role;

  static const steps = [
    ('Build foundations', 'Learn programming fundamentals', '1-6 months'),
    ('Gain practical skills', 'Work on real projects', '6-12 months'),
    ('Build your portfolio', 'Showcase your work', '1-2 years'),
    ('Apply for junior roles', 'Start your professional journey', '2+ years'),
    ('Grow your experience', 'Deepen and specialize your skills', '2-5 years'),
    ('Advance your career', 'Lead projects and mentor others', '5+ years'),
  ];

  @override
  State<RoadmapScreen> createState() => _RoadmapScreenState();
}

class _RoadmapScreenState extends State<RoadmapScreen> {
  final _store = CareerPreferencesStore();
  Set<int> _completed = <int>{};

  String get _roleId => widget.role?.id ?? 'software-engineer';

  List<(String, String, String)> get _steps => widget.role == null
      ? RoadmapScreen.steps
      : widget.role!.learningPath
            .map(
              (step) => (
                step,
                'Practice this skill and add the result to your portfolio.',
                'Milestone',
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
    if (mounted) setState(() => _completed = completed);
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
          widget.role?.title ?? 'Software Engineer',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 5),
        const Text(
          'Your progress is saved on this device.',
          style: TextStyle(color: _muted, fontSize: 12),
        ),
        AppPanel(
          child: Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: LinearProgressIndicator(
                    value: _steps.isEmpty
                        ? 0
                        : _completed.length / _steps.length,
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
  final (String, String, String) step;
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
                        step.$1,
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
                        step.$2,
                        style: const TextStyle(color: _muted, fontSize: 11),
                      ),
                      const SizedBox(height: 7),
                      Text(
                        step.$3,
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
