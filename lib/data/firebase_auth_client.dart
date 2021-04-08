import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthClient {
  Completer<void>? _completerVerificationResult;

  Future<String> sendOtp(String phoneNo, Duration autoretrieveTimeout) {
    if (_completerVerificationResult != null) {
      throw (Exception('A verification is already in process'));
    }
    _completerVerificationResult = Completer();
    final completerOtpReceived = Completer<String>();
    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNo,
      verificationCompleted: (authCredential) {
        _completerVerificationResult?.complete();
        _completerVerificationResult = null;
      },
      verificationFailed: (exception) {
        _completerVerificationResult?.completeError(exception);
        _completerVerificationResult = null;
      },
      codeSent: (verificationId, resendToken) {
        completerOtpReceived.complete(verificationId);
      },
      codeAutoRetrievalTimeout: (verificationId) {
        _completerVerificationResult
            ?.completeError(Exception('auto-retrieval timeout'));
        _completerVerificationResult = null;
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
}
