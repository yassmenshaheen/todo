
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/layout/home_layout.dart';
import 'package:todo/shared/style/colors/app_color.dart';

import '../../providers/my_provider.dart';
import '../../shared/network/firebase/firebase_functions.dart';
import '../signUp/signup.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName="Login";
  var formKey=GlobalKey<FormState>();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();

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

        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key:formKey ,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: emailController,
                  validator: (value){
                    if(value==null || value=="" ){
                      return "please enter User name";
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
                  validator: (value) {
                    if (value == null || value.length < 6) {
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
                  FirebaseFunctions.login(emailController.text,passwordController.text,(){
                    pro.initMyUser();
                    Navigator.pushNamedAndRemoveUntil(context,
                        Homelyout.routeName, (route) => false);
                  });


                }, child: Text("Login")),
                Row(
                  children: [
                    Text("Don't have an account?"),
                    TextButton(onPressed: () {
                      Navigator.pushNamed(context, SignUpScreen.routeName);

                    }, child: Text("Create Account"))
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
