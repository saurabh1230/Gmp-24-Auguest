class LocalityMapData {
  final String name;
  final double lat;
  final double lng;

  LocalityMapData({
    required this.name,
    required this.lat,
    required this.lng,
  });

  factory LocalityMapData.fromJson(Map<String, dynamic> json) {
    return LocalityMapData(
      name: json['name'],
      lat: json['lat'],
      lng: json['lng'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'lat': lat,
      'lng': lng,
    };
  }
}
