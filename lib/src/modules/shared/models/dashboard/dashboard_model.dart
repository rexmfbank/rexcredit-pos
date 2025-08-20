class DashboardModel {
  final bool isLoading;

  DashboardModel({this.isLoading = false});

  DashboardModel copyWith({bool? isLoading}) {
    return DashboardModel(isLoading: isLoading ?? this.isLoading);
  }
}
