import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
class GoogleSignInProvider extends ChangeNotifier{
  final googleSignIn = GoogleSignIn();
  final _auth = FirebaseAuth.instance;
   Color clr = Colors.black;
   String msg ="Already Have an account ? Login";
  GoogleSignInAccount? _user;
    bool _show_spinner =false ;
  GoogleSignInProvider(){
    _show_spinner = false;
  }
  set show_spinner(bool show_spinner){
    _show_spinner =show_spinner;
    notifyListeners();
  }
   bool get show_spinner => _show_spinner;
  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    show_spinner = true;
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        show_spinner = false;
        return;
      }
      else {
        print("shospin-google"+_show_spinner.toString());
        _user = googleUser;
        final googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken
        );
        await FirebaseAuth.instance.signInWithCredential(credential);
        show_spinner = false;
        notifyListeners();
      }
    }
    catch(e){
      print(e.toString());
    }
  }
  Future googleLogout() async{
    show_spinner = false;
    print("show_spinner"+_show_spinner.toString());
    clr = Colors.blueGrey;
    msg = 'Logged-out Successfully!!';
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
    notifyListeners();
  }
  Future deviceLogout() async{
    await _auth.signOut();
    notifyListeners();
  }
}