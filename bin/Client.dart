import 'dart:convert';
import 'dart:io';

import 'ClientUser.dart';
import 'Message.dart';
import 'Events.dart';

class Client {
  final String _base = 'https://api.guilded.gg/';
  final HttpClient _session = HttpClient();
  Map _user = null;

  final Map<Events, Function> _e = <Events, Function>{};
  String _email = '';
  String _password = '';
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
        .set(HttpHeaders.contentTypeHeader, 'application/json; charset=UTF-8');

    var data = {};
    data['email'] = email;
    data['password'] = password;

    request.write(json.encode(data));

    final response = await request.close();

    response.transform(utf8.decoder).listen((contents) {
      if (response.statusCode == 400) {
        throw 'LoginError: Failed to login, verify the email & password';
      }
      if (response.statusCode == 200) {
        Map data = json.decode(contents);
        _user = data['user'];

        _e.forEach((key, value) {
          if (key == Events.Ready) {
            value.call(ClientUser(this, _user));
          }
        });
      }
    });
  }

  void on(Events event, Function f) {
    if (_email == '' || _password == '') {
      throw 'ClientError: "No email or password was given"';
    }
    _e[event] = f;
    switch (event) {
      case Events.Message:
        {
          f(Message());
          break;
        }

      default:
        {
          break;
        }
    }
  }

  ClientUser getUser() {
    if (_email == '' || _password == '') {
      throw 'ClientError: "No email or password was given"';
    }
    return ClientUser(this, _user);
  }
}
