class Student {
  String? name;
  String? age;
  String? city;
  int? id;
  String? batch;
  String? address;
  String? dateOfBirth;
  String? fatherName;
  String? gender;
  String? rollNumber;
  String? degreeStatus;

  Student(
      {this.name,
      this.age,
      this.city,
      this.id,
      this.batch,
      this.address,
      this.dateOfBirth,
      this.fatherName,
      this.gender,
      this.rollNumber,
      this.degreeStatus});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      name: json['name'],
      age: json['age'],
      city: json['city'],
      id: json['id'],
      batch: json['batch'],
      address: json['address'],
      dateOfBirth: json['dateOfBirth'],
      fatherName: json['fatherName'],
      gender: json['gender'],
      rollNumber: json['rollNumber'],
      degreeStatus: json['degreeStatus'],
    );
  }
}
