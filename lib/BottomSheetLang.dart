import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/my_provider.dart';
import 'package:todo/shared/style/colors/app_color.dart';

class BottomSheetLang extends StatelessWidget {
  const BottomSheetLang({super.key});

  @override
  Widget build(BuildContext context) {
    var pro=Provider.of<MyProvider>(context);
    return Container(
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              pro.changeLanguage("ar");

            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text("Arabic"),
                  Spacer(),
                  Icon(Icons.done),
                ],
              ),
            ),
          ),
          Divider(
            thickness: 2,
            color: primaryColor,
          ),
          InkWell(
            onTap: () {
              pro.changeLanguage("en");

            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text("English"),
                  Spacer(),
                  Icon(Icons.done),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
