class Student {
  final String? name;
  final String? age;
  final String? city;

  Student({this.name, this.age, this.city});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(name: json['name'], age: json['age'], city: json['city']);
  }
}
