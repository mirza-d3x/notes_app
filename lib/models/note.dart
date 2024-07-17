class Note {
  final String id;
  final String title;
  final String content;
  final List<String> activeUsers;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.activeUsers,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      activeUsers: List<String>.from(json['activeUsers']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'activeUsers': activeUsers,
    };
  }
}
