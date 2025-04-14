import 'package:equatable/equatable.dart';

class ReprintState extends Equatable {
  final String todaysDate;

  const ReprintState({
    required this.todaysDate,
  });
  
  @override
  List<Object?> get props => [];
}
