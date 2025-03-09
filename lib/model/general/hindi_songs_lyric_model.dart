class HindiSongsLyricModel {
  final int? id;
  final String title;
  final String fullLyric;

  HindiSongsLyricModel({
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

  static HindiSongsLyricModel fromMap(Map<String, dynamic> map) {
    return HindiSongsLyricModel(
      id: map['id'],
      title: map['title'],
      fullLyric: map['fullLyric'],
    );
  }
}
