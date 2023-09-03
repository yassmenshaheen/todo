import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/layout/home_layout.dart';

import '../../models/task_model.dart';
import '../../shared/network/firebase/firebase_functions.dart';
import '../../shared/style/colors/app_color.dart';

class EditScreen extends StatefulWidget {
  static const String routeName="edit";

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  var formKey = GlobalKey<FormState>();
  var selectedDate = DateTime.now();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To Do List", style: TextStyle(fontSize: 20),),
        leading: InkWell(
          onTap:  () {
            Navigator.pushNamedAndRemoveUntil(context, Homelyout.routeName, (route) => false);
          },
            child: Icon(Icons.arrow_back, size: 25,)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 18,vertical: 18),
                  alignment: Alignment.center,
                  child: Text("Edit Task",
                    style: GoogleFonts.elMessiri(color: Colors.blue.shade400,
                        fontSize: 25, fontWeight: FontWeight.bold),)),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: titleController,
                validator: (value) {
                  if (value
                      .toString()
                      .length < 4) {
                    return "please enter title at lest 4 char";
                  }
                  return null;
                },
                decoration: InputDecoration(label: Text("this is title"),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                            color: primaryColor
                        )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                            color: primaryColor
                        )
                    )
                ),
              ),
              SizedBox(
                height: 18,
              ),
              TextFormField(
                controller: descriptionController,
                maxLines: 4,
                decoration: InputDecoration(label: Text("task details"),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                            color: primaryColor
                        )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                            color: primaryColor
                        )
                    )
                ),),
              SizedBox(
                height: 12,
              ),
              Container(
                  width: double.infinity, child: Text("Select time",
                style: GoogleFonts.quicksand(fontSize: 18,
                    color: primaryColor,
                    fontWeight: FontWeight.bold),)),
              InkWell(
                  onTap: () {
                    chooseDateTime();
                  },
                  child: Container(alignment: Alignment.center, child:
                  Text(selectedDate.toString().substring(0, 10),
                    style: GoogleFonts.quicksand(fontSize: 16),))),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(onPressed: () {
                if (formKey.currentState!.validate()) {
                  TaskModle task = TaskModle(
                      description: descriptionController.text,
                      title: titleController.text,
                      userId: FirebaseAuth.instance.currentUser!.uid,
                      date: DateUtils
                          .dateOnly(selectedDate)
                          .millisecondsSinceEpoch);
                  FirebaseFunctions.UpdateTask(task);
                  Navigator.pop(context);
                }
              }, child: Text("Save Changes"))

            ],
          ),
        ),
      ),
    );
  }

  void chooseDateTime() async {
    DateTime? chooseDate =
    await showDatePicker(context: context,
        builder: (context, child) {
          return Theme(data: ThemeData(), child: child!);
        },
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (chooseDate != null) {
      selectedDate = chooseDate;
      setState(() {

      });
    }
  }
}
