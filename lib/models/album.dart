// ignore_for_file: file_names

class Album {
  final String name;
  final String city;
  final String age;
  final int id;

  Album(
      {required this.name,
      required this.city,
      required this.age,
      required this.id});

  Album.fromJson(Map<dynamic, dynamic> json)
      : name = json['name'],
        age = json['age'],
        city = json['city'],
        id = json['id'];

  Map<dynamic, dynamic> toJson() =>
      {'id': id, 'name': name, 'city': city, 'age': age};
}
