import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'database.dart';
import 'user.dart';

class UserInformation extends StatefulWidget {

  final String email;

  const UserInformation({super.key, required this.email});

  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {

  final ImagePicker imagePicker = ImagePicker();
  File? selectedImage;

  ImageFromCamera()async{

    final image =
    await imagePicker.pickImage(

      source: ImageSource.camera,
      imageQuality: 50,
    );

    Database.storeImage(File(image!.path), widget.email);
  }

  ImageFromGallery()async{

    final image =
    await imagePicker.pickImage(

      source: ImageSource.gallery,
      imageQuality: 50,
    );

    Database.storeImage(File(image!.path), widget.email);
  }

  void showPicker(){

    //showModalBottomSheet(context: context, builder: builder);
  }

  final formKey = GlobalKey<FormState>();

  TextEditingController firstNameCtrl = TextEditingController();
  TextEditingController lastNameCtrl = TextEditingController();
  TextEditingController ageCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: ListView(

        children: [

          Form(

            key: formKey,

            child: Column(

              children: [

                Text("User Information", style: TextStyle(fontSize: 40),),

                Text("Input first name", style: TextStyle(fontSize: 20),),
                TextFormField(

                  decoration: InputDecoration(

                    prefixIcon: Icon(Icons.email),
                    labelText: "First Name",
                    border: OutlineInputBorder(),
                  ),

                  controller: firstNameCtrl,

                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please enter a your first name";
                    }

                    return null;
                  },
                ),

                Text("Input last name", style: TextStyle(fontSize: 20),),
                TextFormField(

                  decoration: InputDecoration(

                    prefixIcon: Icon(Icons.email),
                    labelText: "Last Name",
                    border: OutlineInputBorder(),
                  ),

                  controller: lastNameCtrl,

                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please enter your last name";
                    }

                    return null;
                  },
                ),

                Text("Input age", style: TextStyle(fontSize: 20),),
                TextFormField(

                  decoration: InputDecoration(

                    prefixIcon: Icon(Icons.email),
                    labelText: "Age",
                    border: OutlineInputBorder(),
                  ),

                  controller: ageCtrl,

                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please enter your age";
                    }

                    return null;
                  },
                ),

                Text("Photo of medical ID", style: TextStyle(fontSize: 20),),

                ElevatedButton(

                  onPressed: ImageFromGallery,

                  child: Text("Import for photo gallery"),
                ),

                ElevatedButton(

                  onPressed: ImageFromCamera,

                  child: Text("Take a photo"),
                ),

                ElevatedButton(

                  onPressed: (){

                    if(formKey.currentState!.validate()){

                      formKey.currentState!.save();

                      Database.addUser(UserStuff(email: widget.email, firstName: firstNameCtrl.text, lastName: lastNameCtrl.text, age: int.parse(ageCtrl.text)));
                    }
                  },
                  child: Text("Create"),
                ),
              ],
            ),
          )
          //timezone?
        ],
      ),
    );
  }
}
