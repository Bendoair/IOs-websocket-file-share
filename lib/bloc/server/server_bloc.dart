import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_file_share/socket/server_socket_service.dart';

part 'server_event.dart';
part 'server_state.dart';

class ServerBloc extends Bloc<ServerEvent, ServerState> {
  ServerBloc() : super(ServerInitial()) {
    on<TrySetupServerEvent>((event, emit) {
      int socketNumber = event.portNumber;
      socketServer.initialize(socketNumber);
      emit(ServerSetupState(socketNumber));
    });
    on<SetFileToSendEvent>((event, emit){
      Uint8List? fileBytes = event.fileBytes;
      int socketNumber = event.portNumber;
      String? name = event.fileName;

      if(fileBytes == null || name == null){
        debugPrint("Name: $name Bytes: $fileBytes");
        emit(ServerErrorState("File selection error, Selected File registers as \"null\""));
      }else{
        socketServer.setFileToSend(fileBytes, name);
        emit(ServerFileChosenState(socketNumber, fileBytes, name));
      }
    });

    on<ServerResetEvent>((event, emit){
      //socketServer.dispose();
      socketServer = SocketServer();
      emit(ServerInitial());
    });

    on<ServerExceptionEvent>((event, emit){
      String message = event.e.toString();
      emit(ServerErrorState(message));
    });

    on<ServerTestCommunicationEvent>((event, emit){
      String message = event.message;
      debugPrint("Server sent Message: $message");
      socketServer.testCommunication(message);
      socketServer.dispose();
      socketServer = SocketServer();
      emit(ServerInitial());
    });
  }
}
