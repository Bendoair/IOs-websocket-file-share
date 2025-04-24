part of 'client_bloc.dart';

sealed class ClientEvent{
  const ClientEvent();
}

class TryConnectClientEvent extends ClientEvent{
  final String socketAddress;

  TryConnectClientEvent(this.socketAddress);
}

class ClientExceptionEvent extends ClientEvent{
  final Exception e;

  ClientExceptionEvent(this.e);
}

class ClientResetEvent extends ClientEvent{

}
class ClientRequestFileEvent extends ClientEvent{

}

class ClientFileReceivedEvent extends ClientEvent{
  final Uint8List? fileBytes;
  final String? fileName;

  ClientFileReceivedEvent(this.fileBytes, this.fileName);
}



