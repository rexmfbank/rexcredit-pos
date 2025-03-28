enum DocStatus {
  completed('COMPLETED', 'Completed'),
  declined('DECLINED', 'Declined'),
  rejected('REJECTED', 'Rejected'),
  terminated('TERMINATED', 'Terminated'),
  accepted('ACCEPTED', 'Accepted'),
  applied('APPLIED', 'Applied'),
  pending('PENDING', 'Pending'),
  unavailable('UNAVAILABLE', 'Unavailable'),
  none('NONE', 'None');

  const DocStatus(this.jsonString, this.displayString);
  final String jsonString;
  final String displayString;
}

enum DocStatusv2 {
  pending('PENDING'),
  rejected('REJECTED'),
  accepted('ACCEPTED');

  const DocStatusv2(this.value);
  final String value;
}

extension DocStatusFromString on String? {
  DocStatus? get jsonDocStatus {
    return DocStatus.values.firstWhere(
      (element) => element.jsonString == this,
      orElse: () => DocStatus.none,
    );
  }

  DocStatus? get displayDocStatus {
    return DocStatus.values.firstWhere(
      (element) => element.displayString == this,
      orElse: () => DocStatus.none,
    );
  }
}
