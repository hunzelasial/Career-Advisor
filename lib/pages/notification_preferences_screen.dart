part of '../main.dart';

class NotificationPreferencesScreen extends StatefulWidget {
  const NotificationPreferencesScreen({super.key, required this.token});

  final String token;

  @override
  State<NotificationPreferencesScreen> createState() =>
      _NotificationPreferencesScreenState();
}

class _NotificationPreferencesScreenState
    extends State<NotificationPreferencesScreen> {
  final _api = UserApi();
  final Map<String, bool> _values = {
    'notifications': true,
    'sound': true,
    'vibrate': true,
    'payments': true,
    'specialOffers': false,
    'cashback': false,
    'appUpdates': true,
  };
  bool _loading = true;
  String? _error;

  static const _labels = <String, String>{
    'notifications': 'Push notifications',
    'sound': 'Sound',
    'vibrate': 'Vibration',
    'payments': 'Payments and account activity',
    'specialOffers': 'Special offers',
    'cashback': 'Cashback updates',
    'appUpdates': 'App updates',
  };

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final preferences = await _api.notificationPreferences(widget.token);
      if (!mounted) return;
      setState(() {
        for (final key in _values.keys) {
          if (preferences[key] is bool) _values[key] = preferences[key] as bool;
        }
        _loading = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = readableError(error);
      });
    }
  }

  Future<void> _update(String key, bool value) async {
    final previous = _values[key]!;
    setState(() => _values[key] = value);
    try {
      final updated = await _api.updateNotificationPreferences(widget.token, {
        key: value,
      });
      if (!mounted) return;
      setState(() {
        for (final entry in updated.entries) {
          if (_values.containsKey(entry.key) && entry.value is bool) {
            _values[entry.key] = entry.value as bool;
          }
        }
      });
    } catch (error) {
      if (!mounted) return;
      setState(() => _values[key] = previous);
      showMessage(context, readableError(error));
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Notification settings')),
    body: _loading
        ? const Center(child: CircularProgressIndicator())
        : ListView(
            padding: const EdgeInsets.fromLTRB(18, 14, 18, 24),
            children: [
              if (_error != null)
                AppPanel(
                  child: Text(
                    _error!,
                    style: const TextStyle(color: Colors.redAccent),
                  ),
                ),
              for (final entry in _labels.entries)
                SwitchListTile.adaptive(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 6),
                  title: Text(
                    entry.value,
                    style: const TextStyle(fontSize: 13),
                  ),
                  value: _values[entry.key]!,
                  activeTrackColor: _blue,
                  onChanged: (value) => _update(entry.key, value),
                ),
            ],
          ),
  );
}
