import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_signin/enum/verifiction_enum.dart';
class PhoneProvider extends ChangeNotifier{
  FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationId ='';
  String _verified ='';
  bool _show_spinner =false ;
  PhoneProvider(){
    _show_spinner = false;
    _verified ='';
  }
  set show_spinner(bool showSpinner){
    _show_spinner =showSpinner;
    notifyListeners();
  }
  set verified (String verified){
    _verified = verified;
    notifyListeners();
  }

  bool get show_spinner => _show_spinner;
  String get verified => _verified;
  String msg ='';
  MobileVerifiactionState currentState = MobileVerifiactionState.SHOW_MOBILE_FORM_STATE;
  void signInWithPhoneAuthCredential(PhoneAuthCredential phoneAuthCredential) async{
    show_spinner = true;
    verified = "notYet";
    try{
      final authCredential =
      await _auth.signInWithCredential(phoneAuthCredential);
      show_spinner = false;
      if(authCredential.user!=null){
        verified = "PhoneVerified";
      }
      notifyListeners();
    }
    on FirebaseAuthException catch (e){
      msg = e.message.toString();
    }
  }
  Future<void> verifyPhoneNumber(String phoneNo) async {
    show_spinner = true;
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNo,
        verificationCompleted: (phoneauthCredential)async{
          show_spinner= false;
        },
        verificationFailed: (verificationFailed) async{
          show_spinner= false;
            msg = verificationFailed.message.toString();
        },
        codeSent: (verifiactionId ,resendingToken) async{
          show_spinner= false;
            currentState = MobileVerifiactionState.SHOW_OTP_FORM_STATE;
            verificationId =verifiactionId;
        },
        codeAutoRetrievalTimeout: (verificationId) async{

        }
    );
    notifyListeners();
  }

}