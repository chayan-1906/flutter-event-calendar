import '../utils/get_full_name.dart';

class Dependent {
  String userId;
  String email;
  String phoneNumber;
  String firstName;
  String middleName;
  String lastName;
  String fullName;
  String suffix;
  String city;
  String country;
  String image;
  String address;
  String sex;
  String birthday;
  String height;
  String weight;

  Dependent.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    firstName = json['firstName'] == null || json['firstName'] == 'null'
        ? ''
        : json['firstName'];
    middleName = json['middleName'] == null || json['middleName'] == 'null'
        ? ''
        : json['middleName'];
    lastName = json['lastName'] == null || json['lastName'] == 'null'
        ? ''
        : json['lastName'];
    suffix = json['suffix'];
    city = json['city'];
    country = json['Country'];
    image = json['image'];
    address = json['address'];
    sex = json['sex'];
    birthday = json['birthday'];
    height = json['height'];
    weight = json['weight'];
    fullName = getFullName(
      firstName: json['firstName'],
      middleName: json['middleName'],
      lastName: json['lastName'],
    );
  }

  @override
  String toString() {
    return 'Dependent{userId: $userId, email: $email, phoneNumber: $phoneNumber, firstName: $firstName, middleName: $middleName, lastName: $lastName, suffix: $suffix, city: $city, country: $country, image: $image, address: $address, sex: $sex, birthday: $birthday, height: $height, weight: $weight, fullName: $fullName}';
  }
}
