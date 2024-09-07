class InquiryModel {
  String? sId;
  String? name;
  String? phoneNumber;
  String? email;
  String? message;
  String? date;
  String? time;
  String? status;
  String? createdAt;
  Vender? vender;
  Property? property;

  InquiryModel({
    this.sId,
    this.name,
    this.phoneNumber,
    this.email,
    this.message,
    this.date,
    this.time,
    this.status,
    this.createdAt,
    this.vender,
    this.property,
  });

  factory InquiryModel.fromJson(Map<String, dynamic> json) {
    return InquiryModel(
      sId: json['_id'],
      name: json['name'],
      phoneNumber: json['phone_number'].toString(),
      email: json['email'],
      message: json['message'],
      date: json['date'],
      time: json['time'],
      status: json['status'],
      createdAt: json['created_at'],
      vender: json['vender'] != null ? Vender.fromJson(json['vender']) : null,
      property:
      json['property'] != null ? Property.fromJson(json['property']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['name'] = name;
    data['phone_number'] = phoneNumber;
    data['email'] = email;
    data['message'] = message;
    data['date'] = date;
    data['time'] = time;
    data['status'] = status;
    data['created_at'] = createdAt;
    if (vender != null) {
      data['vender'] = vender!.toJson();
    }
    if (property != null) {
      data['property'] = property!.toJson();
    }
    return data;
  }
}

class Vender {
  String? sId;
  String? name;
  String? phoneNumber;
  String? profileImage;

  Vender({this.sId, this.name, this.phoneNumber, this.profileImage});

  factory Vender.fromJson(Map<String, dynamic> json) {
    return Vender(
      sId: json['_id'],
      name: json['name'],
      phoneNumber: json['phone_number'].toString(),
      profileImage: json['profile_image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'name': name,
      'phone_number': phoneNumber,
      'profile_image': profileImage,
    };
  }
}

class Property {
  String? sId;
  String? uniqueId;
  String? userType;
  String? slug;
  String? title;
  String? description;
  String? metaTitle;
  String? metaDescription;
  String? address;
  int? views;
  int? unit;
  List<GalleryImages>? galleryImages;
  String? videoLink;
  int? room;
  int? space;
  int? bedroom;
  int? bathroom;
  int? floor;
  int? kitchen;
  // int? builtYear;
  int? area;
  String? direction;
  int? price;
  int? marketPrice;
  bool? isFeatured;
  bool? topProperty;
  String? expiryDate;
  String? status;
  String? createdAt;
  Type? type;
  Type? purpose;
  Type? category;
  List<DisplayImage>? displayImage;
  List<AllImages>? allImages;

  Property({
    this.sId,
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
    // this.builtYear,
    this.area,
    this.direction,
    this.price,
    this.marketPrice,
    this.isFeatured,
    this.topProperty,
    this.expiryDate,
    this.status,
    this.createdAt,
    this.type,
    this.purpose,
    this.category,
    this.displayImage,
    this.allImages,
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
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
      galleryImages: json['gallery_images'] != null
          ? List<GalleryImages>.from(
          json['gallery_images'].map((v) => GalleryImages.fromJson(v)))
          : null,
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
      expiryDate: json['expiry_date'],
      status: json['status'],
      createdAt: json['created_at'],
      type: json['type'] != null ? Type.fromJson(json['type']) : null,
      purpose: json['purpose'] != null ? Type.fromJson(json['purpose']) : null,
      category:
      json['category'] != null ? Type.fromJson(json['category']) : null,
      displayImage: json['display_image'] != null
          ? List<DisplayImage>.from(
          json['display_image'].map((v) => DisplayImage.fromJson(v)))
          : null,
      allImages: json['all_images'] != null
          ? List<AllImages>.from(
          json['all_images'].map((v) => AllImages.fromJson(v)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['unique_id'] = uniqueId;
    data['user_type'] = userType;
    data['slug'] = slug;
    data['title'] = title;
    data['description'] = description;
    data['meta_title'] = metaTitle;
    data['meta_description'] = metaDescription;
    data['address'] = address;
    data['views'] = views;
    data['unit'] = unit;
    if (galleryImages != null) {
      data['gallery_images'] = galleryImages!.map((v) => v.toJson()).toList();
    }
    data['video_link'] = videoLink;
    data['room'] = room;
    data['space'] = space;
    data['bedroom'] = bedroom;
    data['bathroom'] = bathroom;
    data['floor'] = floor;
    data['kitchen'] = kitchen;
    // data['built_year'] = builtYear;
    data['area'] = area;
    data['direction'] = direction;
    data['price'] = price;
    data['market_price'] = marketPrice;
    data['is_featured'] = isFeatured;
    data['top_property'] = topProperty;
    data['expiry_date'] = expiryDate;
    data['status'] = status;
    data['created_at'] = createdAt;
    if (type != null) {
      data['type'] = type!.toJson();
    }
    if (purpose != null) {
      data['purpose'] = purpose!.toJson();
    }
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (displayImage != null) {
      data['display_image'] =
          displayImage!.map((v) => v.toJson()).toList();
    }
    if (allImages != null) {
      data['all_images'] = allImages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GalleryImages {
  String? sId;
  String? image;

  GalleryImages({this.sId, this.image});

  factory GalleryImages.fromJson(Map<String, dynamic> json) {
    return GalleryImages(
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

class Type {
  String? sId;
  String? name;

  Type({this.sId, this.name});

  factory Type.fromJson(Map<String, dynamic> json) {
    return Type(
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
  String? sId;
  String? image;

  DisplayImage({this.sId, this.image});

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

class AllImages {
  String? sId;
  String? image;

  AllImages({this.sId, this.image});

  factory AllImages.fromJson(Map<String, dynamic> json) {
    return AllImages(
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
