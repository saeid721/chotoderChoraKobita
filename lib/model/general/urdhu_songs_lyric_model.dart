class UrdhuSongsLyricModel {
  final int? id;
  final String title;
  final String fullLyric;

  UrdhuSongsLyricModel({
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

  static UrdhuSongsLyricModel fromMap(Map<String, dynamic> map) {
    return UrdhuSongsLyricModel(
      id: map['id'],
      title: map['title'],
      fullLyric: map['fullLyric'],
    );
  }
}
