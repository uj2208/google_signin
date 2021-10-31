import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_signin/enum/verifiction_enum.dart';
import 'package:google_signin/provider/phone_verify_provider.dart';
import 'package:provider/src/provider.dart';
class OtpDailog extends StatefulWidget {
  @override
  _OtpDailogState createState() => _OtpDailogState();
}

class _OtpDailogState extends State<OtpDailog> {
  MobileVerifiactionState currentState = MobileVerifiactionState.SHOW_MOBILE_FORM_STATE;
  final phoneEditingCtrl = new TextEditingController();
  final otpEditingCtrl = new TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationId ='';
  bool showLoading =false;
  final GlobalKey<ScaffoldState>_scafoldKey = GlobalKey();
  Widget getMobileFormWidget(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        TextField(
          controller: phoneEditingCtrl,
          decoration: InputDecoration(
            hintText: 'Phone Number',
          ),
        ),
        SizedBox(height: 16,),
        ElevatedButton(onPressed: () async{
          context.read<PhoneProvider>().verifyPhoneNumber(phoneEditingCtrl.text);

        }, child: Text('Send')),
        Spacer(),
      ],
    );
  }
  Widget getOtpFormWidget(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        TextField(
          controller: otpEditingCtrl,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'OTP',
          ),
        ),
        SizedBox(height: 16,),
        ElevatedButton(onPressed: () {
          PhoneAuthCredential phoneAuthCredential =
          PhoneAuthProvider.credential(verificationId: Provider.of<PhoneProvider>(context, listen: false).verificationId, smsCode: otpEditingCtrl.text);
          context.read<PhoneProvider>().signInWithPhoneAuthCredential(phoneAuthCredential);
        }, child: Text('Verify')),
        Spacer(),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    print(context.watch<PhoneProvider>().verified);
    if(context.watch<PhoneProvider>().verified=="PhoneVerified"){
      Navigator.pop(context);
    }
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Mobile Verifiaction'),
          GestureDetector(
            onTap: (){
                Navigator.pop(context);
            },
            child: Icon(Icons.cancel),
          )
        ],
      ),
      content: Container(
      key: _scafoldKey,
      height: 170,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(10),
      child:   context.watch<PhoneProvider>().show_spinner?Center(child: CircularProgressIndicator(),):
      context.watch<PhoneProvider>().currentState == MobileVerifiactionState.SHOW_MOBILE_FORM_STATE?
      getMobileFormWidget(context):
      getOtpFormWidget(context),
      ),
    );
  }
}
