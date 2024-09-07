
import 'package:get/get.dart';
import 'package:get_my_properties/data/models/response/search_suggestion_model.dart';
import 'package:get_my_properties/data/repo/search_repo.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class PropertySearchController extends GetxController implements GetxService {
  final SearchRepo searchRepo;

  PropertySearchController({required this.searchRepo});


  List<String> propertyPurposeList = ['Buy', 'Rent'];
  String _propertyPurposeId = 'Buy';
  String get propertyPurposeId => _propertyPurposeId;

  void setPropertyPurpose(String val) {
    _propertyPurposeId = val;
    update();
  }


  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<SuggestLocality>? _suggestedLocality;
  List<SuggestLocality>? get suggestedLocality => _suggestedLocality;
  List<SuggestLocality>? _suggestedCity;
  List<SuggestLocality>? get suggestedCity => _suggestedCity;
  List<SuggestLocality>? _suggestedType;
  List<SuggestLocality>? get suggestedType => _suggestedType;
  List<SuggestLocality>? _suggestedPurpose;
  List<SuggestLocality>? get suggestedPurpose => _suggestedPurpose;
  List<SuggestionSpaceModel>? _suggestionSpace;
  List<SuggestionSpaceModel>? get suggestionSpace => _suggestionSpace;


  var suggestions = <String>[].obs;
  Future<void> fetchSuggestions(String? query) async {
    final fetchedSuggestions = await getSearchSuggestionList(query);
    suggestions.assignAll(fetchedSuggestions);
  }

  // Future<List<String>> getSearchSuggestionList(String? query) async {
  //   final String apiUrl = 'https://dev.invoidea.in/gmp/api/user/property/search/suggestion'; // Replace with your API URL
  //
  //   try {
  //     final response = await http.post(
  //       Uri.parse(apiUrl),
  //       headers: {
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'Accept': 'application/json',
  //       },
  //       body: jsonEncode({'query': query}),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> responseData = jsonDecode(response.body);
  //       List<dynamic> typeData = responseData['data']['type'];
  //       List<dynamic> purposeData = responseData['data']['purpose'];
  //       List<dynamic> cityData = responseData['data']['city'];
  //       List<dynamic> localityData = responseData['data']['locality'];
  //       List<dynamic> spaceData = responseData['data']['space'];
  //
  //       List<String> suggestions = [];
  //
  //       // Generate suggestions with space and "bhk"
  //       for (var space in spaceData) {
  //         String spaceValue = space['space'].toString();
  //         String bhkSpace = '$spaceValue bhk'; // Append "bhk"
  //
  //         for (var type in typeData) {
  //           for (var purpose in purposeData) {
  //             for (var city in cityData) {
  //               for (var locality in localityData) {
  //                 suggestions.add('$bhkSpace ${type['name']} for ${purpose['name']} in ${locality['name']}');
  //                 suggestions.add('$bhkSpace ${type['name']} for ${purpose['name']} in ${city['name']}');
  //               }
  //             }
  //           }
  //         }
  //       }
  //
  //       return suggestions;
  //     } else {
  //       print("Error in API call: ${response.statusCode}");
  //       return [];
  //     }
  //   } catch (error) {
  //     print("Error while fetching suggestions: $error");
  //     return [];
  //   }
  // }

  Future<List<String>> getSearchSuggestionList(String? query) async {
    final String apiUrl = 'https://dev.invoidea.in/gmp/api/user/property/search/suggestion'; // Replace with your API URL

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: jsonEncode({'query': query}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        List<dynamic> typeData = responseData['data']['type'];
        List<dynamic> purposeData = responseData['data']['purpose'];
        List<dynamic> spaceData = responseData['data']['space'];
        List<dynamic> cityData = responseData['data']['city'];
        List<dynamic> localityData = responseData['data']['locality'];

        List<String> suggestions = [];

        // 1. Space with Type
        for (var space in spaceData) {
          String spaceValue = space['space'].toString();
          String bhkSpace = '$spaceValue bhk'; // Append "bhk"
          for (var type in typeData) {
            suggestions.add('$bhkSpace ${type['name']}');
          }
        }

        // 2. Space with Purpose
        for (var space in spaceData) {
          String spaceValue = space['space'].toString();
          String bhkSpace = '$spaceValue bhk'; // Append "bhk"
          for (var purpose in purposeData) {
            suggestions.add('$bhkSpace ${purpose['name']}');
          }
        }

        // 3. Space with City and Locality
        for (var space in spaceData) {
          String spaceValue = space['space'].toString();
          String bhkSpace = '$spaceValue bhk'; // Append "bhk"
          for (var city in cityData) {
            suggestions.add('$bhkSpace in ${city['name']}');
          }
          for (var locality in localityData) {
            suggestions.add('$bhkSpace in ${locality['name']}');
          }
        }

        return suggestions;
      } else {
        print("Error in API call: ${response.statusCode}");
        return [];
      }
    } catch (error) {
      print("Error while fetching suggestions: $error");
      return [];
    }
  }

}