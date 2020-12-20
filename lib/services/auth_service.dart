import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Future<UserCredential> createWithEmailandPassword({email, password}) async {
    try {
      var user=await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return user;
    } catch (e, s) {
      throw (s);
    }
  }
  Future<UserCredential> signInWithEmailandPassword({email, password}) async {
    try {
      var user=await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return user;
    } catch (e, s) {
      throw (s);
    }
  }

  // sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }





















  
  // Future createUserWithPhone(String phone, BuildContext context) async {
  //   await _auth.verifyPhoneNumber(
  //     phoneNumber: phone,
  //     timeout: Duration(seconds: 10),
  //     verificationCompleted: (PhoneAuthCredential credential) async {
  //       // Navigator.pop(context);
  //       UserCredential userCredential =
  //           await _auth.signInWithCredential(credential);
  //       User user = userCredential.user;
  //
  //       if (user != null) {
  //         Navigator.push(
  //             context, MaterialPageRoute(builder: (context) => MyHomePage()));
  //       } else {
  //         return "error";
  //       }
  //     },
  //     verificationFailed: (FirebaseAuthException e) {
  //       if (e.code == 'invalid-phone-number') {
  //         print('The provided phone number is not valid.');
  //       }
  //     },
  //     codeSent: (String verificationId, int resendToken) async {
  //       final _codeController = TextEditingController();
  //       showDialog(
  //           barrierDismissible: false,
  //           context: context,
  //           builder: (_) {
  //             return AlertDialog(
  //               title: Text('Give the Code?'),
  //               content: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   TextField(
  //                     controller: _codeController,
  //                   ),
  //                 ],
  //               ),
  //               actions: [
  //                 FlatButton(
  //                   child: Text('Confirm'),
  //                   textColor: Colors.white,
  //                   color: Colors.blue,
  //                   onPressed: () async {
  //                     final code = _codeController.text.trim();
  //                     PhoneAuthCredential phoneAuthCredential =
  //                         PhoneAuthProvider.credential(
  //                             verificationId: verificationId, smsCode: code);
  //                     UserCredential userCredential =
  //                         await _auth.signInWithCredential(phoneAuthCredential);
  //
  //                     User user = userCredential.user;
  //
  //                     if (user != null) {
  //                       Navigator.push(
  //                           context,
  //                           MaterialPageRoute(
  //                               builder: (context) => MyHomePage()));
  //                     } else {
  //                       return "Error";
  //                     }
  //                   },
  //                 )
  //               ],
  //             );
  //           });
  //     },
  //     codeAutoRetrievalTimeout: (String verificationId) {
  //       print(verificationId);
  //     },
  //   );
  // }
}
