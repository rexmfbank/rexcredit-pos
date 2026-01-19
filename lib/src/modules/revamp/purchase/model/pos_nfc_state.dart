import 'package:equatable/equatable.dart';

class PosNfcState extends Equatable {
  final bool isLoading;

  const PosNfcState({required this.isLoading});

  PosNfcState copyWith({bool? isLoading}) {
    return PosNfcState(isLoading: isLoading ?? this.isLoading);
  }

  @override
  List<Object?> get props => [isLoading];
}
