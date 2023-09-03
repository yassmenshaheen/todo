import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/layout/home_layout.dart';
import 'package:todo/shared/style/colors/app_color.dart';

import '../BottomSheetLang.dart';
import '../providers/my_provider.dart';

class settingTab extends StatefulWidget {
 static const String routeName="setting";

  @override
  State<settingTab> createState() => _settingTabState();
}

class _settingTabState extends State<settingTab> {
  int currentIndex=0;
  @override
  Widget build(BuildContext context) {
    var pro=Provider.of<MyProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(context, Homelyout.routeName, (route) => false);
          },
            child: Icon(Icons.arrow_back)),
        title: Text("Setting",style: TextStyle(fontSize: 25),),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("language"),
            SizedBox(
              height: 12,
            ),
            InkWell(
              onTap: () {
                showBottomSheetLanguage(context);

              },
              child: Container(
                margin: EdgeInsets.all(8),
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: primaryColor),
                ),
                child: Text(pro.language=='ar'?'Arabic':'English'
                ),),),
            SizedBox(
              height: 25,
            ),
            Text("Mode"),
            InkWell(
              onTap: () {
                showBottomSheetLanguage(context);

              },
              child: Container(
                margin: EdgeInsets.all(8),
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: primaryColor),
                ),
                child: Text("Light"),
              ),
            ),
          ],
        ),
      ),

    );
  }
  showBottomSheetLanguage(BuildContext context){
    return showModalBottomSheet(context: context, builder: (context){
      return BottomSheetLang();
    });
  }
}
