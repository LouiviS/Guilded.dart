import 'dart:convert';
import 'dart:io';

import '../users/ClientUser.dart';
import '../message/Message.dart';

class Client {
  String _base = 'https://api.guilded.gg/';
  HttpClient _session = HttpClient();

  String _email = "";
  String _password = "";
  bool _connected = false;

  String getEmail() {
    return _email;
  }

  String getPassword() {
    return _password;
  }

  void login(String email, String password) async {
    _email = email;
    _password = password;

    // Try to connect
    final request = await _session.postUrl(Uri.parse(_base + 'login'));
    request.headers
        .set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");

    var data = {};
    data["email"] = email;
    data["password"] = password;

    request.write(json.encode(data));

    final response = await request.close();

    response.transform(utf8.decoder).listen((contents) {
      print(response.statusCode);
      print(contents);
    });
  }

  void on(String eventname, Function f) {
    if (_email == "" || _password == "") {
      throw 'ClientError: "No email or password was given"';
    }
    f(new Message());
  }

  ClientUser getUser() {
    if (_email == "" || _password == "") {
      throw 'ClientError: "No email or password was given"';
    }
    return new ClientUser(this);
  }
}
