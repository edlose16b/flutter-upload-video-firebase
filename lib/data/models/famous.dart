// To parse this JSON data, do
//
//     final famous = famousFromJson(jsonString);

import 'dart:convert';

Famous famousFromJson(String str) => Famous.fromJson(json.decode(str));

String famousToJson(Famous data) => json.encode(data.toJson());

class Famous {
  Famous({
    this.name,
    this.image,
    this.countryCode,
    this.type,
  });

  String name;
  String image;
  String countryCode;
  String type;

  factory Famous.fromJson(Map<String, dynamic> json) => Famous(
        name: json["name"],
        image: json["image"],
        countryCode: json["country_code"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
        "country_code": countryCode,
        "type": type,
      };
}

List<Famous> famousListTest = [
  Famous(
    name: 'Gabriela Berrospi',
    countryCode: 'pe',
    image:
        'https://dqb0851cl2gjs.cloudfront.net/celebrities/257/avatar/famosos-videos-personalizados-veronicamontes-compressed.jpg',
    type: 'Influencers',
  ),
  Famous(
    image:
        'https://dqb0851cl2gjs.cloudfront.net/celebrities/609/avatar/famosos-videos-personalizados-enriquearce-compressed.jpg',
    name: 'Enrique Arce',
    type: 'Actores',
    countryCode: 'es',
  ),
  Famous(
    name: 'Pibe Valderrama',
    countryCode: 'co',
    image:
        'https://dqb0851cl2gjs.cloudfront.net/celebrities/35/avatar/famosos-videos-personalizados-pibevalderrama-compressed.jpg',
    type: 'Deportistas',
  ),
  Famous(
    name: 'Rolando Schiavi',
    countryCode: 'ar',
    image:
        'https://dqb0851cl2gjs.cloudfront.net/celebrities/301/avatar/famosos-videos-personalizados-rolandoschiavi-compressed.jpg',
    type: 'Influencers',
  ),
];
