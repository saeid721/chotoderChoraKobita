class Lyric {
  final int? id;
  final String title;
  final String fullLyric;

  Lyric({
    this.id,
    required this.title,
    required this.fullLyric,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'fullLyric': fullLyric,
    };
  }

  static Lyric fromMap(Map<String, dynamic> map) {
    return Lyric(
      id: map['id'],
      title: map['title'],
      fullLyric: map['fullLyric'],
    );
  }
}
