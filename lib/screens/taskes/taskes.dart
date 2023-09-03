
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/screens/taskes/task_item.dart';
import 'package:todo/shared/network/firebase/firebase_functions.dart';

import '../../shared/style/colors/app_color.dart';

class taskesTab extends StatefulWidget {
  @override
  State<taskesTab> createState() => _taskesTabState();
}

class _taskesTabState extends State<taskesTab> {
  DateTime selectedDate=DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CalendarTimeline(
          initialDate: selectedDate,
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now().add(Duration(days: 365)),
          onDateSelected: (date) {
            selectedDate=date;
            setState(() {

            });
          },

          leftMargin: 20,
          monthColor: primaryColor,
          dayColor: primaryColor.withOpacity(.6),
          activeDayColor: Colors.white,
          activeBackgroundDayColor: primaryColor,
          dotsColor: primaryColor,
          selectableDayPredicate: (date) => date.day == 23,
          locale: 'en_ISO',
        ),
         StreamBuilder(
           stream: FirebaseFunctions.getTasks(selectedDate),
         builder: (context, snapshot) {
           if(snapshot.connectionState==ConnectionState.waiting){
             return Center(child: CircularProgressIndicator());

           }
           if(snapshot.hasError){
             return Text("Something wrong");
           }
           var tasks=snapshot.data?.docs.map((e)=> e.data()).toList()??[];
           if(tasks.isEmpty){
             return Center(child: Text("No Tasks"));
           }
           return Expanded(
             child: ListView.builder(itemBuilder: (context, index) {
               return TaskItem(taskModle: tasks[index],);
             },itemCount: tasks.length,
             ),
           );
         },)
      ],

    );
  }
}
