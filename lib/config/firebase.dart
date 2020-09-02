import 'package:firebase_core/firebase_core.dart';

class FireBaseConfig {
  static init() async {
    final FirebaseOptions firebaseOptions = const FirebaseOptions(
      appId: '1:370532386848:android:7b84dc28f88524681f9445',
      messagingSenderId: '370532386848',
      apiKey: 'AIzaSyDksYO30mrIuI7eu9WF66HvzK_ViPXipUE',
      projectId: 'videofamosos-839c9',
    );

    if (Firebase.apps.length == 0) {
      Firebase.initializeApp(options: firebaseOptions);
    }
  }
}
