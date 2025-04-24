part of 'client_bloc.dart';

sealed class ClientState extends Equatable {
  const ClientState();



}

final class ClientInitialState extends ClientState {
  @override
  List<Object> get props => [];
}

final class ClientConnectedState  extends ClientState{
  final Uint8List? sharedFileBytes;
  final String? sharedFileName;

  ClientConnectedState(this.sharedFileBytes, this.sharedFileName);

  @override
  List<Object?> get props => [sharedFileBytes, sharedFileName];

}

final class ClientErrorState extends ClientState{
  final String errorMessage;

  ClientErrorState(this.errorMessage);
  @override
  List<Object?> get props => [errorMessage];

}

final class ClientLoadingState extends ClientState{
  @override
  List<Object?> get props => [];

}


