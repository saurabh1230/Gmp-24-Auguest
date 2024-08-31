import 'dart:convert';

class PropertyDetailModel {
  final String id;
  final String uniqueId;
  final String userType;
  final String slug;
  final String title;
  final String description;
  final String metaTitle;
  final String metaDescription;
  final String address;
  final int views;
  final int unit;
  final List<GalleryImage> galleryImages;
  final String videoLink;
  final int room;
  final int space;
  final int bedroom;
  final int bathroom;
  final int floor;
  final int kitchen;
  // final DateTime builtYear;
  final int area;
  final String direction;
  final int price;
  final int marketPrice;
  final bool isFeatured;
  final bool topProperty;
  final DateTime? expiryDate;
  final String status;
  final DateTime createdAt;
  final PropertyType type;
  final PropertyPurpose purpose;
  final PropertyCategory category;
  final List<Amenity> amenities;
  final List<DisplayImage> displayImages;
  final State state;
  final City city;
  final List<dynamic> locality;
  final List<AllImages> allImages;
  final double latitude;
  final double longitude;

  PropertyDetailModel({
    required this.id,
    required this.uniqueId,
    required this.userType,
    required this.slug,
    required this.title,
    required this.description,
    required this.metaTitle,
    required this.metaDescription,
    required this.address,
    required this.views,
    required this.unit,
    required this.galleryImages,
    required this.videoLink,
    required this.room,
    required this.space,
    required this.bedroom,
    required this.bathroom,
    required this.floor,
    required this.kitchen,
    // required this.builtYear,
    required this.area,
    required this.direction,
    required this.price,
    required this.marketPrice,
    required this.isFeatured,
    required this.topProperty,
    this.expiryDate,
    required this.status,
    required this.createdAt,
    required this.type,
    required this.purpose,
    required this.category,
    required this.amenities,
    required this.displayImages,
    required this.state,
    required this.city,
    required this.locality,
    required this.allImages,
    required this.latitude,
    required this.longitude,
  });

  factory PropertyDetailModel.fromJson(Map<String, dynamic> json) => PropertyDetailModel(
    id: json['_id'] ?? '',
    uniqueId: json['unique_id'] ?? '',
    userType: json['user_type'] ?? '',
    slug: json['slug'] ?? '',
    title: json['title'] ?? '',
    description: json['description'] ?? '',
    metaTitle: json['meta_title'] ?? '',
    metaDescription: json['meta_description'] ?? '',
    address: json['address'] ?? '',
    views: json['views'] ?? 0,
    unit: json['unit'] ?? 0,
    galleryImages: json['gallery_images'] != null
        ? List<GalleryImage>.from(json['gallery_images'].map((x) => GalleryImage.fromJson(x)))
        : [],
    videoLink: json['video_link'] ?? '',
    room: json['room'] ?? 0,
    space: json['space'] ?? 0,
    bedroom: json['bedroom'] ?? 0,
    bathroom: json['bathroom'] ?? 0,
    floor: json['floor'] ?? 0,
    kitchen: json['kitchen'] ?? 0,
    area: json['area'] ?? 0,
    direction: json['direction'] ?? '',
    price: json['price'] ?? 0,
    marketPrice: json['market_price'] ?? 0,
    isFeatured: json['is_featured'] ?? false,
    topProperty: json['top_property'] ?? false,
    expiryDate: json['expiry_date'] != null ? DateTime.parse(json['expiry_date']) : null,
    status: json['status'] ?? '',
    createdAt: DateTime.parse(json['created_at'] ?? ''),
    type: json['type_id'] != null ? PropertyType.fromJson(json['type_id']) : PropertyType(id: '', name: ''),
    purpose: json['purpose_id'] != null ? PropertyPurpose.fromJson(json['purpose_id']) : PropertyPurpose(id: '', name: ''),
    category: json['category_id'] != null ? PropertyCategory.fromJson(json['category_id']) : PropertyCategory(id: '', name: ''),
    amenities: json['amenity_id'] != null
        ? List<Amenity>.from(json['amenity_id'].map((x) => Amenity.fromJson(x)))
        : [],
    displayImages: json['display_image_id'] != null
        ? List<DisplayImage>.from(json['display_image_id'].map((x) => DisplayImage.fromJson(x)))
        : [],
    state: json['state_id'] != null ? State.fromJson(json['state_id']) : State(id: '', name: ''),
    city: json['city_id'] != null ? City.fromJson(json['city_id']) : City(id: '', name: ''),
    locality: json['locality_id'] != null ? List<dynamic>.from(json['locality_id']) : [],
    allImages: json['all_images'] != null
        ? List<AllImages>.from((json['all_images'] as List<dynamic>).expand((x) =>
    x is List ? x : [x]
    ).map((x) => AllImages.fromJson(x as Map<String, dynamic>)))
        : [],
    latitude: json['latitude'] ?? 0,
    longitude: json['longitude'] ?? 0,
  );




