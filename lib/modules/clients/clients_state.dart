import 'package:coyote/models/client_model.dart';

class ClientState {
  final List<ClientModel> clients;
  ClientState({
    this.clients = const [],
  });

  ClientState copyWith({
    List<ClientModel>? clients,
  }) {
    return ClientState(
      clients: clients ?? this.clients,
    );
  }
}
