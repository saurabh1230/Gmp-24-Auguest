
import 'package:get/get.dart';
import 'package:get_my_properties/features/screens/Maps/location_view.dart';
import 'package:get_my_properties/features/screens/auth/otp_verification_screen.dart';
import 'package:get_my_properties/features/screens/auth/sign_up.dart';
import 'package:get_my_properties/features/screens/dashboard/dashboard.dart';
import 'package:get_my_properties/features/screens/dashboard/seller_dashboard.dart';
import 'package:get_my_properties/features/screens/explore/explore_screen.dart';
import 'package:get_my_properties/features/screens/explore/ratings_and_review_screen.dart';
import 'package:get_my_properties/features/screens/home/home_screen.dart';
import 'package:get_my_properties/features/screens/inquiry/all_user_inquiry.dart';
import 'package:get_my_properties/features/screens/inquiry/contact_agent_screen.dart';
import 'package:get_my_properties/features/screens/notification/notification_screen.dart';
import 'package:get_my_properties/features/screens/onboard/onboarding_screen.dart';
import 'package:get_my_properties/features/screens/onboard/splash_screen.dart';
import 'package:get_my_properties/features/screens/profile/profile_screen.dart';
import 'package:get_my_properties/features/screens/property/prperties_details_screen.dart';
import 'package:get_my_properties/features/screens/saved/saved_screen.dart';
import 'package:get_my_properties/features/screens/search/explore_search_screen.dart';
import 'package:get_my_properties/features/screens/search/search_screen.dart';
import 'package:get_my_properties/features/screens/seller_screens/enquiry/all_enquiry_screens.dart';
import 'package:get_my_properties/features/screens/seller_screens/property/post_property_screen.dart';

import '../features/screens/property/sale_and_rent_dashboard/sale_and_rent_screen.dart';

class RouteHelper {
  static const String initial = '/';
  static const String splash = '/splash';
  static const String sellRentDashboard = '/sell-rent-dashboard';
  static const String onboarding = '/onboarding';
  static const String signUp = '/signUp';
  static const String otpVerification = '/otp-verification';
  static const String adminDashboard = '/admin-dashboard';
  static const String dashboard = '/dashboard';
  static const String home = '/home';
  static const String propertiesDetails = '/properties-details-screen';
  static const String saved = '/saved';
  static const String search = '/search';
  static const String explore = '/explore';
  static const String exploreSearch = '/explore-search';
  static const String ratingsAndReviews = '/rating-and-reviews';
  static const String notification = '/notification';
  static const String postProperty = '/post-property';
  static const String locationPicker = '/location-View';
  static const String enquiry = '/enquiry';
  static const String profile = '/profile';
  static const String propertySearchMap = '/property-search-map';
  static const String contactAgent = '/contact-agent';
  static const String allUserInquiry = '/all-user-inquiry';



  /// Routes ==================>
  static String getInitialRoute() => initial;
  static String getSplashRoute() => splash;
  static String getOnboardingRoute() => onboarding;
  static String getSignUpRoute() => signUp;
  // static String getOtpVerificationRoute() => otpVerification;
  static String getOtpVerificationRoute(String? phoneNo,) => '$otpVerification?phoneNo=$phoneNo';
  static String getDashboardRoute() => dashboard;
  static String getAdminDashboardRoute() => adminDashboard;
  static String getHomeRoute() => home;
  static String getPropertiesDetailsScreen(String title,String propertyId) => '$propertiesDetails?title=$title&propertyId=$propertyId';
  static String getSavedRoute({bool isBackButton = false}) => '$saved?isHistory=${isBackButton.toString()}';
  static String getProfileRoute({bool isBackButton = false}) => '$profile?isBackButton=${isBackButton.toString()}';
  static String getSearchRoute() => search;
  static String getExploreRoute({bool isBrowser = false, String? title, String? propertyTypeId, String? purposeId}) =>
      '$explore?isBrowser=${isBrowser.toString()}&title=$title&propertyTypeId=$propertyTypeId&purposeId=$purposeId';
  static String getSellAndRentDashboardRoute(String page, String? type, String? typeId,String? purposeId,) => '$sellRentDashboard?page=$page&type=$type&typeId=$typeId&purposeId=$purposeId';
  static String getExploreSearchRoute(String? title) =>
      '$exploreSearch?&title=$title';
  static String getRatingsAndReviewRoute() => ratingsAndReviews;
  static String getNotificationRoute() => notification;
  static String getPostPropertyRoute() => postProperty;
  static String getLocationPickerRoute({bool isAddress = false}) => '$locationPicker?isAddress=${isAddress.toString()}';
  static String getEnquiryRoute() => enquiry;
  static String getPropertySearchMap() => propertySearchMap;
  static String getContactAgentRoute(String? propertyId,String? agentName,) => '$contactAgent?propertyId=$propertyId&agentName=$agentName';
  static String getAllUserInquiry() => allUserInquiry;



  /// Pages ==================>
  static List<GetPage> routes = [

    GetPage(name: initial, page: () => const SplashScreen()),
    GetPage(name: onboarding, page: () => const OnboardingScreen()),
    GetPage(name: signUp, page: () =>  SignUpScreen()),
    GetPage(name: otpVerification, page: () =>  OtpVerificationScreen(phoneNo :Get.parameters['phoneNo'])),
    GetPage(name: dashboard, page: () =>  const DashboardScreen(pageIndex: 0)),
    GetPage(name: adminDashboard, page: () =>  const SellerDashboardScreen(pageIndex: 0)),
    GetPage(name: home, page: () =>  const HomeScreen()),
    GetPage(name: search, page: () =>   SearchScreen()),
    GetPage(name: propertiesDetails, page: () =>  PropertiesDetailsScreen(title: Get.parameters['title'],propertyId: Get.parameters['propertyId'],)),
    GetPage(name: saved, page: () => SavedScreen(isBackButton: Get.parameters['isHistory'] == 'true')),
    GetPage(name: profile, page: () => ProfileScreen(isBackButton: Get.parameters['isBackButton'] == 'true')),
    GetPage(name: explore, page: () => ExploreScreen(
      isBrowser: Get.parameters['isBrowser'] == 'true',title: Get.parameters["title"],propertyTypeId: Get.parameters["propertyTypeId"],purposeId: Get.parameters["purposeId"] ,),),
    GetPage(name: sellRentDashboard, page: () => SaleAndRentDashboard(pageIndex:Get.parameters['page'] == 'Sale' ? 0 : 1, type: Get.parameters['type'],typeId: Get.parameters['typeId'],purposeId: Get.parameters['purposeId'],),),
    // GetPage(name: exploreSearch, page: () => ExploreSearchScreen(title: Get.parameters["title"],),),
    GetPage(name: ratingsAndReviews, page: () =>  RatingsAndReviewScreen()),
    GetPage(name: notification, page: () => const NotificationScreen()),
    GetPage(name: postProperty, page: () =>  PostPropertyScreen()),
    GetPage(name: locationPicker, page: () =>   LocationPickerScreen(isAddress: Get.parameters['isAddress'] == 'true',)),
    GetPage(name: enquiry, page: () =>  const AllEnquiryScreens()),
    GetPage(name: contactAgent, page: () =>   ContactAgentScreen(propertyId: Get.parameters['propertyId'],agentName:  Get.parameters['agentName'],)),
    // GetPage(name: propertySearchMap, page: () =>  const SearchLocationScreen()),
    GetPage(name: allUserInquiry, page: () =>  const AllUserInquiry()),



  ];
}