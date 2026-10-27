import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/chat_message.dart';

class CareerPreferencesStore {
  CareerPreferencesStore({SharedPreferencesAsync? preferences})
    : _preferences = preferences ?? SharedPreferencesAsync();

  final SharedPreferencesAsync _preferences;

  Future<Set<String>> loadSavedRoleIds() async =>
      (await _preferences.getStringList('savedCareerRoles') ?? <String>{})
          .toSet();

  Future<Set<String>> toggleSavedRole(String roleId) async {
    final saved = await loadSavedRoleIds();
    if (!saved.add(roleId)) saved.remove(roleId);
    await _preferences.setStringList('savedCareerRoles', saved.toList());
    return saved;
  }

  Future<String> loadCareerGoal() async =>
      await _preferences.getString('careerGoal') ?? 'Software Engineer';

  Future<void> saveCareerGoal(String goal) =>
      _preferences.setString('careerGoal', goal);

  Future<Set<int>> loadCompletedSteps(String roleId) async =>
      (await _preferences.getStringList('roadmap.$roleId') ?? <String>[])
          .map(int.tryParse)
          .whereType<int>()
          .toSet();

  Future<void> saveCompletedSteps(String roleId, Set<int> steps) =>
      _preferences.setStringList(
        'roadmap.$roleId',
        steps.map((step) => step.toString()).toList(),
      );

  Future<Set<String>> loadCompletedChallenges() async =>
      (await _preferences.getStringList('completedCareerChallenges') ??
              <String>[])
          .toSet();

  Future<void> saveCompletedChallenges(Set<String> challenges) => _preferences
      .setStringList('completedCareerChallenges', challenges.toList());

  Future<List<Map<String, String>>> loadInternshipTracker() async {
    final encoded = await _preferences.getString('careerInternshipTracker');
    if (encoded == null) return <Map<String, String>>[];
    try {
      final decoded = jsonDecode(encoded);
      if (decoded is! List) return <Map<String, String>>[];
      return decoded
          .whereType<Map>()
          .map(
            (entry) => entry.map(
              (key, value) => MapEntry(key.toString(), value?.toString() ?? ''),
            ),
          )
          .where((entry) => entry['id']?.isNotEmpty == true)
          .toList();
    } on FormatException {
      return <Map<String, String>>[];
    }
  }

  Future<void> saveInternshipTracker(List<Map<String, String>> internships) =>
      _preferences.setString(
        'careerInternshipTracker',
        jsonEncode(internships),
      );

  Future<List<ChatMessage>> loadChatHistory() async {
    final encoded = await _preferences.getString('careerChatHistory');
    if (encoded == null) return <ChatMessage>[];
    try {
      final messages = jsonDecode(encoded) as List<dynamic>;
      return messages
          .whereType<Map<String, dynamic>>()
          .map(ChatMessage.fromJson)
          .toList();
    } on FormatException {
      return <ChatMessage>[];
    }
  }

  Future<void> saveChatHistory(List<ChatMessage> messages) =>
      _preferences.setString(
        'careerChatHistory',
        jsonEncode(messages.map((message) => message.toJson()).toList()),
      );

  Future<void> clearChatHistory() => _preferences.remove('careerChatHistory');
}
