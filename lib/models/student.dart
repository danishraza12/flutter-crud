class Student {
  final String? name;
  final String? age;
  final String? city;
  final int? id;

  Student({this.name, this.age, this.city, this.id});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
        name: json['name'],
        age: json['age'],
        city: json['city'],
        id: json['id']);
  }
}
