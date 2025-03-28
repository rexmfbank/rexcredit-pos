class BaseViewModel {
  final bool isLoading;
  final bool isDisabled;

  BaseViewModel({
     this.isLoading = false,
     this.isDisabled = false,
  });

  BaseViewModel copyWith({
    bool? isLoading,
    bool? isDisabled,
  }) =>
      BaseViewModel(
        isLoading: isLoading ?? this.isLoading,
        isDisabled: isDisabled ?? this.isDisabled,
      );
}
