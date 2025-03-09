class HindiLyricModel {
  final int? id;
  final String title;
  final String fullLyric;

  HindiLyricModel({
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

  static HindiLyricModel fromMap(Map<String, dynamic> map) {
    return HindiLyricModel(
      id: map['id'],
      title: map['title'],
      fullLyric: map['fullLyric'],
    );
  }
}
