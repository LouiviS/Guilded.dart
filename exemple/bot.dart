import '../bin/Guilded.dart';

void main() {
  var client = Client();
  client.login('email@gmail.com', 'password');
  client.on(Events.Ready, onReady);
}

void onReady(ClientUser user) {
  print('Online as ${user.getName()}');
  print('Bot Name: ' + user.getName());
  print('Bot Id: ' + user.getId());
}
