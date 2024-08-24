class SearchPropertyModel {
  String sId;
  String uniqueId;
  String userType;
  String slug;
  String title;
  String description;
  String metaTitle;
  String metaDescription;
  String address;
  int views;
  int unit;
  List<GalleryImage> galleryImages;  // Changed from List<Null> to List<GalleryImage>
  String videoLink;
  int room;
  int space;
  int bedroom;
  int bathroom;
  int floor;
  int kitchen;
  // int builtYear;
  int area;
  String direction;
  int price;
  int marketPrice;
  bool isFeatured;
  bool topProperty;
  DateTime expiryDate;  // Changed String to DateTime
  String status;
  DateTime createdAt;  // Changed String to DateTime
  Purpose purpose;
  Purpose category;
  List<Amenity> amenity;
  List<DisplayImage> displayImage;
  Purpose state;
  Purpose city;
  List<Locality> locality;
  // bool bookmarked;

  SearchPropertyModel({
    required this.sId,
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
    required this.expiryDate,
    required this.status,
    required this.createdAt,
    required this.purpose,
    required this.category,
    required this.amenity,
    required this.displayImage,
    required this.state,
    required this.city,
    required this.locality,
    // required this.bookmarked,
  });

  factory SearchPropertyModel.fromJson(Map<String, dynamic> json) {
    return SearchPropertyModel(
      sId: json['_id'],
      uniqueId: json['unique_id'],
      userType: json['user_type'],
      slug: json['slug'],
      title: json['title'],
      description: json['description'],
      metaTitle: json['meta_title'],
      metaDescription: json['meta_description'],
      address: json['address'],
      views: json['views'],
      unit: json['unit'],
      galleryImages: (json['gallery_images'] as List<dynamic>)
          .map((item) => GalleryImage.fromJson(item as Map<String, dynamic>))
          .toList(),
      videoLink: json['video_link'],
      room: json['room'],
      space: json['space'],
      bedroom: json['bedroom'],
      bathroom: json['bathroom'],
      floor: json['floor'],
      kitchen: json['kitchen'],
      // builtYear: json['built_year'],
      area: json['area'],
      direction: json['direction'],
      price: json['price'],
      marketPrice: json['market_price'],
      isFeatured: json['is_featured'],
      topProperty: json['top_property'],
      expiryDate: DateTime.parse(json['expiry_date']),
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      purpose: Purpose.fromJson(json['purpose']),
      category: Purpose.fromJson(json['category']),
      amenity: (json['amenity'] as List<dynamic>)
          .map((item) => Amenity.fromJson(item as Map<String, dynamic>))
          .toList(),
      displayImage: (json['display_image'] as List<dynamic>)
          .map((item) => DisplayImage.fromJson(item as Map<String, dynamic>))
          .toList(),
      state: Purpose.fromJson(json['state']),
      city: Purpose.fromJson(json['city']),
      locality: (json['locality'] as List<dynamic>)
          .map((item) => Locality.fromJson(item as Map<String, dynamic>))
          .toList(),
      // bookmarked: json['bookmarked'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
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
      'gallery_images': galleryImages.map((e) => e.toJson()).toList(),
      'video_link': videoLink,
      'room': room,
      'space': space,
      'bedroom': bedroom,
      'bathroom': bathroom,
      'floor': floor,
      'kitchen': kitchen,
      // 'built_year': builtYear,
      'area': area,
      'direction': direction,
      'price': price,
      'market_price': marketPrice,
      'is_featured': isFeatured,
      'top_property': topProperty,
      'expiry_date': expiryDate.toIso8601String(),
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'purpose': purpose.toJson(),
      'category': category.toJson(),
      'amenity': amenity.map((e) => e.toJson()).toList(),
      'display_image': displayImage.map((e) => e.toJson()).toList(),
      'state': state.toJson(),
      'city': city.toJson(),
      'locality': locality.map((e) => e.toJson()).toList(),
      // 'bookmarked': bookmarked,
    };
  }
}

class GalleryImage {
  String sId;
  String image;

  GalleryImage({
    required this.sId,
    required this.image,
  });

  factory GalleryImage.fromJson(Map<String, dynamic> json) {
    return GalleryImage(
      sId: json['_id'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'image': image,
    };
  }
}

class Purpose {
  String sId;
  String name;

  Purpose({
    required this.sId,
    required this.name,
  });

  factory Purpose.fromJson(Map<String, dynamic> json) {
    return Purpose(
      sId: json['_id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'name': name,
    };
  }
}

class Amenity {
  String sId;
  String name;

  Amenity({
    required this.sId,
    required this.name,
  });

  factory Amenity.fromJson(Map<String, dynamic> json) {
    return Amenity(
      sId: json['_id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'name': name,
    };
  }
}

class DisplayImage {
  String sId;
  String image;

  DisplayImage({
    required this.sId,
    required this.image,
  });

  factory DisplayImage.fromJson(Map<String, dynamic> json) {
    return DisplayImage(
      sId: json['_id'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'image': image,
    };
  }
}

class Locality {
  String sId;
  String name;

  Locality({
    required this.sId,
    required this.name,
  });

  factory Locality.fromJson(Map<String, dynamic> json) {
    return Locality(
      sId: json['_id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'name': name,
    };
  }
}
