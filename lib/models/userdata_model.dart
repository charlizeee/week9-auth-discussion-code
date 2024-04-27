import 'dart:convert';

class userData {
  String? id;
  String firstName;
  String lastName;
  String email; 

  //convert to JSON format
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email
    };
  }

  //convert to userData format
  factory userData.fromJson(Map<String, dynamic> dataJson){
    return userData(
      dataJson['id'],
      dataJson['firstName'],
      dataJson['lastName'],
      dataJson['email']
    );
  }

  static List<userData> fromJsonArray(String jsonData){
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<userData>((dynamic d) => userData.fromJson(d)).toList();
  }

  userData(this.id, this.firstName, this.lastName, this.email);
}