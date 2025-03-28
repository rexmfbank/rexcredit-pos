class BillerQuery {
  String? billerCategory;
  String? name;

  BillerQuery({
    this.billerCategory,
    this.name,
  });

  BillerQuery copyWith({
    String? billerCategory,
    String? name,
  }) {
    return BillerQuery(
      billerCategory: billerCategory ?? this.billerCategory,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'billerCategory': billerCategory,
      'name': name,
    };
  }

  factory BillerQuery.fromMap(Map<String, dynamic> map) {
    return BillerQuery(
      billerCategory: map['billerCategory'],
      name: map['name'],
    );
  }
}