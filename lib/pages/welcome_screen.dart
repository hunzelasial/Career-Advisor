part of '../main.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(26, 26, 26, 22),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 112,
                        width: 112,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _blue.withValues(alpha: .13),
                          border: Border.all(
                            color: _blue.withValues(alpha: .42),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: _blue.withValues(alpha: .22),
                              blurRadius: 42,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.school_rounded,
                          size: 66,
                          color: _blue,
                        ),
                      ),
                      const SizedBox(height: 28),
                      const Text(
                        'Career Advisor',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'AI-powered career guidance\nfor a brighter future',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: _muted, height: 1.55),
                      ),
                      const SizedBox(height: 36),
                      const _FeatureLine(
                        icon: Icons.auto_awesome,
                        label: 'Personalized recommendations',
                      ),
                      const _FeatureLine(
                        icon: Icons.chat_bubble_outline,
                        label: 'AI chatbot assistance',
                      ),
                      const _FeatureLine(
                        icon: Icons.query_stats,
                        label: 'Job market insights',
                      ),
                      const _FeatureLine(
                        icon: Icons.route_outlined,
                        label: 'A roadmap built for you',
                      ),
                      PrimaryButton(
                        label: 'Get started',
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => const AuthScreen(isSignup: true),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextButton(
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => const AuthScreen(isSignup: false),
                          ),
                        ),
                        child: const Text('Already have an account?  Log in'),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

class _FeatureLine extends StatelessWidget {
  const _FeatureLine({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 9),
    child: Row(
      children: [
        Icon(icon, color: _cyan, size: 20),
        const SizedBox(width: 12),
        Text(label, style: const TextStyle(fontSize: 14)),
      ],
    ),
  );
}
