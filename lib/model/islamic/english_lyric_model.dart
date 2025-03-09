class EnglishLyricModel {
  final int? id;
  final String title;
  final String fullLyric;

  EnglishLyricModel({
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

  static EnglishLyricModel fromMap(Map<String, dynamic> map) {
    return EnglishLyricModel(
      id: map['id'],
      title: map['title'],
      fullLyric: map['fullLyric'],
    );
  }
}
