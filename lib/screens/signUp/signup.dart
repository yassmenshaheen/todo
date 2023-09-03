
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/layout/home_layout.dart';
import 'package:todo/providers/my_provider.dart';

import '../../shared/network/firebase/firebase_functions.dart';
import '../../shared/style/colors/app_color.dart';
import '../login/login.dart';

class SignUpScreen extends StatelessWidget {
  static const String routeName="SignUp";
  var formKey=GlobalKey<FormState>();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var nameController=TextEditingController();
  var ageController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    var pro=Provider.of<MyProvider>(context);
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.jpg"),
            fit: BoxFit.fill,
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body:  Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key:formKey ,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: nameController,
                  textInputAction: TextInputAction.next,
                  validator: (value){
                    if(value==null || value=="" ){
                      return "please enter name";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    label: Text("Name"),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: primaryColor),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: primaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: primaryColor),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: ageController,
                  textInputAction: TextInputAction.next,
                  validator: (value){
                    if(value==null || value=="" ){
                      return "please enter Age";
                    }

                    return null;
                  },
                  keyboardType:TextInputType.number,
                  decoration: InputDecoration(
                    label: Text("Age"),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: primaryColor),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: primaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: primaryColor),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: emailController,
                  textInputAction: TextInputAction.next,
                  validator: (value){
                    if(value==null || value=="" ){
                      return "please enter Email";
                    }
                    final bool emailValid =
                    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[gmail]+\.[com]+")
                        .hasMatch(value);
                    if(!emailValid){
                      return "please enter valid email";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    label: Text("Username"),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: primaryColor),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: primaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: primaryColor),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: passwordController,
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.length < 4) {
                      return "please enter valid password";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    label: Text("Password"),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: primaryColor),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: primaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: primaryColor),
                    ),
                  ),
                ),
                ElevatedButton(onPressed: () {
                  formKey.currentState!.validate();
                  FirebaseFunctions.signUp(emailController.text,
                  passwordController.text,nameController.text,int.parse(ageController.text)).then((value){
                    Navigator.pushNamedAndRemoveUntil(context,
                        LoginScreen.routeName, (route) => false);

                  }).catchError((e){
                    print("e");
                  });

                }, child: Text("Sign Up")),
                Row(
                  children: [
                    Text("I have an account"),
                    TextButton(onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(context, Homelyout.routeName,
                              (route) => false);

                    }, child: Text("Login"))
                  ],
                )
              ],
            ),
          ),
        ),

      ),


    );


  }
}
