enum ApiFlavor { prod, dev }

class ApiConfig {
  String baseUrl = "";
  String pingUrl = "";
  ApiFlavor flavor = ApiFlavor.dev;

  static ApiConfig shared = ApiConfig.create();

  factory ApiConfig.create({
    String baseUrl = "",
    String pingUrl = "",
    ApiFlavor flavor = ApiFlavor.dev,
  }) {
    return shared = ApiConfig(baseUrl, pingUrl, flavor);
  }

  ApiConfig(this.baseUrl, this.pingUrl, this.flavor);
}
