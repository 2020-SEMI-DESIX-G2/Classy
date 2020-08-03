
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthorizationBloc {

  String tokenString = "";
  Map<String, dynamic> user;

  final BehaviorSubject _isSessionValid = BehaviorSubject<String>();
  final BehaviorSubject _userTypeController = BehaviorSubject<String>();

  Function(String) get changeSessionValid => _isSessionValid.sink.add;
  Function(String) get changeUserType => _userTypeController.sink.add;

  ValueStream<String> get isSessionValid => _isSessionValid.stream;
  ValueStream<String> get userType => _userTypeController.stream;

  void dispose() {
    _isSessionValid.close();
    _userTypeController.close();
  }

  void restoreSession() async {

    await getPreferences();
    if (tokenString != null && tokenString.length > 0) {

      _isSessionValid.sink.add("HOME");
    } else {
      _isSessionValid.sink.add("LOGIN");
    }
  }

  void openSession(String token, Map<String, dynamic> user) async {

    this.user = user;
    tokenString = token;
    await saveReferences(token, user);
    _isSessionValid.sink.add("HOME");
  }

  Future<void> closeSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
    prefs.remove("email");
    prefs.remove("username");
    prefs.remove("id");
    prefs.remove("preferences");

    _isSessionValid.sink.add("LOGIN");
  }

  Future<void> saveReferences(String token, Map<String, dynamic> user) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
    prefs.setString("email", user['email']);
    prefs.setString("username", user['usuario']);
    prefs.setString("id", user['id']);
    prefs.setStringList("preferences", null != user['preferencias'] ? List<String>.from(['preferencias']) : List.of([""]));
  }

  Future<void> getPreferences() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    tokenString = prefs.get("token");

    Map<String, dynamic> userMap = Map();
    userMap["email"] = prefs.get("email");
    userMap["username"] = prefs.get("username");
    userMap["preferences"] = prefs.get("preferences");
    userMap["id"] = prefs.get("id");
    user = userMap;
  }
}

final authBloc = AuthorizationBloc();