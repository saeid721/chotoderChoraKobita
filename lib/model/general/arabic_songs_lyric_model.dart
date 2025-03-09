class ArabicSongsLyricModel {
  final int? id;
  final String title;
  final String fullLyric;

  ArabicSongsLyricModel({
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

  static ArabicSongsLyricModel fromMap(Map<String, dynamic> map) {
    return ArabicSongsLyricModel(
      id: map['id'],
      title: map['title'],
      fullLyric: map['fullLyric'],
    );
  }
}
