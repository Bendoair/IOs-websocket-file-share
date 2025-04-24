
import "dart:io";
import "dart:typed_data";

import "package:flutter/cupertino.dart";
import "package:socket_io/socket_io.dart";


class SocketServer{
  Server io = Server();
  Uint8List? fileToSend = null;
  String? fileName = null;
  bool listening = false;

  SocketServer(){
    io.on("connection", (client) => {
      client.on("getFile", (_) {
        if(fileToSend != null){

          io.emit("fileSend", [fileName,fileToSend]);
          try{
            //debugPrint("File sent from server: ${fileToSend?.path}");
          }catch(e){
            //debugPrint(e.toString());
          }
        }
      }),
    });
  }

  void testCommunication(String message){
    io.emit("testEvent", message);
  }
  
  void initialize(int socketNumber){

    if(!listening){
      io.listen(socketNumber);
      listening = true;
    }else{
      debugPrint("Trying to reestablish connection again with socket number: $socketNumber.");
    }
  }

  void setFileToSend(Uint8List fileBytes, String fileNameSent){
    fileToSend = fileBytes;
    fileName = fileNameSent;
  }

  Future<void> dispose() async {
    await io.close();
  }

}

SocketServer socketServer = SocketServer();

