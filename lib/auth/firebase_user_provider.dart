import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class VixRoaderTruckFirebaseUser {
  VixRoaderTruckFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

VixRoaderTruckFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<VixRoaderTruckFirebaseUser> vixRoaderTruckFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<VixRoaderTruckFirebaseUser>(
            (user) => currentUser = VixRoaderTruckFirebaseUser(user));
