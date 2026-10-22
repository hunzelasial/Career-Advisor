part of '../main.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  final _store = CareerPreferencesStore();
  final List<ChatMessage> _messages = [
    const ChatMessage(
      text:
          'Hi! I am your career assistant. What would you like to explore today?',
      fromUser: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _restoreHistory();
  }

  Future<void> _restoreHistory() async {
    final history = await _store.loadChatHistory();
    if (history.isNotEmpty && mounted) {
      setState(() {
        _messages
          ..clear()
          ..addAll(history);
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final question = _controller.text.trim();
    if (question.isEmpty) return;
    setState(() {
      _messages.add(ChatMessage(text: question, fromUser: true));
      _messages.add(ChatMessage(text: _answerFor(question), fromUser: false));
      _controller.clear();
    });
    await _store.saveChatHistory(_messages);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 240),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _newConversation() async {
    await _store.clearChatHistory();
    if (!mounted) return;
    setState(() {
      _messages
        ..clear()
        ..add(
          const ChatMessage(
            text:
                'Hi! I am your career assistant. What would you like to explore today?',
            fromUser: false,
          ),
        );
    });
  }

  String _answerFor(String question) {
    final text = question.toLowerCase();
    if (text.contains('resume') || text.contains('cv')) {
      return 'Start with a concise summary, then show measurable outcomes in each role or project. Share your target role and I can help tailor the wording.';
    }
    if (text.contains('interview')) {
      return 'Pick three examples that show problem solving, collaboration, and learning from a setback. Use a clear situation, action, and result for each.';
    }
    if (text.contains('salary') || text.contains('pay')) {
      return 'Compare salary ranges by location, seniority, and specialty. Data and AI roles are seeing strong demand, but your experience level matters most.';
    }
    if (text.contains('roadmap') || text.contains('learn')) {
      return 'Choose one target role, build its core skills, and create a small portfolio project. I have added a starter roadmap you can open from Home.';
    }
    return 'That is a useful question. Start by connecting what energizes you with skills you already use, then test one direction with a small project or conversation with someone in that field.';
  }

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(18, 17, 18, 12),
        child: Row(
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AI career assistant',
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.circle, color: Color(0xFF70E2A7), size: 8),
                      SizedBox(width: 5),
                      Text(
                        'Ready to help',
                        style: TextStyle(color: _muted, fontSize: 11),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              tooltip: 'New conversation',
              onPressed: _newConversation,
              icon: const Icon(Icons.add_comment_outlined, color: _cyan),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 38,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          scrollDirection: Axis.horizontal,
          children: [
            for (final prompt in [
              'Improve my resume',
              'Practice interviews',
              'Explore my roadmap',
            ])
              Padding(
                padding: const EdgeInsets.only(right: 7),
                child: ActionChip(
                  label: Text(prompt, style: const TextStyle(fontSize: 10)),
                  onPressed: () {
                    _controller.text = prompt;
                    _send();
                  },
                ),
              ),
          ],
        ),
      ),
      Expanded(
        child: ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          itemCount: _messages.length,
          itemBuilder: (context, index) {
            final message = _messages[index];
            return Align(
              alignment: message.fromUser
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 310),
                margin: const EdgeInsets.symmetric(vertical: 5),
                padding: const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 11,
                ),
                decoration: BoxDecoration(
                  color: message.fromUser ? const Color(0xFF1059A4) : _panel,
                  border: Border.all(
                    color: message.fromUser
                        ? _blue.withValues(alpha: .4)
                        : _line,
                  ),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Text(
                  message.text,
                  style: const TextStyle(fontSize: 12, height: 1.5),
                ),
              ),
            );
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(13, 9, 13, 12),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                onSubmitted: (_) => _send(),
                decoration: const InputDecoration(
                  hintText: 'Ask about your career...',
                  isDense: true,
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton.filled(
              tooltip: 'Send message',
              onPressed: _send,
              style: IconButton.styleFrom(backgroundColor: _blue),
              icon: const Icon(Icons.send_rounded, size: 19),
            ),
          ],
        ),
      ),
    ],
  );
}
