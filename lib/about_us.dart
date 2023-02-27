import 'package:flutter/material.dart';
import 'package:get/get.dart';



class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About us'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/logo.png',height: 80,width: 80,),
          const SizedBox(height: 30,),
          Text('about_us_p1'.tr),
          const SizedBox(height: 10,),
          Text('about_us_p2'.tr),
          const SizedBox(height: 40,),
          const Text('App Developed by :'),
          const Text('Faheem Apps',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)

        ],
      ),
      ),
    );
  }



}
