class CountriesAndCities {
  List<Data>? data;

  CountriesAndCities({this.data});

  factory CountriesAndCities.fromJson(Map<String, dynamic> json) {
    return CountriesAndCities(
        data: List<Data>.from(
            (json['data'] as List).map((x) => Data.fromJson(x))));
  }
}

class Data {
  String? country;
  List<String>? cities;

  Data({this.country, this.cities});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
        country: json['country'],
        cities: (json['cities'] as List).map<String>((city) => city).toList());
  }
}
