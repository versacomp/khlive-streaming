import 'dart:html';
import 'dart:async';

import 'package:angular2/core.dart';
import 'package:firebase/firebase.dart' as fb;

import '../events/event.dart' as ev;

@Injectable()
class FirebaseService {
  fb.Auth _fbAuth;
  fb.GoogleAuthProvider _fbGoogleAuthProvider;
  fb.Database _fbDatabase;
  fb.Storage _fbStorage;
  fb.DatabaseReference _refEvents;
  fb.User user;

  List<ev.Event> events;
  int EventsCount = 0;

  FirebaseService() {
    fb.initializeApp(
        apiKey: "AIzaSyDdndrBb-kb7BXBbU9TDRVg4ncBlXM3Gtg",
        authDomain: "khlive-171612.firebaseapp.com",
        databaseURL: "https://khlive-171612.firebaseio.com",
        storageBucket: "khlive-171612.appspot.com"
    );

    _fbGoogleAuthProvider = new fb.GoogleAuthProvider();
    _fbAuth = fb.auth();
    _fbAuth.onAuthStateChanged.listen(_authChanged);

    _fbDatabase = fb.database();
    _refEvents = fb.database().ref('events');

  }

  void _authChanged(fb.AuthEvent event) {
    user = event.user;

    if (user != null) {
      events = [];
      _refEvents.limitToLast(3).onChildAdded.listen(_newEvent);
    } else {
      EventsCount = 0;
    }
  }

  void _newEvent(fb.QueryEvent event) {
    ev.Event evt = new ev.Event.fromMap(event.snapshot.val());
    events.add(evt);
    EventsCount = events.length;
  }

  Future signIn() async {
    try {
      await _fbAuth.signInWithPopup(_fbGoogleAuthProvider);
    }
    catch (error) {
      print("$runtimeType::login() -- $error");
    }
  }

  void signOut() {
    _fbAuth.signOut();
  }

}