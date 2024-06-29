class ClientModel {
  final String name;
  final String address;
  final String phoneNumber;

  ClientModel({
    required this.name,
    required this.address,
    required this.phoneNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
      'phone_number': phoneNumber,
    };
  }
}
