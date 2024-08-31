class TypeDataModel {
  List<NearbyState>? nearbyState;
  List<NearbyLocations>? nearbyLocations;
  int? propertyMaxPrice;
  List<PropertyPurposes>? propertyPurposes;
  List<PropertyTypes>? propertyTypes;
  List<PropertyAmenities>? propertyAmenities;
  List<PropertyCategory>? propertyCategory;

  TypeDataModel(
      {this.nearbyState,
        this.nearbyLocations,
        this.propertyMaxPrice,
        this.propertyPurposes,
        this.propertyTypes,
        this.propertyAmenities,
        this.propertyCategory,
      });

  TypeDataModel.fromJson(Map<String, dynamic> json) {
    if (json['nearby_state'] != null) {
      nearbyState = <NearbyState>[];
      json['nearby_state'].forEach((v) {
        nearbyState!.add(new NearbyState.fromJson(v));
      });
    }
    if (json['nearby_locations'] != null) {
      nearbyLocations = <NearbyLocations>[];
      json['nearby_locations'].forEach((v) {
        nearbyLocations!.add(new NearbyLocations.fromJson(v));
      });
    }
    propertyMaxPrice = json['property_max_price'];
    if (json['property_purposes'] != null) {
      propertyPurposes = <PropertyPurposes>[];
      json['property_purposes'].forEach((v) {
        propertyPurposes!.add(new PropertyPurposes.fromJson(v));
      });
    }
    if (json['property_types'] != null) {
      propertyTypes = <PropertyTypes>[];
      json['property_types'].forEach((v) {
        propertyTypes!.add(new PropertyTypes.fromJson(v));
      });
    }
    if (json['property_amenities'] != null) {
      propertyAmenities = <PropertyAmenities>[];
      json['property_amenities'].forEach((v) {
        propertyAmenities!.add(new PropertyAmenities.fromJson(v));
      });
    }
    if (json['property_category'] != null) {
      propertyCategory = <PropertyCategory>[];
      json['property_category'].forEach((v) {
        propertyCategory!.add(new PropertyCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.nearbyState != null) {
      data['nearby_state'] = this.nearbyState!.map((v) => v.toJson()).toList();
    }
    if (this.nearbyLocations != null) {
      data['nearby_locations'] =
          this.nearbyLocations!.map((v) => v.toJson()).toList();
    }
    data['property_max_price'] = this.propertyMaxPrice;
    if (this.propertyPurposes != null) {
      data['property_purposes'] =
          this.propertyPurposes!.map((v) => v.toJson()).toList();
    }
    if (this.propertyTypes != null) {
      data['property_types'] =
          this.propertyTypes!.map((v) => v.toJson()).toList();
    }
    if (this.propertyAmenities != null) {
      data['property_amenities'] =
          this.propertyAmenities!.map((v) => v.toJson()).toList();
    }
    if (this.propertyCategory != null) {
      data['property_category'] =
          this.propertyCategory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NearbyState {
  String? sId;
  String? name;
  String? status;
  String? createdAt;

  NearbyState({this.sId, this.name, this.status, this.createdAt});

  NearbyState.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class PropertyPurposes {
  String? sId;
  String? name;
  String? slug;
  String? status;
  String? createdAt;

  PropertyPurposes(
      {this.sId, this.name, this.slug, this.status, this.createdAt});

  PropertyPurposes.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    slug = json['slug'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class NearbyLocations {
  String? sId;
  String? name;
  String? status;
  String? createdAt;

  NearbyLocations({this.sId, this.name, this.status, this.createdAt});

  NearbyLocations.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class PropertyAmenities {
  String? sId;
  String? name;
  String? status;
  String? createdAt;

  PropertyAmenities({this.sId, this.name, this.status, this.createdAt});

  PropertyAmenities.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class PropertyTypes {
  String? sId;
  String? name;
  String? slug;
  String? status;
  String? createdAt;
  String? image;

  PropertyTypes({this.sId, this.name, this.slug, this.status, this.createdAt,this.image});

  PropertyTypes.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    slug = json['slug'];
    status = json['status'];
    createdAt = json['created_at'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['image'] = this.image;
    return data;
  }


}

class PropertyCategory {
  String? sId;
  String? name;
  String? slug;
  String? status;
  String? createdAt;

  PropertyCategory({this.sId, this.name, this.slug, this.status, this.createdAt});

  PropertyCategory.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    slug = json['slug'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }


}