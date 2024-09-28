class DataItem {
  final int id;
  final String img;
  final String mp3;

  DataItem({
    required this.id,
    required this.img,
    required this.mp3,
  });

  factory DataItem.fromJson(Map<String, dynamic> json) {
    return DataItem(
      id: json['id'],
      img: json['img'],
      mp3: json['mp3'],
    );
  }

  factory DataItem.fromMap(Map<String, dynamic> map) {
    return DataItem(
      id: map['id'],
      img: map['img'],
      mp3: map['mp3'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'img': img,
      'mp3': mp3,
    };
  }
}