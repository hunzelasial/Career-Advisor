import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'apis/auth_api.dart';
import 'apis/user_api.dart';
import 'models/chat_message.dart';
import 'models/career_role.dart';
import 'utils/career_preferences_store.dart';
import 'utils/error_message.dart';
import 'utils/form_validators.dart';

part 'pages/welcome_screen.dart';
part 'pages/auth_screen.dart';
part 'pages/profile_setup_screen.dart';
part 'pages/home_shell.dart';
part 'pages/dashboard_screen.dart';
part 'pages/recommendations_screen.dart';
part 'pages/insights_screen.dart';
part 'pages/chat_screen.dart';
part 'pages/roadmap_screen.dart';
part 'pages/profile_screen.dart';
part 'pages/notification_preferences_screen.dart';
part 'pages/feature_screens.dart';
part 'widgets/app_widgets.dart';

void main() => runApp(const CareerAdvisorApp());

const _ink = Color(0xFF050B18);
const _panel = Color(0xFF0B1730);
const _panelLight = Color(0xFF102344);
const _blue = Color(0xFF128BFF);
const _cyan = Color(0xFF24D8FF);
const _muted = Color(0xFF91A7C7);
const _line = Color(0xFF1D3559);

class CareerAdvisorApp extends StatelessWidget {
  const CareerAdvisorApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Career Advisor',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: _ink,
      colorScheme: const ColorScheme.dark(
        primary: _blue,
        secondary: _cyan,
        surface: _panel,
      ),
      fontFamily: 'Roboto',
      useMaterial3: true,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF09152A),
        hintStyle: const TextStyle(color: _muted, fontSize: 13),
        labelStyle: const TextStyle(color: _muted, fontSize: 13),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 15,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: _line),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: _blue, width: 1.4),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
      ),
    ),
    home: const WelcomeScreen(),
  );
}
