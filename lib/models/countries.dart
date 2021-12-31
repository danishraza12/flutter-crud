class CountryModel {
  List<String>? countries;

  CountryModel({
    this.countries,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      countries: json['countries'] != null
          ? (json['countries'] as List).map<String>((data) => data).toList()
          : null,
    );
  }
}

class Countries {
  String? name;

  Countries({this.name});

  factory Countries.fromJson(Map<String, dynamic> json) => Countries(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
