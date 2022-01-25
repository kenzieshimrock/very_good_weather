import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

/// Location Type enumeration
enum LocationType {
  /// city
  @JsonValue('City')
  city,

  /// region
  @JsonValue('Region')
  region,

  /// state
  @JsonValue('State')
  state,

  /// province
  @JsonValue('Province')
  province,

  /// country
  @JsonValue('Country')
  country,

  /// continent
  @JsonValue('Continent')
  continent
}

/// Location class model
@JsonSerializable()
class Location {
  /// Location  class constructor
  const Location({
    required this.title,
    required this.locationType,
    required this.latLng,
    required this.woeid,
  });

  /// Json Deserialization
  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  /// Name of the location
  final String title;

  /// City|Region/State/Province|Country|Continent
  final LocationType locationType;

  ///Latitude/Longitude values
  @JsonKey(name: 'latt_long')
  @LatLngConverter()
  final LatLng latLng;

  /// Where on Earth ID
  final int woeid;
}

/// LatLng model class
class LatLng {
  /// LatLng class constructor
  const LatLng({
    required this.latitude,
    required this.longitude,
  });

  /// latitude value
  final double latitude;

  /// longitude value
  final double longitude;
}

/// Latitude/Longitude convertor
class LatLngConverter
    implements JsonConverter<LatLng, String> {
  /// LatLngConverter constructor
  const LatLngConverter();

  @override
  String toJson(LatLng latLng) {
    return '${latLng.latitude},${latLng.longitude}';
  }

  @override
  LatLng fromJson(String jsonString) {
    final parts = jsonString.split(',');
    return LatLng(
      latitude: double.tryParse(parts[0]) ?? 0,
      longitude: double.tryParse(parts[1]) ?? 0,
    );
  }
}
