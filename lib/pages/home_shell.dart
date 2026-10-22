part of '../main.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({
    super.key,
    required this.token,
    this.refreshToken,
    required this.profile,
  });

  final String token;
  final String? refreshToken;
  final Map<String, dynamic> profile;

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _selected = 0;
  late Map<String, dynamic> _profile;

  @override
  void initState() {
    super.initState();
    _profile = Map<String, dynamic>.from(widget.profile);
  }

  void _setProfile(Map<String, dynamic> profile) =>
      setState(() => _profile = profile);

  Future<void> _signOut() async {
    final refreshToken = widget.refreshToken;
    if (refreshToken != null && refreshToken.isNotEmpty) {
      try {
        await AuthApi().logout(refreshToken);
      } catch (error) {
        if (mounted) showMessage(context, readableError(error));
      }
    }
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(builder: (_) => const WelcomeScreen()),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      DashboardScreen(
        profile: _profile,
        onOpenTab: (index) => setState(() => _selected = index),
      ),
      const RecommendationsScreen(),
      const InsightsScreen(),
      const ChatScreen(),
      ProfileScreen(
        token: widget.token,
        profile: _profile,
        onProfileChanged: _setProfile,
        onLogout: _signOut,
      ),
    ];
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(index: _selected, children: pages),
      ),
      bottomNavigationBar: NavigationBar(
        height: 66,
        backgroundColor: const Color(0xFF081329),
        indicatorColor: _blue.withValues(alpha: .18),
        selectedIndex: _selected,
        onDestinationSelected: (index) => setState(() => _selected = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.school_outlined),
            selectedIcon: Icon(Icons.school),
            label: 'Careers',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon: Icon(Icons.bar_chart),
            label: 'Insights',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline),
            selectedIcon: Icon(Icons.chat_bubble),
            label: 'Chat',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
