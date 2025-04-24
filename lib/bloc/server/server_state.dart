part of 'server_bloc.dart';

sealed class ServerState extends Equatable {
  const ServerState();
}

final class ServerInitial extends ServerState {
  @override
  List<Object> get props => [];
}

final class ServerSetupState extends ServerState{
  final int portAddress;

  ServerSetupState(this.portAddress);

  @override
  List<Object?> get props => [portAddress];
}

final class ServerFileChosenState extends ServerState{
  final int portAddress;
  final Uint8List chosenFileBytes;
  final String chosenFileName;

  ServerFileChosenState(this.portAddress, this.chosenFileBytes, this.chosenFileName);

  @override
  List<Object?> get props => [portAddress, chosenFileBytes];

}

final class ServerErrorState extends ServerState{
  final String errorMessage;

  ServerErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];

}
