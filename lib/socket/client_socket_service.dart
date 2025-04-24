
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketClient{
  late IO.Socket socket;

  void initialize(String socketAddress, Function(dynamic data) fileReceiveHandler, Function(dynamic data) socketErrorHandler){


    socket = IO.io(socketAddress,
        IO.OptionBuilder()
        .setTransports(["websocket"])
        .enableForceNewConnection()
            .build()

    );
    //TODO create this file SOMEWHERE and call .writeAsBytes(data)
    socket.on("fileSend", (data) {
       fileReceiveHandler(data);
    });
    socket.on("testEvent", (message) => debugPrint(message));
    socket.onError(socketErrorHandler);
    socket.on("connect", (_) => debugPrint("Connected"));
    socket.onDisconnect((_) => print('disconnect'));

    debugPrint("Socket initialized with: $socketAddress, Handlers!!!");
  }


  void getLatestFile(){
    socket.emit("getFile");
  }

  void dispose(){
    socket.dispose();
  }


}

SocketClient socketClient = SocketClient();
