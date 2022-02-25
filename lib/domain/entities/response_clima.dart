import 'dart:convert';

class ResponseClima {
  ResponseClima({
    required this.location,
    required this.current,
  });

  final Location location;
  final Current current;

  factory ResponseClima.fromJson(String str) =>
      ResponseClima.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ResponseClima.fromMap(Map<String, dynamic> json) => ResponseClima(
        location: Location.fromMap(json["location"]),
        current: Current.fromMap(json["current"]),
      );

  Map<String, dynamic> toMap() => {
        "location": location.toMap(),
        "current": current.toMap(),
      };
}

class Current {
  Current({
    required this.lastUpdatedEpoch,
    required this.lastUpdated,
    required this.tempC,
    required this.condition,
  });

  final int lastUpdatedEpoch;
  final String lastUpdated;
  final double tempC;
  final Condition condition;

  factory Current.fromJson(String str) => Current.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Current.fromMap(Map<String, dynamic> json) => Current(
        lastUpdatedEpoch: json["last_updated_epoch"],
        lastUpdated: json["last_updated"],
        tempC: json["temp_c"],
        condition: Condition.fromMap(json["condition"]),
      );

  Map<String, dynamic> toMap() => {
        "last_updated_epoch": lastUpdatedEpoch,
        "last_updated": lastUpdated,
        "temp_c": tempC,
        "condition": condition.toMap(),
      };
}

class Condition {
  Condition({
    required this.text,
    required this.icon,
    required this.code,
  });

  final String text;
  final String icon;
  final int code;

  factory Condition.fromJson(String str) => Condition.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Condition.fromMap(Map<String, dynamic> json) => Condition(
        text: json["text"],
        icon: json["icon"],
        code: json["code"],
      );

  Map<String, dynamic> toMap() => {
        "text": text,
        "icon": icon,
        "code": code,
      };
}

class Location {
  Location({
    required this.region,
    required this.country,
    required this.localtime,
  });

  final String region;
  final String country;
  final String localtime;

  factory Location.fromJson(String str) => Location.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Location.fromMap(Map<String, dynamic> json) => Location(
        region: json["region"],
        country: json["country"],
        localtime: json["localtime"],
      );

  Map<String, dynamic> toMap() => {
        "region": region,
        "country": country,
        "localtime": localtime,
      };
}
