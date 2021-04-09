import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthClient {
  Completer<void>? _completerVerificationResult;
  String? _verificationId;

  Future<String> sendOtp(String phoneNo, Duration autoretrieveTimeout) {
    if (_completerVerificationResult != null) {
      throw (Exception('A verification is already in process'));
    }
    final completerOtpReceived = Completer<String>();
    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNo,
      verificationCompleted: (authCredential) {
        _completerVerificationResult?.complete();
        _completerVerificationResult = null;
        _verificationId = null;
      },
      verificationFailed: (exception) {
        _completerVerificationResult?.completeError(exception);
        _completerVerificationResult = null;
        _verificationId = null;
      },
      codeSent: (verificationId, resendToken) {
        _verificationId = verificationId;
        _completerVerificationResult = Completer();
        completerOtpReceived.complete(verificationId);
      },
      codeAutoRetrievalTimeout: (verificationId) {
        _completerVerificationResult
            ?.completeError(Exception('auto-retrieval timeout'));
        _completerVerificationResult = null;
        _verificationId = null;
      },
      timeout: autoretrieveTimeout,
    );
    return completerOtpReceived.future;
  }

  Future<void> onOtpAutoVerificationComplete() async {
    if (_completerVerificationResult == null) {
      throw (Exception('Auto-retrieval not in process'));
    }
    return _completerVerificationResult!.future;
  }

  Future<void> verifySmsCode(String smsCode) async {
    if (_verificationId == null) {
      throw (Exception('Auto-retrieval not in process'));
    }
    final credential = PhoneAuthProvider.credential(
      verificationId: _verificationId!,
      smsCode: smsCode,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
