import 'package:equatable/equatable.dart';

class UserAccount extends Equatable {
  final String id;
  final Object userType;
  final String userId;
  final String name;
  final String nuban;
  final String reference;
  final String bankName;
  final DateTime createdAt;

  const UserAccount({
    required this.id,
    required this.userType,
    required this.userId,
    required this.name,
    required this.nuban,
    required this.reference,
    required this.bankName,
    required this.createdAt,
  });

  UserAccount.empty()
      : id = '',
        userType = '',
        userId = '',
        name = '',
        nuban = '',
        reference = '',
        bankName = '',
        createdAt = DateTime.now();

  factory UserAccount.fromJson(Map<String, dynamic> json) {
    return UserAccount(
      id: json['id'] as String,
      userType: json['user_type'] as Object,
      userId: json['user_id'] as String,
      name: json['name'] as String,
      nuban: json['nuban'] as String,
      reference: json['reference'] as String,
      bankName: json['bank_name'] as String,
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  @override
  List<Object?> get props => [
        id,
        userType,
      ];
}
