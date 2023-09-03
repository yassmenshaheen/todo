
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/task_model.dart';

import '../../../models/user_model.dart';

class FirebaseFunctions {

  static CollectionReference<TaskModle> getTasksColection(){
    return FirebaseFirestore.instance.collection("Tasks")
        .withConverter<TaskModle>(fromFirestore:(snapshot,_){
      return TaskModle.fromJson(snapshot.data()!);
    },
      toFirestore: (value,_){
        return value.toJson();


      },);
  }

  static CollectionReference<UserModel> getUserColection(){
    return FirebaseFirestore.instance.collection("Users")
        .withConverter<UserModel>(fromFirestore:(snapshot,_){
      return UserModel.fromJson(snapshot.data()!);
    },
      toFirestore: (value,_){
        return value.toJson();


      },);
  }


  static Future<void> addTask(TaskModle task) {
     var collection= getTasksColection();
     var docRef=collection.doc();
     task.id=docRef.id;
      return docRef.set(task);

  }

  static Stream<QuerySnapshot<TaskModle>>getTasks(DateTime date){
    print(date.millisecondsSinceEpoch);
     return getTasksColection().where("userId",isEqualTo: FirebaseAuth.instance.currentUser!.uid).
     where("date",isEqualTo: DateUtils.dateOnly(date).millisecondsSinceEpoch).snapshots();
  }

   static Future<void> deleteTask(String id){
     return getTasksColection().doc(id).delete();

  }

  static Future<void> UpdateTask(TaskModle task){
    return getTasksColection().doc(task.id).update(task.toJson());


  }

    static Future<void>signUp(String email,String password,String name,int age)async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      UserModel userModel= UserModel(name: name, age: age, email: email,
      id: credential.user!.uid);
      var collection=getUserColection();
      var docRef=collection.doc(credential.user!.uid);
      docRef.set(userModel);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void>login(String email,String password,Function onComplete)async{
    try {
       await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password).then((value) {
         onComplete();

      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }

  }

  static Future<UserModel?> readUser(String userId)async{
    DocumentSnapshot<UserModel> userDoc=
    await getUserColection().doc(userId).get();
    return userDoc.data();

  }
}
