class Cancha {
  final String? id;
  final String name;
  final String imgUrl;

  Cancha({
    this.id,
    required this.name,
    required this.imgUrl,
  });
  factory Cancha.fromMap(Map<String, dynamic> json) => Cancha(
        imgUrl: json["imgUrl"],
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "imgUrl": imgUrl,
        "name": name,
        "id": id,
      };
}
