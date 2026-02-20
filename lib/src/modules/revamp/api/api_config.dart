enum ApiFlavor { prod, dev }

class ApiConfig {
  String baseUrl = "";
  String imageBaseUrl = "";
  ApiFlavor flavor = ApiFlavor.dev;

  static ApiConfig shared = ApiConfig.create();

  factory ApiConfig.create({
    String baseUrl = "",
    String imageBaseUrl = "",
    ApiFlavor flavor = ApiFlavor.dev,
  }) {
    return shared = ApiConfig(baseUrl, imageBaseUrl, flavor);
  }

  ApiConfig(this.baseUrl, this.imageBaseUrl, this.flavor);
}
