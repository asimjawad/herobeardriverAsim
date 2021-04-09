import 'package:firebase_database/firebase_database.dart';
import 'package:hero_bear_driver/data/models/online_model.dart';

class FirebaseDbClient {
  final _chatDb = FirebaseDatabase.instance.reference().child('online_drivers');

  Future<void> setUserOnline(int userId, OnlineModel model) =>
      _chatDb.child(userId.toString()).set(model.toJson());

  Future<void> setUserOffline(int userId) =>
      _chatDb.child(userId.toString()).set(null);
}
