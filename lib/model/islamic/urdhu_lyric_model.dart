class UrdhuLyricModel {
  final int? id;
  final String title;
  final String fullLyric;

  UrdhuLyricModel({
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

  static UrdhuLyricModel fromMap(Map<String, dynamic> map) {
    return UrdhuLyricModel(
      id: map['id'],
      title: map['title'],
      fullLyric: map['fullLyric'],
    );
  }
}
