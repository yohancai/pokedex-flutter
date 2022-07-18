
class Pokemon {
  Pokemon(
    this.name,
  );
  String name = "";

  Pokemon.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }
}