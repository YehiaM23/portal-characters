class Character {
  final int charId;
  final String name, img, status, species, gender, origin, location;
  Character.fromJson(Map<String, dynamic> json)
    : charId = json['id'] as int,
      name = json['name'] as String,
      img = json['image'] as String,
      status = json['status'] as String,
      species = json['species'] as String,
      gender = json['gender'] as String,
      origin = json['origin']['name'] as String,
      location = json['location']['name'] as String;
}
