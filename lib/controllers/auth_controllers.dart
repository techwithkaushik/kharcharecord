import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:kharcharecord/utils/custom_widgets.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final _isPhoneLoading = false.obs;

  bool get isPhoneLoading => _isPhoneLoading.value;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(_auth.currentUser);
    _user.bindStream(_auth.userChanges());
    ever(_user, _initScreen);
  }

  _initScreen(User? user) {
    if (user == null) {
      Get.offAllNamed("/welcome");
    } else {
      Get.offAllNamed("/home");
    }
  }

  int? resendToken = 0;

  Future<void> signInWithPhone(String? phoneNumber) async {
    _isPhoneLoading.value = true;
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (phoneAuthCredential) async {
          await _auth.signInWithCredential(phoneAuthCredential);
          _isPhoneLoading.value = false;
        },
        verificationFailed: (error) {
          _isPhoneLoading.value = false;
          showSnackBar(title: "Verification Failed", message: '$error');
        },
        codeSent: (verificationId, forceResendingToken) {
          _isPhoneLoading.value = false;
          resendToken = forceResendingToken;
          Get.toNamed(
            "/otp",
            parameters: {
              'phoneNumber': phoneNumber!,
              'verificationId': verificationId,
            },
          );
        },
        forceResendingToken: resendToken,
        codeAutoRetrievalTimeout: (verificationId) {
          _isPhoneLoading.value = false;
        },
        timeout: const Duration(minutes: 1),
      );
    } on FirebaseAuthException catch (e) {
      _isPhoneLoading.value = false;
      showSnackBar(title: "SignIn Error", message: e.toString());
    } catch (e) {
      _isPhoneLoading.value = false;
      showSnackBar(title: "SignIn Catch", message: e.toString());
    }
  }

  Future<void> verifyOTP(String verificationId, String otp) async {
    PhoneAuthCredential cred = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otp);
    try {
      await _auth.signInWithCredential(cred);
    } on FirebaseAuthException catch (e) {
      showSnackBar(title: "VerifyOTP Error", message: e.toString());
    } catch (e) {
      showSnackBar(title: "VerifyOTP Catch", message: e.toString());
    }
  }

  signingOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      showSnackBar(title: "Sign Out Error", message: e.toString());
    } catch (e) {
      showSnackBar(title: "Sign Out Catch", message: e.toString());
    }
  }
}
