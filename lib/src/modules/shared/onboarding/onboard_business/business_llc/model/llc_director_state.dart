// ignore_for_file: camel_case_types

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rex_api/rex_api.dart';

class LLC_DirectorState extends Equatable {
  final TextEditingController director1FirstName;
  final TextEditingController director1MiddleName;
  final TextEditingController director1LastName;
  final TextEditingController director1Email;
  final TextEditingController director1Mobile;
  final TextEditingController director1Shares;
  final TextEditingController director1BVN;
  final TextEditingController director1Address;
  final DateTime director1DOB;
  final String director1Gender;
  //
  final TextEditingController director2FirstName;
  final TextEditingController director2MiddleName;
  final TextEditingController director2LastName;
  final TextEditingController director2Email;
  final TextEditingController director2Mobile;
  final TextEditingController director2Shares;
  final TextEditingController director2BVN;
  final TextEditingController director2Address;
  final DateTime director2DOB;
  final String director2Gender;
  //
  final List<BusinessDirectorInfo> directors;

  const LLC_DirectorState({
    required this.director1FirstName,
    required this.director1MiddleName,
    required this.director1LastName,
    required this.director1Email,
    required this.director1Mobile,
    required this.director1Shares,
    required this.director1BVN,
    required this.director1Address,
    required this.director1DOB,
    required this.director1Gender,
    //
    required this.director2FirstName,
    required this.director2MiddleName,
    required this.director2LastName,
    required this.director2Email,
    required this.director2Mobile,
    required this.director2Shares,
    required this.director2BVN,
    required this.director2Address,
    required this.director2DOB,
    required this.director2Gender,
    //
    required this.directors,
  });

  LLC_DirectorState copyWith({
    TextEditingController? director1FirstName,
    TextEditingController? director1MiddleName,
    TextEditingController? director1LastName,
    TextEditingController? director1Email,
    TextEditingController? director1Mobile,
    TextEditingController? director1Shares,
    TextEditingController? director1BVN,
    TextEditingController? director1Address,
    DateTime? director1DOB,
    String? director1Gender,
    //
    TextEditingController? director2FirstName,
    TextEditingController? director2MiddleName,
    TextEditingController? director2LastName,
    TextEditingController? director2Email,
    TextEditingController? director2Mobile,
    TextEditingController? director2Shares,
    TextEditingController? director2BVN,
    TextEditingController? director2Address,
    DateTime? director2DOB,
    String? director2Gender,
    //
    List<BusinessDirectorInfo>? directors,
  }) {
    return LLC_DirectorState(
      director1FirstName: director1FirstName ?? this.director1FirstName,
      director1MiddleName: director1MiddleName ?? this.director1MiddleName,
      director1LastName: director1LastName ?? this.director1LastName,
      director1Email: director1Email ?? this.director1Email,
      director1Mobile: director1Mobile ?? this.director1Mobile,
      director1Shares: director1Shares ?? this.director1Shares,
      director1BVN: director1BVN ?? this.director1BVN,
      director1Address: director1Address ?? this.director1Address,
      director1DOB: director1DOB ?? this.director1DOB,
      director1Gender: director1Gender ?? this.director1Gender,
      //
      director2FirstName: director2FirstName ?? this.director2FirstName,
      director2MiddleName: director2MiddleName ?? this.director2MiddleName,
      director2LastName: director2LastName ?? this.director2LastName,
      director2Email: director2Email ?? this.director2Email,
      director2Mobile: director2Mobile ?? this.director2Mobile,
      director2Shares: director2Shares ?? this.director2Shares,
      director2BVN: director2BVN ?? this.director2BVN,
      director2Address: director2Address ?? this.director2Address,
      director2DOB: director2DOB ?? this.director2DOB,
      director2Gender: director2Gender ?? this.director2Gender,
      //
      directors: directors ?? this.directors,
    );
  }

  @override
  List<Object?> get props => [
        director1FirstName,
        director1MiddleName,
        director1LastName,
        director1Email,
        director1Mobile,
        director1Shares,
        director1BVN,
        director1Address,
        director1DOB,
        director1Gender,
        //
        director2FirstName,
        director2MiddleName,
        director2LastName,
        director2Email,
        director2Mobile,
        director2Shares,
        director2BVN,
        director2Address,
        director2DOB,
        director2Gender,
        //
        directors,
      ];
}
