class CitiesModel {
  bool? error;
  String? msg;
  List<String>? cities;

  CitiesModel({
    this.error,
    this.msg,
    this.cities,
  });

  factory CitiesModel.fromJson(Map<String, dynamic> json) {
    return CitiesModel(
      error: json['error'],
      msg: json['msg'],
      cities: json['data'] != null
          ? (json['data'] as List).map<String>((data) => data).toList()
          : null,
    );
  }
}
