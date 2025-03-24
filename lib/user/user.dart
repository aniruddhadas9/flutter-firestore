class User {
  final String firstName;
  final String lastName;
  final String email;
  final String address;
  final String phone;

  const User({required this.firstName, required this.lastName, required this.email, required this.address, required this.phone});

  Map<String, Object?> toMap() {
    return {'firstName': firstName, 'lastName': lastName, 'email': email, 'address': address, 'phone': phone};
  }


  @override
  String toString() {
    return 'User{firstName: $firstName, lastName: $lastName, email: $email, address: $address, phone: $phone}';
  }
}