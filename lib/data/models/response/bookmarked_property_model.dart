import 'dart:convert';

// Assuming you have the required nested models
// class BookmarkPropertyModel {
//   final BookmarkProperty property;
//
//   BookmarkPropertyModel({
//     required this.property,
//   });
//
//   factory BookmarkPropertyModel.fromJson(Map<String, dynamic> json) => BookmarkPropertyModel(
//     property: BookmarkProperty.fromJson(json['property']),
//   );
//
//   Map<String, dynamic> toJson() => {
//     'property': property.toJson(),
//   };
// }

class BookmarkPropertyModel {
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
  final String videoLink;
  final int room;
  final int space;
  final int bedroom;
  final int bathroom;
  final int floor;
  final int kitchen;
  final int area;
  final String direction;
  final int price;
  final int marketPrice;
  final bool isFeatured;
  final bool topProperty;
  final String status;
  final List<DisplayImage> displayImages;
  final List<AllImage> allImages;
  final PropertyType type;
  final PropertyPurpose purpose;
  final PropertyCategory category;

  BookmarkPropertyModel({
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
    required this.videoLink,
    required this.room,
    required this.space,
    required this.bedroom,
    required this.bathroom,
    required this.floor,
    required this.kitchen,
    required this.area,
    required this.direction,
    required this.price,
    required this.marketPrice,
    required this.isFeatured,
    required this.topProperty,
    required this.status,
    required this.displayImages,
    required this.allImages,
    required this.type,
    required this.purpose,
    required this.category,
  });

  factory BookmarkPropertyModel.fromJson(Map<String, dynamic> json) => BookmarkPropertyModel(
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
    videoLink: json['video_link'],
    room: json['room'],
    space: json['space'],
    bedroom: json['bedroom'],
    bathroom: json['bathroom'],
    floor: json['floor'],
    kitchen: json['kitchen'],
    area: json['area'],
    direction: json['direction'],
    price: json['price'],
    marketPrice: json['market_price'],
    isFeatured: json['is_featured'],
    topProperty: json['top_property'],
    status: json['status'],
    displayImages: List<DisplayImage>.from(json['display_image'].map((x) => DisplayImage.fromJson(x))),
    allImages: List<AllImage>.from(json['all_images'].map((x) => AllImage.fromJson(x))),
    type: PropertyType.fromJson(json['type']),
    purpose: PropertyPurpose.fromJson(json['purpose']),
    category: PropertyCategory.fromJson(json['category']),
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
    'video_link': videoLink,
    'room': room,
    'space': space,
    'bedroom': bedroom,
    'bathroom': bathroom,
    'floor': floor,
    'kitchen': kitchen,
    'area': area,
    'direction': direction,
    'price': price,
    'market_price': marketPrice,
    'is_featured': isFeatured,
    'top_property': topProperty,
    'status': status,
    'display_image': List<dynamic>.from(displayImages.map((x) => x.toJson())),
    'all_images': List<dynamic>.from(allImages.map((x) => x.toJson())),
    'type': type.toJson(),
    'purpose': purpose.toJson(),
    'category': category.toJson(),
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

class AllImage {
  final String id;
  final String image;

  AllImage({
    required this.id,
    required this.image,
  });

  factory AllImage.fromJson(Map<String, dynamic> json) => AllImage(
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
