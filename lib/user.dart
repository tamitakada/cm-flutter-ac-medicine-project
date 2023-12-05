import 'medicine_listing.dart';

class UserStuff{

  String email;

  String firstName;
  String lastName;
  int age;

  List<MedicineListing>? meds;

  UserStuff({

    required this.email,
    required this.firstName,
    required this.lastName,
    required this.age,

    this.meds,
  });

  Map<String, dynamic> convertMap(){

    Map<String, dynamic> user = {
      "email" : email,
      "firstName" : firstName,
      "lastName" : lastName,
      "age": age,
      "medicines": meds
    };

    return user;
  }
}
