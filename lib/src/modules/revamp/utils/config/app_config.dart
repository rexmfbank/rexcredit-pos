enum Flavor { prod, dev }

class AppConfig {
  Flavor flavor = Flavor.dev;

  static AppConfig shared = AppConfig.create();

  factory AppConfig.create({
    Flavor flavor = Flavor.dev,
  }) {
    return shared = AppConfig(flavor);
  }

  AppConfig(this.flavor);
}