import 'package:equatable/equatable.dart';
import 'package:rex_api/rex_api.dart';

class BusinessOnboardState extends Equatable {
  final List<CustomerDocumentDto> businessDocs;
  final List<BusinessDirectorInfo> directors;

  const BusinessOnboardState({
    required this.businessDocs,
    required this.directors,
  });

  BusinessOnboardState copyWith({
    List<CustomerDocumentDto>? businessDocs,
    List<BusinessDirectorInfo>? directors,
  }) {
    return BusinessOnboardState(
      businessDocs: businessDocs ?? this.businessDocs,
      directors: directors ?? this.directors,
    );
  }

  @override
  List<Object?> get props => [businessDocs, directors];
}
