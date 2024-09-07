
class PropertyLatLngModel {
  final String id;
  final String title;
  final String description;
  final int price;
  final int marketPrice;
  final double latitude;
  final double longitude;

  PropertyLatLngModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.marketPrice,
    required this.latitude,
    required this.longitude,
  });

  // Convert JSON to Property instance
  factory PropertyLatLngModel.fromJson(Map<String, dynamic> json) {
    return PropertyLatLngModel(
      id: json['_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      price: json['price'] as int,
      marketPrice: json['market_price'] as int,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
    );
  }

  // Convert Property instance to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'price': price,
      'market_price': marketPrice,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
