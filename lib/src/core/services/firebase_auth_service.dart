import 'package:firebase_auth/firebase_auth.dart';

/// A service class to handle Firebase Phone Authentication (OTP).
class FirebaseOtpService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? _verificationId;

  /// Send OTP to the given phone number.
  Future<void> sendOtp({
    required String phoneNumber,
    required Function onCodeSent,
    required Function onVerificationCompleted,
    required Function onVerificationFailed,
    required Function onTimeout,
  }) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: "+91$phoneNumber", // include country code
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto verification (Android only)
        try {
          await _auth.signInWithCredential(credential);
          onVerificationCompleted();
        } catch (e) {
          onVerificationFailed(e);
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        onVerificationFailed(e);
      },
      codeSent: (String verificationId, int? resendToken) {
        _verificationId = verificationId;
        onCodeSent(verificationId, resendToken);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
        onTimeout();
      },
    );
  }

  /// Verify the OTP entered by the user.
  Future<void> verifyOtp({
    required String smsCode,
    required Function onSuccess,
    required Function onFailure,
  }) async {
    try {
      if (_verificationId == null) {
        throw Exception("No verificationId found. Please request OTP first.");
      }

      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: smsCode,
      );

      await _auth.signInWithCredential(credential);
      onSuccess();
    } catch (e) {
      onFailure(e);
    }
  }
}
