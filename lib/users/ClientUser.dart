import '../client/Client.dart';

class ClientUser {
  late Client _client;

  ClientUser(Client client) {
    this._client = client;
  }

  String getName() {
    return "BOT IN DART";
  }

  String getDisplayName() {
    return "DISPLAY BOT";
  }
}
