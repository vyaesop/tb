class User {
  final int? id;
  final String name;
  final String phoneNumber;
  double balance;

  User({
    this.id,
    required this.name,
    required this.phoneNumber,
    required this.balance,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'balance': balance,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      phoneNumber: map['phoneNumber'],
      balance: map['balance'],
    );
  }
}
