/// we put this file in data layer because this layer is responsible
/// for API's
import 'package:json_annotation/json_annotation.dart';

import '../../domain/models/models.dart';
part 'responses.g.dart';

/// we use JsonSerializable to generate auto-generated fromJson & toJson
/// to do that you should write that command line in terminal
/// don't forget to add [part fileName.g.dart]
/// flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs

@JsonSerializable()
class BaseResponse {
  // the name of our json that we will have
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
  
}

@JsonSerializable()
class CustomerResponse {
  // the name of our json that we will have
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "num_of_notifications")
  int? numOfNotifications;

  CustomerResponse(this.id, this.name, this.numOfNotifications);
  // from json
  factory CustomerResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$CustomerResponseToJson(this);
}

@JsonSerializable()
class ContactsResponse {
  // the name of our json that we will have
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "link")
  String? link;

  ContactsResponse(this.phone, this.email, this.link);
  // from json
  factory ContactsResponse.fromJson(Map<String, dynamic> json) =>
      _$ContactsResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$ContactsResponseToJson(this);
}

// authentication response
@JsonSerializable()
class AuthenticationResponse with BaseResponse {
  @JsonKey(name: "customer")
  CustomerResponse? customer;
  @JsonKey(name: "contacts")
  ContactsResponse? contacts;

  AuthenticationResponse(this.customer, this.contacts);
  // from json
  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}