  Map<String, dynamic> toJson() => {
    '_id': id,
    'unique_id': uniqueId,
    'user_type': userType,
    'slug': slug,
    'title': title,
    'description': description,
    'meta_title': metaTitle,
    'meta_description': metaDescription,
    'address': address,
    'views': views,
    'unit': unit,
    'gallery_images': List<dynamic>.from(galleryImages.map((x) => x.toJson())),
    'video_link': videoLink,
    'room': room,
    'space': space,
    'bedroom': bedroom,
    'bathroom': bathroom,
    'floor': floor,
    'kitchen': kitchen,
    // 'built_year': builtYear.toIso8601String(),
    'area': area,
    'direction': direction,
    'price': price,
    'market_price': marketPrice,
    'is_featured': isFeatured,
    'top_property': topProperty,
    'expiry_date': expiryDate?.toIso8601String(),
    'status': status,
    'created_at': createdAt.toIso8601String(),
    'type': type.toJson(),
    'purpose': purpose.toJson(),
    'category': category.toJson(),
    'amenity': List<dynamic>.from(amenities.map((x) => x.toJson())),
    'display_image': List<dynamic>.from(displayImages.map((x) => x.toJson())),
    'state': state.toJson(),
    'city': city.toJson(),
    'locality': List<dynamic>.from(locality),
    'all_images': List<dynamic>.from(allImages.map((x) => x.toJson())),
    'latitude': latitude,
    'longitude': longitude,
  };
}

class GalleryImage {
  final String id;
  final String image;

  GalleryImage({
    required this.id,
    required this.image,
  });

  factory GalleryImage.fromJson(Map<String, dynamic> json) => GalleryImage(
    id: json['_id'],
    image: json['image'],
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'image': image,
  };
}

class DisplayImage {
  final String id;
  final String image;

  DisplayImage({
    required this.id,
    required this.image,
  });

  factory DisplayImage.fromJson(Map<String, dynamic> json) => DisplayImage(
    id: json['_id'],
    image: json['image'],
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'image': image,
  };
}

class AllImages {
  final String id;
  final String image;

  AllImages({
    required this.id,
    required this.image,
  });

  factory AllImages.fromJson(Map<String, dynamic> json) => AllImages(
    id: json['_id'],
    image: json['image'],
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'image': image,
  };
}

class PropertyType {
  final String id;
  final String name;

  PropertyType({
    required this.id,
    required this.name,
  });

  factory PropertyType.fromJson(Map<String, dynamic> json) => PropertyType(
    id: json['_id'],
    name: json['name'],
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
  };
}

class PropertyPurpose {
  final String id;
  final String name;

  PropertyPurpose({
    required this.id,
    required this.name,
  });

  factory PropertyPurpose.fromJson(Map<String, dynamic> json) => PropertyPurpose(
    id: json['_id'],
    name: json['name'],
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
  };
}

class PropertyCategory {
  final String id;
  final String name;

  PropertyCategory({
    required this.id,
    required this.name,
  });

  factory PropertyCategory.fromJson(Map<String, dynamic> json) => PropertyCategory(
    id: json['_id'],
    name: json['name'],
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
  };
}

class Amenity {
  final String id;
  final String name;

  Amenity({
    required this.id,
    required this.name,
  });

  factory Amenity.fromJson(Map<String, dynamic> json) => Amenity(
    id: json['_id'],
    name: json['name'],
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
  };
}

class State {
  final String id;
  final String name;

  State({
    required this.id,
    required this.name,
  });

  factory State.fromJson(Map<String, dynamic> json) => State(
    id: json['_id'],
    name: json['name'],
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
  };
}

class City {
  final String id;
  final String name;

  City({
    required this.id,
    required this.name,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json['_id'],
    name: json['name'],
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
  };
}
