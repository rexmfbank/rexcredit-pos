abstract class ApiConstants {
  static const String baseUrlSandbox = 'https://api-qa.rexafrica.com/api';
  static const imageBaseUrl =
      'https://productlogos.s3.us-west-2.amazonaws.com/';
  static fullImageUrl(String id) => '$imageBaseUrl$id';
  static const dummySvgUrl = 'https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/atom.svg';
  static const dummyImageUrl = 'https://via.placeholder.com/60x60';
}
