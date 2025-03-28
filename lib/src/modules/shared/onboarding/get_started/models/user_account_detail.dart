import 'package:equatable/equatable.dart';

class UserAccountDetail extends Equatable {
  final int? id;
  final int? userId;
  final String? name;
  final String? nuban;
  final String? reference;
  final String? bankName;
  final String? createdAt;

  const UserAccountDetail({
    this.id,
    this.userId,
    this.name,
    this.nuban,
    this.reference,
    this.bankName,
    this.createdAt,
  });

  const UserAccountDetail.empty()
      : id = null,
        userId = null,
        name = null,
        nuban = null,
        reference = null,
        bankName = null,
        createdAt = null;

  factory UserAccountDetail.fromJson(Map<String, dynamic> json) {
    return UserAccountDetail(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      nuban: json['nuban'],
      reference: json['reference'],
      bankName: json['bank_name'],
      createdAt: json['created_at'],
    );
  }

  @override
  String toString() {
    return {
      "CLASS": "UserAccountDetail",
      "ID": id,
      "userid": userId,
      "name": name,
      "nuban": nuban,
      "reference": reference,
      "bankName": bankName,
      "createdAt": createdAt,
    }.toString();
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        name,
        nuban,
        reference,
        bankName,
        createdAt,
      ];
}
