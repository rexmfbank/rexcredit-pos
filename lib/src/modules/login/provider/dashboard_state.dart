import 'package:equatable/equatable.dart';

enum BalanceStateEnum {
  initial,
  cacheCheck,
  cacheSuccess,
  cacheFail,
  apiLoading,
  apiSuccess,
  apiFail,
}

class DashboardState extends Equatable {
  final bool isLoading;
  final BalanceStateEnum balanceState;
  final String balanceAcctName;
  final String balanceAcctType;
  final String balanceAcctNo;
  final String balanceAvailable;
  final String balanceLedger;

  const DashboardState({
    this.isLoading = false,
    this.balanceState = BalanceStateEnum.initial,
    this.balanceAcctName = '',
    this.balanceAcctNo = '',
    this.balanceAcctType = '',
    this.balanceAvailable = '',
    this.balanceLedger = '',
  });

  DashboardState copyWith({
    bool? isLoading,
    BalanceStateEnum? balanceState,
    String? balanceAcctName,
    String? balanceAcctType,
    String? balanceAcctNo,
    String? balanceAvailable,
    String? balanceLedger,
  }) {
    return DashboardState(
      isLoading: isLoading ?? this.isLoading,
      balanceState: balanceState ?? this.balanceState,
      balanceAcctName: balanceAcctName ?? this.balanceAcctName,
      balanceAcctType: balanceAcctType ?? this.balanceAcctType,
      balanceAcctNo: balanceAcctNo ?? this.balanceAcctNo,
      balanceAvailable: balanceAvailable ?? this.balanceAvailable,
      balanceLedger: balanceLedger ?? this.balanceLedger,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    balanceState,
    balanceAcctName,
    balanceAcctType,
    balanceAcctNo,
    balanceAvailable,
    balanceLedger,
  ];
}
