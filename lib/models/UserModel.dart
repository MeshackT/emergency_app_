class UserModel {
  String? uid;
  String? email;
  String? phoneNumber;
  String? password;
  String? firstNames;
  String? location;

  UserModel(
      {this.uid,
      this.email,
      this.phoneNumber,
      this.password,
      this.firstNames,
      this.location});

  //getting data from the server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      password: map['password'],
      firstNames: map['firstNames'],
      location: map['location'],
    );
  }

  //sending data to the server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
      'firstNames': firstNames,
      'location': location,
    };
  }
}
