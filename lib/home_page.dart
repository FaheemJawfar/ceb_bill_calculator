import 'package:ceb_bill_calculator/about_us.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

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
  String _selectedLanguage = 'English';
  bool initializing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CEB Bill Calculator - 2023'),
        actions: [
          IconButton(onPressed: () {
            Share.share('CEB Bill Calculator - 2023 app helps to calculate your monthly CEB bill amount on your mobile. \nDownload now from Play store : https://play.google.com/store/apps/details?id=com.faheemapps.ceb_bill_calculator ');
          }, icon: const Icon(Icons.share)),
          PopupMenuButton(
              itemBuilder: (context){
                return [
                  PopupMenuItem<int>(
                    value: 0,
                    child: Row(
                      children: const [
                        Icon(Icons.info_outline, color: Colors.black,),
                        SizedBox(width: 5,),
                        Text("About us"),
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

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: const [
              //     CommonDropDown(),
              //   ],
              // ),
              const SizedBox(height: 20,),
              const Text(
                'Enter number of units',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
                  child: const Text('Calculate',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
              ),
              const SizedBox(
                height: 50,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('ENERGY CHARGE'),
                      Text('Rs. ${energyCharge.toStringAsFixed(2)}'),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('FIXED CHARGE'),
                      Text('Rs. ${fixedCharge.toStringAsFixed(2)}'),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('SSCL TAX'),
                      Text('Rs. ${taxAmount.toStringAsFixed(2)}'),
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
                  const Text(
                    'Total Amount:',
                    style: TextStyle(
                        color: Colors.red,
                        // fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Text(
                    'Rs. ${totalAmount.toStringAsFixed(2)}',
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
      showSnackBar('Please enter number of units!');
      return false;
    }

    num? number = num.tryParse(input.toString());
    if (number == null) {
      showSnackBar('Please enter number of units correctly!');
      return false;
    }

    if (number <= 0) {
      showSnackBar('Please enter a positive number');
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
