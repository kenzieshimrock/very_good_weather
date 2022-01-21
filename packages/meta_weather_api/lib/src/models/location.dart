import 'package:json_annotation/json_annotation.dart';

/*
  Part keyword splits part of library out into anothr file.
  Todo: question: would VGV advise using 'part' or consolidating all of library into a single file?
 */

part 'location.g.dart';

/*
 The location.dart model should store data returned by location API which looks like:
{
  "title": "London",
  "location_type": "City",
  "woeid": 44418,
  "latt_long": "51.506321,-0.12714",
}
 */

/*
  - WeatherState enumeration to store location type constants.
  - @JsonValue annotation provides string representations of field values
 */
enum LocationType {
  @JsonValue("City")
  city,
  @JsonValue("Region")
  region,
  @JsonValue("State")
  state,
  @JsonValue("Province")
  province,
  @JsonValue("Country")
  country,
  @JsonValue("Continent")
  continent
}

/*
  - @JsonSerializable() annotation labels class that can be serialized
 */
@JsonSerializable()
class Location {
  const Location({
    required this.title,
    required this.locationType,
    required this.latLng,
    required this.woeid,
  });

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);
  final String title;
  final LocationType locationType;

  // @JsonKey annotation provides string representations of field names
  @JsonKey(name: 'latt_long')
  @LatLngConverter()
  final LatLng latLng;
  final int woeid;
}

class LatLng {
  const LatLng({required this.latitude, required this.longitude});

  final double latitude;
  final double longitude;
}

class LatLngConverter implements JsonConverter<LatLng, String> {
  const LatLngConverter();


  // Serializes latitude and longitude values to json format
  @override
  String toJson(LatLng latLng) {
    return '${latLng.latitude},${latLng.longitude}';
  }

  // Retrieves and assigns latitude and longitute values from json object
  @override
  LatLng fromJson(String jsonString) {
    final parts = jsonString.split(',');
    return LatLng(
      latitude: double.tryParse(parts[0]) ?? 0,
      longitude: double.tryParse(parts[1]) ?? 0,
    );
  }

}