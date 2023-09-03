import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/shared/style/colors/app_color.dart';

import '../../shared/network/firebase/firebase_functions.dart';

class AddTaskBottomSheet extends StatefulWidget {

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var formKey = GlobalKey<FormState>();
  var selectedDate = DateTime.now();
  var titleController=TextEditingController();
  var descriptionController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.center,
                child: Text("Add New Task",
                  style: GoogleFonts.elMessiri(color: Colors.blue.shade400,
                      fontSize: 25,fontWeight: FontWeight.bold),)),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: titleController,
              validator: (value) {
                if(value.toString().length < 4){
                  return "please enter title at lest 4 char";
                }
                return null;
              },
              decoration: InputDecoration(label: Text("Task Title"),
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
              decoration: InputDecoration(label: Text("Task Descraption"),
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
            Container(width: double.infinity, child: Text("Select Date",
              style: GoogleFonts.quicksand(fontSize: 18,color: primaryColor,fontWeight: FontWeight.bold),)),
            InkWell(
              onTap: () {
                chooseDateTime();
              },
                child: Container(alignment: Alignment.center, child:
                Text(selectedDate.toString().substring(0,10),
                  style: GoogleFonts.quicksand(fontSize: 16),))),
            SizedBox(
              height: 18,
            ),
            ElevatedButton(onPressed: () {
              if(formKey.currentState!.validate()){
                TaskModle task=TaskModle(description: descriptionController.text,
                    title: titleController.text,
                    userId: FirebaseAuth.instance.currentUser!.uid,
                    date: DateUtils.dateOnly(selectedDate).millisecondsSinceEpoch);
                FirebaseFunctions.addTask(task);
                  Navigator.pop(context);


              }
            }, child: Text("Add Task"))

          ],
        ),
      ),
    );
  }

  void chooseDateTime()async{
     DateTime? chooseDate=
        await showDatePicker(context: context,
        builder: (context, child) {
          return Theme(data: ThemeData(), child: child!);
        },
        initialDate: selectedDate ,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
     if(chooseDate != null){
       selectedDate = chooseDate;
       setState(() {

       });
     }

  }
}
