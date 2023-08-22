import 'dart:convert';

class RandomBackgroundImage {
  String? provider;
  String? license;
  String? terms;
  String? url;

  RandomBackgroundImage({
    this.provider,
    this.license,
    this.terms,
    this.url,
  });

  factory RandomBackgroundImage.fromJson(Map<String, dynamic> json) =>
      RandomBackgroundImage(
        provider: json["provider"],
        license: json["license"],
        terms: json["terms"],
        url: json["url"],
        
      );

  Map<String, dynamic> toJson() => {
        "provider": provider,
        "license": license,
        "terms": terms,
        "url": url,
        
      };
}

// class Size {
//   int? height;
//   int? width;

//   Size({
//      this.height,
//      this.width,
//   });

//   factory Size.fromJson(Map<String, dynamic> json) => Size(
//         height: json["height"]!.toInt(),
//         width: json["width"]!.toInt(),
//       );

//   Map<String, dynamic> toJson() => {
//         "height": height,
//         "width": width,
//       };
// }
