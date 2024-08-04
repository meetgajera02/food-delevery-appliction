import 'dart:convert';

AddressModel productModelFromJson(String str) =>
    AddressModel.fromJson(json.decode(str));

String AddressModellToJson(AddressModel data) => json.encode(data.toJson());

class AddressModel {
  String id;
  String name;
  String phone;
  String area;
  String building;
  String city;
  String state;
  String pinCode;

  AddressModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.building,
    required this.city,
    required this.state,
    required this.pinCode,
    required this.area,
  });

  Map<String, dynamic> toJson() => {
      'id': id,
      'name': name,
      'phone': phone,
      'area': area,
      'building': building,
      'city': city,
      'state': state,
      'pinCode': pinCode,
  };

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(

      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      area: json['area'],
      building: json['building'],
      city: json['city'],
      state: json['state'],
      pinCode: json['pinCode'],
  );
  
}
