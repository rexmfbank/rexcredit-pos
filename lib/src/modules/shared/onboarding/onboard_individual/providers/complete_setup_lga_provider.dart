import 'package:equatable/equatable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/utils/state_and_lga.dart';

class SelectedLga extends Equatable {
  final String lga;
  final List<String> lgaList;

  const SelectedLga({
    required this.lga,
    required this.lgaList,
  });

  SelectedLga copyWith({
    String? lga,
    List<String>? lgaList,
  }) {
    return SelectedLga(
      lga: lga ?? this.lga,
      lgaList: lgaList ?? this.lgaList,
    );
  }

  @override
  List<Object?> get props => [lga, lgaList];
}

final completeSetupLgaProvider =
    NotifierProvider<CompleteSetupLgaNotifier, SelectedLga>(
  () => CompleteSetupLgaNotifier(),
);

class CompleteSetupLgaNotifier extends Notifier<SelectedLga> {
  final statesMap = statesAndLgas.map((e) => e).toList();

  @override
  SelectedLga build() {
    final initState = statesMap.where((e) => e['state'] == 'Lagos');
    final initStateMap = initState.first;
    return SelectedLga(
      lga: '',
      lgaList: initStateMap['lgas'],
    );
  }

  void onStateDropdownChange(String dropdownState) {
    final selectedState = statesMap.where((e) => e['state'] == dropdownState);
    final selectedStateMap = selectedState.first;
    state = state.copyWith(lgaList: selectedStateMap['lgas']);
  }

  void onLgaDropdownChange(String? value) {
    state = state.copyWith(lga: value!);
  }
}
