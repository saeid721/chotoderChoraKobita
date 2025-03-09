class BanglaLyricModel {
  final int? id;
  final String title;
  final String fullLyric;

  BanglaLyricModel({
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

  static BanglaLyricModel fromMap(Map<String, dynamic> map) {
    return BanglaLyricModel(
      id: map['id'],
      title: map['title'],
      fullLyric: map['fullLyric'],
    );
  }
}
