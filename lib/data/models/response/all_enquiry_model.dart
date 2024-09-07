class AllEnquiryMode {
  final String sId;
  final String propertyId;
  final String venderId;
  final String name;
  final String date;
  final String time;
  final int phoneNumber;
  final String email;
  final String message;
  final String status;
  final String createdAt;

  AllEnquiryMode({
    required this.sId,
    required this.propertyId,
    required this.venderId,
    required this.name,
    required this.date,
    required this.time,
    required this.phoneNumber,
    required this.email,
    required this.message,
    required this.status,
    required this.createdAt,
  });

  // Factory constructor to create an instance from JSON
  factory AllEnquiryMode.fromJson(Map<String, dynamic> json) {
    return AllEnquiryMode(
      sId: json['_id'] ?? '',
      propertyId: json['property_id'] ?? '',
      venderId: json['vender_id'] ?? '',
      name: json['name'] ?? '',
      date: json['date'] ?? '',
      time: json['time'] ?? '',
      phoneNumber: json['phone_number'] ?? 0,
      email: json['email'] ?? '',
      message: json['message'] ?? '',
      status: json['status'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'property_id': propertyId,
      'vender_id': venderId,
      'name': name,
      'phone_number': phoneNumber,
      'email': email,
      'date': date,
      'time': time,
      'message': message,
      'status': status,
      'created_at': createdAt,
    };
  }
}
