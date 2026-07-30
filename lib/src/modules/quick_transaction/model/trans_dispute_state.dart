import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:rex_app/src/modules/api/models/create_dispute_payload.dart';

class TransDisputeState extends Equatable {
  final bool isLoading;
  final DisputeReasonItem? disputeReason;
  final TextEditingController reasonController;
  final TextEditingController descriptionController;

  const TransDisputeState({
    required this.isLoading,
    required this.reasonController,
    required this.descriptionController,
    this.disputeReason,
  });

  TransDisputeState copyWith({
    bool? isLoading,
    DisputeReasonItem? disputeReason,
    TextEditingController? reasonController,
    TextEditingController? descriptionController,
    bool clearDisputeReason = false,
  }) {
    return TransDisputeState(
      isLoading: isLoading ?? this.isLoading,
      disputeReason:
          clearDisputeReason ? null : (disputeReason ?? this.disputeReason),
      reasonController: reasonController ?? this.reasonController,
      descriptionController:
          descriptionController ?? this.descriptionController,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    disputeReason,
    reasonController,
    descriptionController,
  ];
}
