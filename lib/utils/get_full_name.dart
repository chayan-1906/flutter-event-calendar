import 'is_string_invalid.dart';

String getFullName({String firstName, String middleName, String lastName}) {
  String fullName = '';
  if (!isStringInvalid(firstName.toString().trim())) {
    fullName = fullName + firstName.trim();
  }
  if (!isStringInvalid(middleName.toString().trim())) {
    fullName = '$fullName ${middleName.trim()}';
  }
  if (!isStringInvalid(lastName.toString().trim())) {
    fullName = '$fullName ${lastName.trim()}';
  }
  return fullName;
}
