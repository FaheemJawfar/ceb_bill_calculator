import 'package:ceb_bill_calculator/about_us.dart';
import 'package:ceb_bill_calculator/widgets/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class HomePage extends StatefulWidget {
  final String selectedLanguage;
  const HomePage({
    required this.selectedLanguage,
    Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final unitsInput = TextEditingController();
  double result = 0.0;
  double fixedCharge = 0.0;
  double energyCharge = 0.0;
  double taxAmount = 0.0;
  double totalAmount = 0.0;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CEB Bill Calculator - 2023'),
        actions: [
          IconButton(onPressed: () {
            Share.share('${'share_note'.tr} : https://play.google.com/store/apps/details?id=com.faheemapps.ceb_bill_calculator ');
          }, icon: const Icon(Icons.share)),
          PopupMenuButton(
              itemBuilder: (context){
                return [
                  PopupMenuItem<int>(
                    value: 0,
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline, color: Colors.black,),
                        const SizedBox(width: 5,),
                        Text('about_us'.tr,),
                      ],
                    ),
                  ),
                  //
                  // PopupMenuItem<int>(
                  //   value: 1,
                  //   child: Row(
                  //     children: const [
                  //       Icon(Icons.info_outline, color: Colors.black,),
                  //       SizedBox(width: 5,),
                  //       Text("Settings"),
                  //     ],
                  //   ),
                  // ),
                  //
                  // PopupMenuItem<int>(
                  //   value: 2,
                  //   child: Row(
                  //     children: const [
                  //       Icon(Icons.info_outline, color: Colors.black,),
                  //       SizedBox(width: 5,),
                  //       Text("Log out"),
                  //     ],
                  //   ),
                  // ),
                ];
              },
              onSelected:(value){
                if(value == 0){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutUs()));
                 }
                // else if(value == 1){
                //   print("Settings menu is selected.");
                // }else if(value == 2){
                //   print("Logout menu is selected.");
                // }
              }
          ),
        ],


      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CommonDropDown(
                    dropDownList: const ['English', 'සිංහල', 'தமிழ்'],
                    dropdownValue: widget.selectedLanguage,
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Text(
                'enter_units'.tr,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: unitsInput,
                keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.redAccent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.blue),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    if(isValidNumber(unitsInput.text)){
                      result = calculateBillAmount(double.parse(unitsInput.text));
                      setState(() {
                      });
                    }
                  },
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.blue),
                  foregroundColor: MaterialStatePropertyAll(Colors.white)
                ),
                  child: Text('calculate'.tr,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
              ),
              const SizedBox(
                height: 50,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('energy_charge'.tr),
                      Text('${'rs'.tr}${energyCharge.toStringAsFixed(2)}'),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('fixed_charge'.tr),
                      Text('${'rs'.tr}${fixedCharge.toStringAsFixed(2)}'),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('sscl_tax'.tr),
                      Text('${'rs'.tr}${taxAmount.toStringAsFixed(2)}'),
                    ],
                  ),
                  const Divider(),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'total_amount'.tr,
                    style: const TextStyle(
                        color: Colors.red,
                        // fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Text(
                    '${'rs'.tr}${totalAmount.toStringAsFixed(2)}',
                    style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                ],
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }

  bool isValidNumber(dynamic input) {

    if(input == ''){
      showSnackBar('msg_num_of_units'.tr);
      return false;
    }

    num? number = num.tryParse(input.toString());
    if (number == null) {
      showSnackBar('msg_enter_correctly'.tr);
      return false;
    }

    if (number <= 0) {
      showSnackBar('msg_enter_correctly'.tr);
      return false;
    }
    return true;
  }

  showSnackBar(String content) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(content)));
  }

  double calculateBillAmount(double units) {
    fixedCharge = getFixedCharge(units);
    energyCharge = getEnergyCharge(units);

    double amountWithoutTax = fixedCharge + energyCharge;
    taxAmount = amountWithoutTax * 0.025;

    totalAmount = amountWithoutTax + taxAmount;
    return totalAmount;
  }

  double getFixedCharge(double units) {
    if (units > 0 && units <= 30) {
      return 400;
    } else if (units >= 31 && units <= 60) {
      return 550;
    } else if (units >= 61 && units <= 90) {
      return 650;
    } else if (units >= 91 && units <= 180) {
      return 1500;
    } else {
      return 2000;
    }
  }

  double getEnergyCharge(double units) {
    if (units > 0 && units <= 30) {
      return 30 * units;
    } else if (units >= 31 && units <= 60) {
      return 37 * units;
    } else if (units >= 61 && units <= 90) {
      return 42 * units;
    } else if (units >= 91 && units <= 180) {
      return 50 * units;
    } else {
      return 75 * units;
    }
  }
}
