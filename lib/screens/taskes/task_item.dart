import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/screens/edit/edit.dart';
import 'package:todo/shared/style/colors/app_color.dart';

import '../../models/task_model.dart';
import '../../shared/network/firebase/firebase_functions.dart';

class TaskItem extends StatelessWidget {
  TaskModle taskModle;

  TaskItem({ required this.taskModle,super.key});


  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.symmetric(vertical: 12,
        horizontal: 8),
        elevation: 8,shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16)
      ),
        child: Slidable(
          startActionPane: ActionPane(motion: StretchMotion(), children: [
            SlidableAction(
              onPressed: (context){
                FirebaseFunctions.deleteTask(taskModle.id);
              },
              borderRadius: BorderRadius.only(topLeft: Radius.circular(16),
                  topRight: Radius.circular(16)),

              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
            SlidableAction(
              onPressed: (context) {
                Navigator.pushNamedAndRemoveUntil(context,EditScreen.routeName, (route) => false);

              },
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            ),
          ]),
          child: Container(
            margin: EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  height: 80,
                  color: primaryColor,
                  width: 4,
                ),
                SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(taskModle.title,
                      style: GoogleFonts.quicksand(fontSize: 18),),
                    Text(taskModle.description,
                      style: GoogleFonts.quicksand(fontSize: 14),)

                  ],
                ),Spacer(),
                InkWell(
                  onTap:() {
                    taskModle.isDone = !taskModle.isDone;
                    FirebaseFunctions.UpdateTask(taskModle);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 2,horizontal: 12),
                    decoration: BoxDecoration(
                      color:taskModle.isDone?Colors.green : primaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.done,
                    color: Colors.white,
                    size: 30,),

                  ),
                ),
              ],
          ),
      ),
        ),
    );
  }
}
