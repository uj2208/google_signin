import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../provider/google_sign_in.dart';
import 'otp_dialog.dart';
class SuignupWidget extends StatefulWidget {
  @override
  State<SuignupWidget> createState() => _SuignupWidgetState();
}

class _SuignupWidgetState extends State<SuignupWidget> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 15,),
              context.watch<GoogleSignInProvider>().show_spinner?
              Lottie.network('https://assets5.lottiefiles.com/packages/lf20_YMim6w.json'):
                Lottie.network('https://assets4.lottiefiles.com/packages/lf20_naa8hmmn.json'),
                SizedBox(height: 15,),
               Align(
                alignment: Alignment.centerLeft,
                child: Text('Hey There, \nWelcome Back',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold),),
               ),
               SizedBox(height: 8,),
               Align(
                 alignment: Alignment.centerLeft,
                 child: Text('Login to your account to continue',style: TextStyle(fontSize: 16),),
               ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 50,right: 50),
                  child: ElevatedButton.icon(onPressed: (){
                    showDialog(context: context, builder: (context)=>OtpDailog());
                  },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Colors.black,
                          minimumSize: Size(double.infinity,50)
                      ),
                      icon: FaIcon(FontAwesomeIcons.mobile ,color: Colors.grey,),
                      label: Text('Register - Mobileno.')
                  ),
                ),
                SizedBox(height: 15,),
             Padding(
               padding: const EdgeInsets.only(left: 50,right: 50),
               child: ElevatedButton.icon(onPressed: () {
                 context.read<GoogleSignInProvider>().googleLogin();
               },
                   style: ElevatedButton.styleFrom(
                     primary: Colors.white,
                     onPrimary: Colors.black,
                     minimumSize: Size(double.infinity,50)
                   ),
                   icon: FaIcon(FontAwesomeIcons.google ,color: Colors.red,),
                   label: Text('Signup with Google')
               ),
             ),
             SizedBox(height: 40,),
            Consumer<GoogleSignInProvider>(
                builder: (context, provider, child) =>
                    Text('${provider.msg}',style: TextStyle(fontSize: 16,color: provider.clr),) ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

