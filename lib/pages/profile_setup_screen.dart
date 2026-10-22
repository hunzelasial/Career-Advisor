part of '../main.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({
    super.key,
    required this.token,
    this.refreshToken,
    required this.profile,
  });

  final String token;
  final String? refreshToken;
  final Map<String, dynamic> profile;

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _api = UserApi();
  final _title = TextEditingController();
  final _dob = TextEditingController();
  String? _gender;
  String? _interest;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _loadCareerGoal();
  }

  Future<void> _loadCareerGoal() async {
    final goal = await CareerPreferencesStore().loadCareerGoal();
    if (mounted &&
        _RecommendationsScreenState.roles.any((role) => role.title == goal)) {
      setState(() => _interest = goal);
    }
  }

  @override
  void dispose() {
    _title.dispose();
    _dob.dispose();
    super.dispose();
  }

  Future<void> _finish() async {
    setState(() => _busy = true);
    try {
      if (_interest != null) {
        await CareerPreferencesStore().saveCareerGoal(_interest!);
      }
      final updates = <String, dynamic>{
        if (_title.text.trim().isNotEmpty)
          'professionalTitle': _title.text.trim(),
        if (_dob.text.isNotEmpty) 'dateOfBirth': _dob.text,
        if (_gender != null) 'gender': _gender,
      };
      var profile = widget.profile;
      if (updates.isNotEmpty) {
        profile = await _api.updateProfile(widget.token, updates);
      }
      profile = await _api.completeOnboarding(widget.token);
      if (!mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute<void>(
          builder: (_) => HomeShell(
            token: widget.token,
            refreshToken: widget.refreshToken,
            profile: profile,
          ),
        ),
        (_) => false,
      );
    } catch (error) {
      if (mounted) showMessage(context, readableError(error));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text(
        'Complete your profile',
        style: TextStyle(fontSize: 16),
      ),
      backgroundColor: Colors.transparent,
    ),
    body: SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 28),
            children: [
              const StepProgress(current: 3),
              const SizedBox(height: 26),
              const Text(
                'A little about you',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 6),
              const Text(
                'We will use this to tailor your starting point.',
                style: TextStyle(color: _muted),
              ),
              const SizedBox(height: 25),
              const FieldLabel('Professional title'),
              TextField(
                controller: _title,
                decoration: const InputDecoration(
                  hintText: 'e.g. Recent graduate',
                ),
              ),
              const SizedBox(height: 17),
              const FieldLabel('Date of birth'),
              TextField(
                controller: _dob,
                readOnly: true,
                decoration: const InputDecoration(
                  hintText: 'YYYY-MM-DD',
                  suffixIcon: Icon(Icons.calendar_today_outlined),
                ),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime(2000),
                    firstDate: DateTime(1940),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) {
                    _dob.text =
                        '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
                  }
                },
              ),
              const SizedBox(height: 17),
              const FieldLabel('Gender'),
              DropdownButtonFormField<String>(
                initialValue: _gender,
                hint: const Text('Select gender'),
                items: const ['Woman', 'Man', 'Non-binary', 'Prefer not to say']
                    .map(
                      (value) =>
                          DropdownMenuItem(value: value, child: Text(value)),
                    )
                    .toList(),
                onChanged: (value) => setState(() => _gender = value),
              ),
              const SizedBox(height: 17),
              const FieldLabel('Career interest'),
              DropdownButtonFormField<String>(
                initialValue: _interest,
                hint: const Text('Choose an area'),
                items:
                    const [
                          'Software Engineer',
                          'Data Scientist',
                          'UX Designer',
                          'AI / ML Engineer',
                          'Product Manager',
                        ]
                        .map(
                          (value) => DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          ),
                        )
                        .toList(),
                onChanged: (value) => setState(() => _interest = value),
              ),
              const SizedBox(height: 28),
              PrimaryButton(
                label: 'Finish setup',
                busy: _busy,
                onPressed: _finish,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
