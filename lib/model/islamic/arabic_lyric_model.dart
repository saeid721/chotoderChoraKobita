class ArabicLyricModel {
  final int? id;
  final String title;
  final String fullLyric;

  ArabicLyricModel({
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

  static ArabicLyricModel fromMap(Map<String, dynamic> map) {
    return ArabicLyricModel(
      id: map['id'],
      title: map['title'],
      fullLyric: map['fullLyric'],
    );
  }
}
