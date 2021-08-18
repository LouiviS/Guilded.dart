import '../lib/client/Client.dart';
import '../lib/message/Message.dart';

void main() {
  Client client = new Client();
  client.login("email@gmail.com", "passwordpassword");

  print(client.getUser().getDisplayName());
  client.on("NewMessage", onMessage);
}

void onMessage(Message msg) {
  print(msg.getContent());
}
