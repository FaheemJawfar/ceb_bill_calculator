import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CommonDropDown extends StatefulWidget {

  const CommonDropDown({Key? key})
      : super(key: key);

  @override
  State<CommonDropDown> createState() => _CommonDropDownState();
}

class _CommonDropDownState extends State<CommonDropDown> {


  @override
  void initState() {
    loadDefaults();
    super.initState();
  }


  List<String> dropDownList = ['English', 'Sinhala', 'Tamil'];
  late String dropdownValue;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: DropdownButton<String>(
        value: dropdownValue,
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
          setState(() {
            dropdownValue = value!;
          });
          // Obtain shared preferences.
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('language', value!);
        },
        items:
        dropDownList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Future<void> loadDefaults() async {
    final prefs = await SharedPreferences.getInstance();
    dropdownValue = prefs.getString('language') ?? 'English';

  }
}