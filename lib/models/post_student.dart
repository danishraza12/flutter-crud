class PostStudent {
  final String? name;
  final String? age;
  final String? city;
  final String? batch;
  final String? address;
  final String? dateOfbirth;
  final String? fatherName;
  final String? gender;
  final String? rollNumber;
  final String? degreeStatus;
  final String? statusCode;
  final String? statusMessage;

  PostStudent(
      {this.name,
      this.age,
      this.city,
      this.batch,
      this.address,
      this.dateOfbirth,
      this.fatherName,
      this.gender,
      this.rollNumber,
      this.statusCode,
      this.statusMessage,
      this.degreeStatus});

  factory PostStudent.fromJson(Map<String, dynamic> json) {
    return PostStudent(
      name: json['name'],
      age: json['age'],
      city: json['city'],
      batch: json['batch'],
      address: json['address'],
      dateOfbirth: json['dateOfBirth'],
      fatherName: json['fatherName'],
      gender: json['gender'],
      rollNumber: json['rollnumber'],
      degreeStatus: json['degreeStatus'],
      statusCode: json['statusCode'],
      statusMessage: json['statusMessage'],
    );
  }

  Map toMap() {
    var map = new Map();
    map["name"] = name;
    map["age"] = age;
    map["city"] = city;
    map["batch"] = batch;
    map["address"] = address;
    map["dateOfbirth"] = dateOfbirth;
    map["fatherName"] = fatherName;
    map["gender"] = gender;
    map["rollNumber"] = rollNumber;
    map["degreeStatus"] = degreeStatus;
    map["statusCode"] = statusCode;
    map["statusMessage"] = statusMessage;
    return map;
  }
}
