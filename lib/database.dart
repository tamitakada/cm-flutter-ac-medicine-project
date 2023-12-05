import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:medicine/medicine_listing.dart';
import 'user.dart';

class Database{

  static final db = FirebaseFirestore.instance;
  static final storageRef = FirebaseStorage.instance.ref();

  static Future<bool> addUser (UserStuff user) async {

    await db.collection("users").add(user.convertMap());

    return true;
  }

  static Future<List<UserStuff>> findAge(int wantAge) async {

    final userBelowThirty = await db.collection("users").where("age", isLessThan: wantAge).get();
    final userBelowThirtyDocs = userBelowThirty.docs;

    List<Map<String, dynamic>> userinfo = [];
    List<UserStuff> users = [];

    for(var docSnapshot in userBelowThirtyDocs){
      userinfo.add(docSnapshot.data());
    }

    for (int i = 0; i < userinfo.length; i++){


      users.add(UserStuff(email: userinfo[i]["email"], firstName: userinfo[i]["firstName"], lastName: userinfo[i]["lastName"], age: userinfo[i]["age"]));
    }

    return users;
  }

  static void delete(String ID) async {

    await db.collection("users").doc(ID).delete();
  }

  static void update(String ID, UserStuff user) async {

    final reference = db.collection("users").doc(ID);

    try{

      await reference.update(user.convertMap());

    }catch(e){

      print(e);
    }
    //await reference.update(user.convertMap());
  }

  static Future<UserStuff> getUser(String email) async {
    final userBelowThirty = await db.collection("users").where("email", isEqualTo: email).get();
    final userBelowThirtyDocs = userBelowThirty.docs;

    List<Map<String, dynamic>> userinfo = [];
    List<UserStuff> users = [];

    for(var docSnapshot in userBelowThirtyDocs){
      userinfo.add(docSnapshot.data());
    }

    for (int i = 0; i < userinfo.length; i++){


      users.add(UserStuff(email: userinfo[i]["email"], firstName: userinfo[i]["firstName"], lastName: userinfo[i]["lastName"], age: userinfo[i]["age"]));
    }

    return users.first;
  }

  static Future<bool> storeImage(File image, String userName) async {

    final uploadRef = storageRef.child(userName);

    try{

      await uploadRef.putFile(image);

    }catch(e){

      return false;
    }

    return true;
  }

  static Future<bool> saveMeds(MedicineListing med) async {

    var user = FirebaseAuth.instance.currentUser;
    var name = await db.collection("users").where("email", isEqualTo: user?.email).get();


    return true;
  }
}
