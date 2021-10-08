// class PlacePredictions {
//   String name;
//   String street;
//   String city;
//   PlacePredictions({this.name, this.street, this.city});
//   PlacePredictions.fromJson(Map<String, dynamic> json) {
//     name = json["name"];
//     street = json["street"];
//     city = json["city"];

//   }
// }

class Properties {
  Properties({this.name, this.street, this.city, this.placeId});

  String name;
  String street;
  String city;
  String placeId;

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        name: json["properties"]["address_line1"] == null
            ? null
            : json["properties"]["address_line1"],
        street: json["properties"]["address_line2"] == null
            ? null
            : json["properties"]["address_line2"],
        city: json["properties"]["city"] == null
            ? null
            : json["properties"]["city"],
        placeId: json["properties"]["place_id"] == null ? null : json["properties"]["place_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "street": street == null ? null : street,
        "city": city == null ? null : city,
      };
}
