class Agenda {
  final int? id;
  final String name;
  final String imgUrl;
  final String user;
  final String date;
  String? icon;
  String? grado;

  Agenda(
      {this.id,
      required this.name,
      required this.imgUrl,
      required this.user,
      required this.date,
      this.icon,
      this.grado});
  factory Agenda.fromMap(Map<String, dynamic> json) => Agenda(
        id: json["id"],
        name: json["name"],
        imgUrl: json["imgUrl"],
        user: json["user"],
        date: json["date"],
        icon: json["icon"],
        grado: json["grado"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "imgUrl": imgUrl,
        "user": user,
        "date": date,
        "icon": icon,
        "grado": grado,
      };
}
