class EnglishSongsLyricModel {
  final int? id;
  final String title;
  final String fullLyric;

  EnglishSongsLyricModel({
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

  static EnglishSongsLyricModel fromMap(Map<String, dynamic> map) {
    return EnglishSongsLyricModel(
      id: map['id'],
      title: map['title'],
      fullLyric: map['fullLyric'],
    );
  }
}
