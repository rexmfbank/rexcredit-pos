import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:rex_app/src/modules/revamp/data/rex_api/rex_api.dart';

class SecurityQuestionState extends Equatable {
  final TextEditingController pinController;
  final TextEditingController answerController;
  final FetchLookupDataByCodeResponseData? fetchValue;
  final bool isLoading;

  const SecurityQuestionState({
    required this.pinController,
    required this.fetchValue,
    required this.answerController,
    required this.isLoading,
  });

  SecurityQuestionState copyWith({
    TextEditingController? pinController,
    FetchLookupDataByCodeResponseData? fetchValue,
    TextEditingController? answerController,
    bool? isLoading,
  }) {
    return SecurityQuestionState(
      pinController: pinController ?? this.pinController,
      fetchValue: fetchValue ?? this.fetchValue,
      answerController: answerController ?? this.answerController,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
    pinController,
    fetchValue,
    answerController,
    isLoading,
  ];
}
