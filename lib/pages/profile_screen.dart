part of '../main.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
    required this.token,
    required this.profile,
    required this.onProfileChanged,
    required this.onLogout,
  });

  final String token;
  final Map<String, dynamic> profile;
  final ValueChanged<Map<String, dynamic>> onProfileChanged;
  final Future<void> Function() onLogout;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _api = UserApi();
  final _preferences = CareerPreferencesStore();
  bool _busy = false;

  Future<void> _editProfile() async {
    final name = TextEditingController(
      text: widget.profile['fullName']?.toString() ?? '',
    );
    final title = TextEditingController(
      text: widget.profile['professionalTitle']?.toString() ?? '',
    );
    final phone = TextEditingController(
      text: widget.profile['phoneNumber']?.toString() ?? '',
    );
    final dateOfBirth = TextEditingController(
      text: widget.profile['dateOfBirth']?.toString() ?? '',
    );
    final gender = TextEditingController(
      text: widget.profile['gender']?.toString() ?? '',
    );
    final updated = await showDialog<Map<String, String>>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: _panel,
        title: const Text('Edit profile'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: name,
                decoration: const InputDecoration(labelText: 'Full name'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: title,
                decoration: const InputDecoration(
                  labelText: 'Professional title',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: phone,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Phone number'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: dateOfBirth,
                decoration: const InputDecoration(
                  labelText: 'Date of birth',
                  hintText: 'YYYY-MM-DD',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: gender,
                decoration: const InputDecoration(labelText: 'Gender'),
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
            onPressed: () => Navigator.pop(context, {
              'fullName': name.text.trim(),
              'professionalTitle': title.text.trim(),
              'phoneNumber': phone.text.trim(),
              'dateOfBirth': dateOfBirth.text.trim(),
              'gender': gender.text.trim(),
            }),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    name.dispose();
    title.dispose();
    phone.dispose();
    dateOfBirth.dispose();
    gender.dispose();
    if (updated == null || !mounted) return;
    setState(() => _busy = true);
    try {
      final profile = await _api.updateProfile(widget.token, updated);
      widget.onProfileChanged(profile);
      if (mounted) showMessage(context, 'Profile updated.');
    } catch (error) {
      if (mounted) showMessage(context, readableError(error));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _editCareerGoal() async {
    final currentGoal = await _preferences.loadCareerGoal();
    if (!mounted) return;
    final goal = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: _panel,
        title: const Text('Career goal'),
        content: DropdownButtonFormField<String>(
          initialValue: currentGoal,
          items: [
            for (final role in _RecommendationsScreenState.roles)
              DropdownMenuItem(value: role.title, child: Text(role.title)),
          ],
          onChanged: (value) => Navigator.pop(context, value),
        ),
      ),
    );
    if (goal == null) return;
    await _preferences.saveCareerGoal(goal);
    if (mounted) showMessage(context, 'Your career goal is now $goal.');
  }

  @override
  Widget build(BuildContext context) {
    final name = widget.profile['fullName']?.toString() ?? 'Career explorer';
    final email = widget.profile['email']?.toString() ?? '';
    final avatarUrl = widget.profile['avatarUrl']?.toString();
    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
      children: [
        const Text(
          'Profile',
          style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 18),
        AppPanel(
          child: Row(
            children: [
              if (avatarUrl != null && avatarUrl.isNotEmpty)
                ClipOval(
                  child: Image.network(
                    avatarUrl,
                    width: 52,
                    height: 52,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const CircleAvatar(
                          radius: 26,
                          backgroundColor: Color(0xFF174477),
                          child: Icon(Icons.person, color: _cyan),
                        ),
                  ),
                )
              else
                const CircleAvatar(
                  radius: 26,
                  backgroundColor: Color(0xFF174477),
                  child: Icon(Icons.person, color: _cyan),
                ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      email,
                      style: const TextStyle(color: _muted, fontSize: 11),
                    ),
                  ],
                ),
              ),
              if (_busy)
                const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        AppPanel(
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Personal details',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 8),
              _ProfileDetailRow(
                label: 'Professional title',
                value: widget.profile['professionalTitle']?.toString(),
              ),
              _ProfileDetailRow(
                label: 'Phone',
                value: widget.profile['phoneNumber']?.toString(),
              ),
              _ProfileDetailRow(
                label: 'Date of birth',
                value: widget.profile['dateOfBirth']?.toString(),
              ),
              _ProfileDetailRow(
                label: 'Gender',
                value: widget.profile['gender']?.toString(),
              ),
              FutureBuilder<String>(
                future: _preferences.loadCareerGoal(),
                builder: (context, snapshot) => _ProfileDetailRow(
                  label: 'Career goal',
                  value: snapshot.data,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        ProfileAction(
          icon: Icons.edit_outlined,
          label: 'Edit profile',
          onTap: _editProfile,
        ),
        ProfileAction(
          icon: Icons.school_outlined,
          label: 'Career preferences',
          onTap: _editCareerGoal,
        ),
        ProfileAction(
          icon: Icons.bookmark_outline,
          label: 'Saved careers',
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => const RecommendationsScreen(savedOnly: true),
            ),
          ),
        ),
        ProfileAction(
          icon: Icons.notifications_none,
          label: 'Notification settings',
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) =>
                  NotificationPreferencesScreen(token: widget.token),
            ),
          ),
        ),
        ProfileAction(
          icon: Icons.help_outline,
          label: 'About & help',
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute<void>(builder: (_) => const AboutHelpScreen()),
          ),
        ),
        const SizedBox(height: 12),
        TextButton.icon(
          onPressed: widget.onLogout,
          icon: const Icon(Icons.logout, color: Colors.redAccent, size: 18),
          label: const Text(
            'Log out',
            style: TextStyle(color: Colors.redAccent),
          ),
          style: TextButton.styleFrom(alignment: Alignment.centerLeft),
        ),
      ],
    );
  }
}

class _ProfileDetailRow extends StatelessWidget {
  const _ProfileDetailRow({required this.label, required this.value});

  final String label;
  final String? value;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(color: _muted, fontSize: 11),
          ),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Text(
            value == null || value!.trim().isEmpty ? 'Not provided' : value!,
            textAlign: TextAlign.end,
            style: const TextStyle(fontSize: 11),
          ),
        ),
      ],
    ),
  );
}
