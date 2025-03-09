class BanglaSongsLyricModel {
  final int? id;
  final String title;
  final String fullLyric;

  BanglaSongsLyricModel({
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

  static BanglaSongsLyricModel fromMap(Map<String, dynamic> map) {
    return BanglaSongsLyricModel(
      id: map['id'],
      title: map['title'],
      fullLyric: map['fullLyric'],
    );
  }
}
