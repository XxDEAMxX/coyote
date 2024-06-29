class ClientModel {
  final int? id;
  final String? name;
  final String? address;
  final String? phoneNumber;

  ClientModel({
    this.id,
    this.name,
    this.address,
    this.phoneNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
      'phone_number': phoneNumber,
    };
  }
}
