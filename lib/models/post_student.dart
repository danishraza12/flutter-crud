class PostStudent {
  final String? name;
  final String? age;
  final String? city;
  final String? statusCode;
  final String? statusMessage;

  PostStudent(
      {this.name, this.age, this.city, this.statusCode, this.statusMessage});

  factory PostStudent.fromJson(Map<String, dynamic> json) {
    return PostStudent(
        name: json['name'],
        age: json['age'],
        city: json['city'],
        statusCode: json['statusCode'],
        statusMessage: json['statusMessage']);
  }

  Map toMap() {
    var map = new Map();
    map["name"] = name;
    map["age"] = age;
    map["city"] = city;
    map["statusCode"] = statusCode;
    map["statusMessage"] = statusMessage;
    return map;
  }
}
