import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo/models/user_model.dart';

import '../shared/network/firebase/firebase_functions.dart';

class MyProvider extends ChangeNotifier{
UserModel? userModel;
User? firebaseUser;
String language = "en";


MyProvider(){
  firebaseUser=FirebaseAuth.instance.currentUser;
  if(firebaseUser!=null){
    initMyUser();
  }
}
void initMyUser()async{
  firebaseUser=FirebaseAuth.instance.currentUser;
  userModel=await FirebaseFunctions.readUser(firebaseUser!.uid);
  notifyListeners();


}
void logout(){
  FirebaseAuth.instance.signOut();
  notifyListeners();

}
void changeLanguage(String lang){
  language=lang;
  notifyListeners();
}
}