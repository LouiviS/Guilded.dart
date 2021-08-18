import '../bin/Client.dart';
import '../bin/Events.dart';
import '../bin/Message.dart';

void main() {
  var client = Client();
  client.login('email@gmail.com', 'password');

  print(client.getUser().getDisplayName());
  client.on(Events.Message, onMessage);
}

void onMessage(Message msg) {
  print(msg.getContent());
}
