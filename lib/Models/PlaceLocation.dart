// To parse this JSON data, do
//
//     final welcome = welcomeFromMap(jsonString);

import 'dart:convert';

Welcome welcomeFromMap(String str) => Welcome.fromMap(json.decode(str));

String welcomeToMap(Welcome data) => json.encode(data.toMap());

class Welcome {
    Welcome({
        this.type,
        this.features,
    });

    String type;
    List<Feature> features;

    factory Welcome.fromMap(Map<String, dynamic> json) => Welcome(
        type: json["type"] == null ? null : json["type"],
        features: json["features"] == null ? null : List<Feature>.from(json["features"].map((x) => Feature.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "type": type == null ? null : type,
        "features": features == null ? null : List<dynamic>.from(features.map((x) => x.toMap())),
    };
}

class Feature {
    Feature({
        this.type,
        this.properties,
        this.bbox,
        this.geometry,
    });

    FeatureType type;
    Properties properties;
    List<double> bbox;
    Geometry geometry;

    factory Feature.fromMap(Map<String, dynamic> json) => Feature(
        type: json["type"] == null ? null : featureTypeValues.map[json["type"]],
        properties: json["properties"] == null ? null : Properties.fromMap(json["properties"]),
        bbox: json["bbox"] == null ? null : List<double>.from(json["bbox"].map((x) => x.toDouble())),
        geometry: json["geometry"] == null ? null : Geometry.fromMap(json["geometry"]),
    );

    Map<String, dynamic> toMap() => {
        "type": type == null ? null : featureTypeValues.reverse[type],
        "properties": properties == null ? null : properties.toMap(),
        "bbox": bbox == null ? null : List<dynamic>.from(bbox.map((x) => x)),
        "geometry": geometry == null ? null : geometry.toMap(),
    };
}

class Geometry {
    Geometry({
        this.type,
        this.coordinates,
    });

    GeometryType type;
    List<double> coordinates;

    factory Geometry.fromMap(Map<String, dynamic> json) => Geometry(
        type: json["type"] == null ? null : geometryTypeValues.map[json["type"]],
        coordinates: json["coordinates"] == null ? null : List<double>.from(json["coordinates"].map((x) => x.toDouble())),
    );

    Map<String, dynamic> toMap() => {
        "type": type == null ? null : geometryTypeValues.reverse[type],
        "coordinates": coordinates == null ? null : List<dynamic>.from(coordinates.map((x) => x)),
    };
}

enum GeometryType { POINT }

final geometryTypeValues = EnumValues({
    "Point": GeometryType.POINT
});

class Properties {
    Properties({
        this.datasource,
        this.neighbourhood,
        this.suburb,
        this.city,
        this.state,
        this.postcode,
        this.country,
        this.countryCode,
        this.street,
        this.lon,
        this.lat,
        this.formatted,
        this.addressLine1,
        this.addressLine2,
        this.distance,
        this.rank,
        this.placeId,
        this.name,
        this.county,
        this.resultType,
    });

    Datasource datasource;
    String neighbourhood;
    String suburb;
    String city;
    State state;
    String postcode;
    Country country;
    CountryCode countryCode;
    String street;
    double lon;
    double lat;
    String formatted;
    String addressLine1;
    AddressLine2 addressLine2;
    double distance;
    Rank rank;
    String placeId;
    String name;
    String county;
    String resultType;

    factory Properties.fromMap(Map<String, dynamic> json) => Properties(
        datasource: json["datasource"] == null ? null : Datasource.fromMap(json["datasource"]),
        neighbourhood: json["neighbourhood"] == null ? null : json["neighbourhood"],
        suburb: json["suburb"] == null ? null : json["suburb"],
        city: json["city"] == null ? null : json["city"],
        state: json["state"] == null ? null : stateValues.map[json["state"]],
        postcode: json["postcode"] == null ? null : json["postcode"],
        country: json["country"] == null ? null : countryValues.map[json["country"]],
        countryCode: json["country_code"] == null ? null : countryCodeValues.map[json["country_code"]],
        street: json["street"] == null ? null : json["street"],
        lon: json["lon"] == null ? null : json["lon"].toDouble(),
        lat: json["lat"] == null ? null : json["lat"].toDouble(),
        formatted: json["formatted"] == null ? null : json["formatted"],
        addressLine1: json["address_line1"] == null ? null : json["address_line1"],
        addressLine2: json["address_line2"] == null ? null : addressLine2Values.map[json["address_line2"]],
        distance: json["distance"] == null ? null : json["distance"].toDouble(),
        rank: json["rank"] == null ? null : Rank.fromMap(json["rank"]),
        placeId: json["place_id"] == null ? null : json["place_id"],
        name: json["name"] == null ? null : json["name"],
        county: json["county"] == null ? null : json["county"],
        resultType: json["result_type"] == null ? null : json["result_type"],
    );

    Map<String, dynamic> toMap() => {
        "datasource": datasource == null ? null : datasource.toMap(),
        "neighbourhood": neighbourhood == null ? null : neighbourhood,
        "suburb": suburb == null ? null : suburb,
        "city": city == null ? null : city,
        "state": state == null ? null : stateValues.reverse[state],
        "postcode": postcode == null ? null : postcode,
        "country": country == null ? null : countryValues.reverse[country],
        "country_code": countryCode == null ? null : countryCodeValues.reverse[countryCode],
        "street": street == null ? null : street,
        "lon": lon == null ? null : lon,
        "lat": lat == null ? null : lat,
        "formatted": formatted == null ? null : formatted,
        "address_line1": addressLine1 == null ? null : addressLine1,
        "address_line2": addressLine2 == null ? null : addressLine2Values.reverse[addressLine2],
        "distance": distance == null ? null : distance,
        "rank": rank == null ? null : rank.toMap(),
        "place_id": placeId == null ? null : placeId,
        "name": name == null ? null : name,
        "county": county == null ? null : county,
        "result_type": resultType == null ? null : resultType,
    };
}

enum AddressLine2 { OMDURMAN_SUDAN, KHARTUM_SUDAN, MAKKI_STREET_KHARTUM_SUDAN }

final addressLine2Values = EnumValues({
    "Khartum, Sudan": AddressLine2.KHARTUM_SUDAN,
    "Makki Street, Khartum, Sudan": AddressLine2.MAKKI_STREET_KHARTUM_SUDAN,
    "- Omdurman, Sudan": AddressLine2.OMDURMAN_SUDAN
});

enum Country { SUDAN }

final countryValues = EnumValues({
    "Sudan": Country.SUDAN
});

enum CountryCode { SD }

final countryCodeValues = EnumValues({
    "sd": CountryCode.SD
});

class Datasource {
    Datasource({
        this.sourcename,
        this.attribution,
        this.license,
        this.url,
    });

    Sourcename sourcename;
    Attribution attribution;
    License license;
    String url;

    factory Datasource.fromMap(Map<String, dynamic> json) => Datasource(
        sourcename: json["sourcename"] == null ? null : sourcenameValues.map[json["sourcename"]],
        attribution: json["attribution"] == null ? null : attributionValues.map[json["attribution"]],
        license: json["license"] == null ? null : licenseValues.map[json["license"]],
        url: json["url"] == null ? null : json["url"],
    );

    Map<String, dynamic> toMap() => {
        "sourcename": sourcename == null ? null : sourcenameValues.reverse[sourcename],
        "attribution": attribution == null ? null : attributionValues.reverse[attribution],
        "license": license == null ? null : licenseValues.reverse[license],
        "url": url == null ? null : url,
    };
}

enum Attribution { OPEN_STREET_MAP_CONTRIBUTORS }

final attributionValues = EnumValues({
    "© OpenStreetMap contributors": Attribution.OPEN_STREET_MAP_CONTRIBUTORS
});

enum License { OPEN_DATABASE_LICENCE }

final licenseValues = EnumValues({
    "Open Database Licence": License.OPEN_DATABASE_LICENCE
});

enum Sourcename { OPENSTREETMAP }

final sourcenameValues = EnumValues({
    "openstreetmap": Sourcename.OPENSTREETMAP
});

class Rank {
    Rank({
        this.importance,
        this.popularity,
    });

    double importance;
    double popularity;

    factory Rank.fromMap(Map<String, dynamic> json) => Rank(
        importance: json["importance"] == null ? null : json["importance"].toDouble(),
        popularity: json["popularity"] == null ? null : json["popularity"].toDouble(),
    );

    Map<String, dynamic> toMap() => {
        "importance": importance == null ? null : importance,
        "popularity": popularity == null ? null : popularity,
    };
}

enum State { KHARTUM }

final stateValues = EnumValues({
    "Khartum": State.KHARTUM
});

enum FeatureType { FEATURE }

final featureTypeValues = EnumValues({
    "Feature": FeatureType.FEATURE
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
