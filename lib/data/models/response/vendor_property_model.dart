import 'dart:convert';

class VendorPropertyModel {
  final String? id;
  final String? uniqueId;
  final String? userType;
  final String? slug;
  final String? title;
  final String? description;
  final String? metaTitle;
  final String? metaDescription;
  final String? address;
  final int? views;
  final int? unit;
  final List<GalleryImage>? galleryImages;
  final String? videoLink;
  final int? room;
  final int? space;
  final int? bedroom;
  final int? bathroom;
  final int? floor;
  final int? kitchen;
  final DateTime? builtYear;
  final int? area;
  final String? direction;
  final int? price;
  final int? marketPrice;
  final bool? isFeatured;
  final bool? topProperty;
  final DateTime? expiryDate;
  final String? status;
  final DateTime? createdAt;
  final User? user;
  final Type? type;
  final Purpose? purpose;
  final Category? category;
  final List<Amenity>? amenities;
  final List<DisplayImage>? displayImage;
  final StateModel? state;
  final City? city;
  final List<Locality>? localities;
  final List<AllImage>? allImages;

  VendorPropertyModel({
    this.id,
    this.uniqueId,
    this.userType,
    this.slug,
    this.title,
    this.description,
    this.metaTitle,
    this.metaDescription,
    this.address,
    this.views,
    this.unit,
    this.galleryImages,
    this.videoLink,
    this.room,
    this.space,
    this.bedroom,
    this.bathroom,
    this.floor,
    this.kitchen,
    this.builtYear,
    this.area,
    this.direction,
    this.price,
    this.marketPrice,
    this.isFeatured,
    this.topProperty,
    this.expiryDate,
    this.status,
    this.createdAt,
    this.user,
    this.type,
    this.purpose,
    this.category,
    this.amenities,
    this.displayImage,
    this.state,
    this.city,
    this.localities,
    this.allImages,
  });

  factory VendorPropertyModel.fromJson(Map<String, dynamic> json) {
    return VendorPropertyModel(
      id: json['_id'],
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
      galleryImages: (json['gallery_images'] as List<dynamic>?)
          ?.map((e) => GalleryImage.fromJson(e))
          .toList(),
      videoLink: json['video_link'],
      room: json['room'],
      space: json['space'],
      bedroom: json['bedroom'],
      bathroom: json['bathroom'],
      floor: json['floor'],
      kitchen: json['kitchen'],
      builtYear: json['built_year'] != null
          ? DateTime.parse(json['built_year'])
          : null,
      area: json['area'],
      direction: json['direction'],
      price: json['price'],
      marketPrice: json['market_price'],
      isFeatured: json['is_featured'],
      topProperty: json['top_property'],
      expiryDate: json['expiry_date'] != null
          ? DateTime.parse(json['expiry_date'])
          : null,
      status: json['status'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      type: json['type'] != null ? Type.fromJson(json['type']) : null,
      purpose: json['purpose'] != null ? Purpose.fromJson(json['purpose']) : null,
      category:
      json['category'] != null ? Category.fromJson(json['category']) : null,
      amenities: (json['amenity'] as List<dynamic>?)
          ?.map((e) => Amenity.fromJson(e))
          .toList(),
      displayImage: (json['display_image'] as List<dynamic>?)
          ?.map((e) => DisplayImage.fromJson(e))
          .toList(),
      state: json['state'] != null ? StateModel.fromJson(json['state']) : null,
      city: json['city'] != null ? City.fromJson(json['city']) : null,
      localities: (json['locality'] as List<dynamic>?)
          ?.map((e) => Locality.fromJson(e))
          .toList(),
      allImages: (json['all_images'] as List<dynamic>?)
          ?.map((e) => AllImage.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
      'gallery_images': galleryImages?.map((e) => e.toJson()).toList(),
      'video_link': videoLink,
      'room': room,
      'space': space,
      'bedroom': bedroom,
      'bathroom': bathroom,
      'floor': floor,
      'kitchen': kitchen,
      'built_year': builtYear?.toIso8601String(),
      'area': area,
      'direction': direction,
      'price': price,
      'market_price': marketPrice,
      'is_featured': isFeatured,
      'top_property': topProperty,
      'expiry_date': expiryDate?.toIso8601String(),
      'status': status,
      'created_at': createdAt?.toIso8601String(),
      'user': user?.toJson(),
      'type': type?.toJson(),
      'purpose': purpose?.toJson(),
      'category': category?.toJson(),
      'amenity': amenities?.map((e) => e.toJson()).toList(),
      'display_image': displayImage?.map((e) => e.toJson()).toList(),
      'state': state?.toJson(),
      'city': city?.toJson(),
      'locality': localities?.map((e) => e.toJson()).toList(),
      'all_images': allImages?.map((e) => e.toJson()).toList(),
    };
  }
}

class GalleryImage {
  final String? id;
  final String? image;

  GalleryImage({this.id, this.image});

  factory GalleryImage.fromJson(Map<String, dynamic> json) {
    return GalleryImage(
      id: json['_id'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'image': image,
    };
  }
}

class User {
  final String? id;
  final String? name;
  final String? userType;

  User({this.id, this.name, this.userType});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      userType: json['user_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'user_type': userType,
    };
  }
}

class Type {
  final String? id;
  final String? name;

  Type({this.id, this.name});

  factory Type.fromJson(Map<String, dynamic> json) {
    return Type(
      id: json['_id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
    };
  }
}

class Purpose {
  final String? id;
  final String? name;

  Purpose({this.id, this.name});

  factory Purpose.fromJson(Map<String, dynamic> json) {
    return Purpose(
      id: json['_id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
    };
  }
}

class Category {
  final String? id;
  final String? name;

  Category({this.id, this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
    };
  }
}

class Amenity {
  final String? id;
  final String? name;

  Amenity({this.id, this.name});

  factory Amenity.fromJson(Map<String, dynamic> json) {
    return Amenity(
      id: json['_id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
    };
  }
}

class DisplayImage {
  final String? id;
  final String? image;

  DisplayImage({this.id, this.image});

  factory DisplayImage.fromJson(Map<String, dynamic> json) {
    return DisplayImage(
      id: json['_id'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'image': image,
    };
  }
}

class StateModel {
  final String? id;
  final String? name;

  StateModel({this.id, this.name});

  factory StateModel.fromJson(Map<String, dynamic> json) {
    return StateModel(
      id: json['_id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
    };
  }
}

class City {
  final String? id;
  final String? name;

  City({this.id, this.name});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['_id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
    };
  }
}

class Locality {
  final String? id;
  final String? name;

  Locality({this.id, this.name});

  factory Locality.fromJson(Map<String, dynamic> json) {
    return Locality(
      id: json['_id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
    };
  }
}

class AllImage {
  final String? id;
  final String? image;

  AllImage({this.id, this.image});

  factory AllImage.fromJson(Map<String, dynamic> json) {
    return AllImage(
      id: json['_id'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'image': image,
    };
  }
}
