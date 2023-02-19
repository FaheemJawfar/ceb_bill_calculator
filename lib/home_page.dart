import 'package:flutter/material.dart';


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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CEB Bill Calculator - 2023'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Enter number of units',style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16
            ),),
            const SizedBox(height: 10,),
            TextField(
              controller: unitsInput,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 3, color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(height: 10,),

            ElevatedButton(onPressed: () {
              result = calculateBillAmount(double.parse(unitsInput.text));
              setState(() {
              });

            }, child: const Text('Calculate')),

          const SizedBox(height: 50,),
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

            const SizedBox(height: 50,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total Bill Amount:',style: TextStyle(
                  color: Colors.red,
                 // fontWeight: FontWeight.bold,
                  fontSize: 22
                ),),
                Text('Rs. ${totalAmount.toStringAsFixed(2)}',
                  style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 25
                  ),),
              ],
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }


  double calculateBillAmount(double units) {

    fixedCharge = getFixedCharge(units);
    energyCharge = getEnergyCharge(units);

    double amountWithoutTax = fixedCharge + energyCharge;
    taxAmount = amountWithoutTax  * 0.025;

    totalAmount = amountWithoutTax + taxAmount;
    return totalAmount;
  }

  double getFixedCharge(double units) {
    if (units > 0 && units <= 30) {
      return 400;
    }
    else if (units >= 31 && units <= 60) {
      return 550;
    }
    else if (units >= 61 && units <= 90) {
      return 650;
    }
    else if (units >= 91 && units <= 180) {
      return 1500;
    }
    else {
      return 2000;
    }
  }

  double getEnergyCharge(double units) {
    if (units > 0 && units <= 30) {
      return 30 * units;
    }
    else if (units >= 31 && units <= 60) {
      return 37 * units;
    }
    else if (units >= 61 && units <= 90) {
      return 42 * units;
    }
    else if (units >= 91 && units <= 180) {
      return 50 * units;
    }
    else {
      return 75 * units;
    }
  }

}
