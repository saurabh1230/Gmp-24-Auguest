

// class SearchSuggestionModel {
//   List<dynamic> property;
//   List<Item> type;
//   List<Item> category;
//   List<Item> purpose;
//   List<Item> state;
//   List<Item> city;
//   List<Item> locality;
//
//   SearchSuggestionModel({
//     required this.property,
//     required this.type,
//     required this.category,
//     required this.purpose,
//     required this.state,
//     required this.city,
//     required this.locality,
//   });
//
//   factory SearchSuggestionModel.fromJson(Map<String, dynamic> json) => SearchSuggestionModel(
//     property: List<dynamic>.from(json["property"].map((x) => x)),
//     type: List<Item>.from(json["type"].map((x) => Item.fromJson(x))),
//     category: List<Item>.from(json["category"].map((x) => Item.fromJson(x))),
//     purpose: List<Item>.from(json["purpose"].map((x) => Item.fromJson(x))),
//     state: List<Item>.from(json["state"].map((x) => Item.fromJson(x))),
//     city: List<Item>.from(json["city"].map((x) => Item.fromJson(x))),
//     locality: List<Item>.from(json["locality"].map((x) => Item.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "property": List<dynamic>.from(property.map((x) => x)),
//     "type": List<dynamic>.from(type.map((x) => x.toJson())),
//     "category": List<dynamic>.from(category.map((x) => x.toJson())),
//     "purpose": List<dynamic>.from(purpose.map((x) => x.toJson())),
//     "state": List<dynamic>.from(state.map((x) => x.toJson())),
//     "city": List<dynamic>.from(city.map((x) => x.toJson())),
//     "locality": List<dynamic>.from(locality.map((x) => x.toJson())),
//   };
// }
//
// class Item {
//   String id;
//   String name;
//
//   Item({
//     required this.id,
//     required this.name,
//   });
//
//   factory Item.fromJson(Map<String, dynamic> json) => Item(
//     id: json["_id"],
//     name: json["name"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "name": name,
//   };
// }


class SuggestState {
  final String id;
  final String name;

  SuggestState({
    required this.id,
    required this.name,
  });

  // Factory constructor to create an instance of Region from JSON
  factory SuggestState.fromJson(Map<String, dynamic> json) {
    return SuggestState(
      id: json['_id'] as String,
      name: json['name'] as String,
    );
  }

  // Method to convert an instance of Region to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
    };
  }
}

class SuggestCity {
  final String id;
  final String name;

  SuggestCity({
    required this.id,
    required this.name,
  });

  // Factory constructor to create an instance of Region from JSON
  factory SuggestCity.fromJson(Map<String, dynamic> json) {
    return SuggestCity(
      id: json['_id'] as String,
      name: json['name'] as String,
    );
  }

  // Method to convert an instance of Region to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
    };
  }
}

class SuggestLocality {
  final String id;
  final String name;

  SuggestLocality({
    required this.id,
    required this.name,
  });

  // Factory constructor to create an instance of Region from JSON
  factory SuggestLocality.fromJson(Map<String, dynamic> json) {
    return SuggestLocality(
      id: json['_id'] as String,
      name: json['name'] as String,
    );
  }

  // Method to convert an instance of Region to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
    };
  }
}

class SuggestionSpaceModel {
  final int space;
  SuggestionSpaceModel({required this.space});

  factory SuggestionSpaceModel.fromJson(Map<String, dynamic> json) {
    return SuggestionSpaceModel(
      space: json['space'],
    );
  }

  // Method to convert the Dart object back into JSON
  Map<String, dynamic> toJson() {
    return {
      'space': space,
    };
  }
}