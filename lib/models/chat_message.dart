class ChatMessage {
  const ChatMessage({required this.text, required this.fromUser});

  final String text;
  final bool fromUser;

  Map<String, Object> toJson() => {'text': text, 'fromUser': fromUser};

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
    text: json['text']?.toString() ?? '',
    fromUser: json['fromUser'] == true,
  );
}
