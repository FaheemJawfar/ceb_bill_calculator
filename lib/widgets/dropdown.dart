import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';


class CommonDropDown extends StatefulWidget {
  final List<String> dropDownList;
  final String dropdownValue;

  const CommonDropDown({
    required this.dropDownList,
    required this.dropdownValue,
    Key? key})
      : super(key: key);

  @override
  State<CommonDropDown> createState() => _CommonDropDownState();
}

class _CommonDropDownState extends State<CommonDropDown> {


  late String dropValue = widget.dropdownValue;



  //bool initializing = false;


  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 100,
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: DropdownButton<String>(
        value: dropValue,
        alignment: Alignment.centerLeft,
        icon: const Icon(Icons.arrow_drop_down_circle, color: Colors.indigo),
        // elevation: 16,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 14,
        ),
        isExpanded: true,
        onChanged: (String? value) async {
          // This is called when the user selects an item.
            dropValue = value!;
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('language', value);

          if(value == 'English'){
            MyApp.fontFamily = 'NotoSans-en';
            var locale = const Locale('en', 'US');
            Get.updateLocale(locale);
            await prefs.setString('lang_code', 'en');
            await prefs.setString('country_code', 'US');
          }
          else if (value == 'සිංහල'){
            MyApp.fontFamily = 'NotoSans-si';
            var locale = const Locale('si', 'LK');
            Get.updateLocale(locale);
            await prefs.setString('lang_code', 'si');
            await prefs.setString('country_code', 'LK');
          }
          else if (value == 'தமிழ்'){
            MyApp.fontFamily = 'NotoSans-ta';
            var locale = const Locale('ta', 'LK');
            Get.updateLocale(locale);
            await prefs.setString('lang_code', 'ta');
            await prefs.setString('country_code', 'LK');
          }

          setState(() {});
        },
        items:
        widget.dropDownList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

}