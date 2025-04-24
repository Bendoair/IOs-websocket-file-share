import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_file_share/socket/client_socket_service.dart';

part 'client_event.dart';
part 'client_state.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  ClientBloc() : super(ClientInitialState()) {
    on<TryConnectClientEvent>((event, emit) {
      String address = event.socketAddress;
      socketClient.initialize(
          address,
          (data) {
            //List<int> fileBytesIntList = data[1] as List<int>;
            Uint8List? fileBytes = Uint8List.fromList(List<int>.from(data[1]));
            String? fileName = data[0] as String?;
            debugPrint("Raw data received: $data");
            debugPrint("File bytes: $fileBytes");
            debugPrint("File name: $fileName");

            add(ClientFileReceivedEvent(fileBytes, fileName));
          },
          (errorMessage) => {add(ClientExceptionEvent(Exception(errorMessage)))}
      );
      emit(ClientConnectedState(null,null));

    });
    on<ClientResetEvent>((event, emit) {
      socketClient.dispose();
      socketClient = SocketClient();
      emit(ClientInitialState());
    });

    on<ClientExceptionEvent>((event, emit) {
      String message = event.e.toString();
      emit(ClientErrorState(message));
    });

    on<ClientRequestFileEvent>((event, emit) {
      socketClient.getLatestFile();
      emit(ClientLoadingState());
      //emit(ClientConnectedState(null));
    });

    on<ClientFileReceivedEvent>((event, emit) {

      emit(ClientConnectedState(event.fileBytes, event.fileName));

    });



  }
}
