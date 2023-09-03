import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/my_provider.dart';
import 'package:todo/screens/login/login.dart';
import 'package:todo/screens/taskes/add_task_bottomsheet.dart';

import '../screens/setting.dart';
import '../screens/taskes/taskes.dart';

class Homelyout extends StatefulWidget {
  static const String routeName="Homelayout";
  const Homelyout({super.key});

  @override
  State<Homelyout> createState() => _HomelyoutState();
}

class _HomelyoutState extends State<Homelyout> {
  int currentIndex=0;
  List<Widget>tabs=[taskesTab(),settingTab()];

  @override
  Widget build(BuildContext context) {
    var pro= Provider.of<MyProvider>(context);
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text("ToDo${pro.userModel?.name}",style: TextStyle(fontSize: 30),),
        actions: [
          IconButton(onPressed: () {
            pro.logout();
            Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName, (route) => false);
          }, icon: Icon(Icons.logout,
          color: Colors.white,
          size: 30,))
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
          side: BorderSide(color: Colors.white,width: 4)),
        onPressed: (){
          showAddTaskBottmSheet();
        },
        child:
        Icon(Icons.add,size: 30,),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8,
        shape:  CircularNotchedRectangle(),
        color: Colors.white,
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,

          currentIndex:currentIndex,
          onTap: (value) {
            currentIndex=value;
            setState(() {
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.list),label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.settings),label: ""),
          ],
        ),
      ),
      body:tabs[currentIndex] ,
    );
  }
  void showAddTaskBottmSheet(){
    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight:Radius.circular(18),
            topLeft: Radius.circular(18))
      ),
      context: context, builder
        : (context) => Padding(
          padding:  EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom
          ),
          child: AddTaskBottomSheet(),
        ),);
  }
}
