
import 'dart:convert';

class Pokemon {
  Pokemon(
    this.name,
  );
  String name = "";
  List<String> type = [];
  String image = "";

  Pokemon.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

}
ArrType typeFromJson(String str) => ArrType.fromJson(json.decode(str));

String welcomeToJson(ArrType data) => json.encode(data.toJson());

class ArrType {
  ArrType({
    required this.types,
  });

  List<TypeElement> types;

  factory ArrType.fromJson(Map<String, dynamic> json) => ArrType(
    types: List<TypeElement>.from(json["types"].map((x) => TypeElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "types": List<dynamic>.from(types.map((x) => x.toJson())),
  };
}

class TypeElement {
  TypeElement({
    required this.slot,
    required this.type,
  });

  int slot;
  Types type;

  factory TypeElement.fromJson(Map<String, dynamic> json) => TypeElement(
    slot: json["slot"],
    type: Types.fromJson(json["type"]),
  );

  Map<String, dynamic> toJson() => {
    "slot": slot,
    "type": type.toJson(),
  };
}

class Types {
  Types({
    required this.name,
    required this.url,
  });

  String name;
  String url;

  factory Types.fromJson(Map<String, dynamic> json) => Types(
    name: json["name"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "url": url,
  };
}

