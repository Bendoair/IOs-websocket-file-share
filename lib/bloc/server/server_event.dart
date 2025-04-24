part of 'server_bloc.dart';

sealed class ServerEvent{
  const ServerEvent();
}


class TrySetupServerEvent extends ServerEvent{
  final int portNumber;

  TrySetupServerEvent(this.portNumber);
}

class SetFileToSendEvent extends ServerEvent{
  final int portNumber;
  final Uint8List? fileBytes;
  final String? fileName;

  SetFileToSendEvent(this.fileBytes, this.portNumber, this.fileName);
}

class ServerResetEvent extends ServerEvent{

}

class ServerExceptionEvent extends ServerEvent{
  final Exception e;

  ServerExceptionEvent(this.e);
}

class ServerTestCommunicationEvent extends ServerEvent{
  final String message;

  ServerTestCommunicationEvent(this.message);
}

