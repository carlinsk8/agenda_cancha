class Agenda {
  final String? id;
  final String name;
  final String imgUrl;
  final String user;
  final String date;
  final Clima clima;

  Agenda({
    this.id,
    required this.name,
    required this.imgUrl,
    required this.user,
    required this.date,
    required this.clima,
  });
}

class Clima {
  final String tiempo;
  final String grado;

  Clima(this.tiempo, this.grado);
}
