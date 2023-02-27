import 'package:flutter/material.dart';



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
          Image.asset('assets/images/logo.png',height: 60,width: 60,),
          const SizedBox(height: 20,),
          const Text('This is not an official app of CEB. We have followed the calculation methods provided in www.ceb.lk website to calculate the latest charges of CEB.'),
          const SizedBox(height: 10,),
          const Text('We are expecting your feedbacks and comments. Please inform us if you find any mistakes or bugs in this app'),
          const SizedBox(height: 40,),
          const Text('App Developed by :'),
          const Text('Faheem Apps',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)

        ],
      ),
      ),
    );
  }



}
