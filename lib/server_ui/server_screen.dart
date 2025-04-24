import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/server/server_bloc.dart';

// Assuming ServerBloc, ServerEvent, ServerState and their variants are already imported

class ServerScreen extends StatefulWidget {
  @override
  State<ServerScreen> createState() => _ServerScreenState();
}

class _ServerScreenState extends State<ServerScreen> {
  final TextEditingController _portController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ServerBloc(),
      //Wrap in PopScope to reset the Server/Client when navigating back
      child: Builder(builder: (context){
        return  PopScope(
          onPopInvokedWithResult: (_, _) {
            context.read<ServerBloc>().add(ServerResetEvent());
          },
          canPop: true,
          child: Scaffold(
            appBar: AppBar(title: const Text("Server Setup")),
            body: BlocBuilder<ServerBloc, ServerState>(
              builder: (context, state) {
                if (state is ServerInitial) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 5.0,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,

                          child: Text(
                            "Note Bene: (Accepted port range: 1024-65535, Recommended value: 3000)",
                            style: TextStyle(
                                fontSize: 10,
                                color: Colors.deepOrange
                            ),

                          ),
                        ) ,
                        TextField(
                          controller: _portController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Enter Port Number',
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            final port = int.tryParse(_portController.text);

                            try {
                              if (port != null && port >= 1024 && port <= 65535) {
                                context.read<ServerBloc>().add(TrySetupServerEvent(port));
                              }else{
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Incorrect port value entered, server reset")),
                                );
                                context.read<ServerBloc>().add(ServerResetEvent());
                              }
                            } on Exception catch (e) {
                              context.read<ServerBloc>().add(ServerExceptionEvent(e));
                            }
                          },
                          child: const Text('Set Up Server'),
                        ),
                      ],
                    ),
                  );
                } else if (state is ServerSetupState) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Port: ${state.portAddress}"),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            //TODO fix this anomaly
                            //context.read<ServerBloc>().add(ServerTestCommunicationEvent("This is a test message"));
                            //context.read<ServerBloc>().add(SetFileToSendEvent(null, state.portAddress));

                            final result = await FilePicker.platform.pickFiles();
                            if (result != null && result.files.isNotEmpty && result.files.single.bytes != null) {
                              //This thingymingy works on Web and doesn't work on Windows native
                              final PlatformFile file = result.files.single;
                              final fileBytes = file.bytes;
                              debugPrint("Bytes before send Event: $fileBytes, size: ${file.size}, ext: ${file.extension}");
                              final fileName = file.name;
                              context.read<ServerBloc>().add(SetFileToSendEvent(fileBytes, state.portAddress, fileName));
                            }else if(result != null && result.files.single.path != null){
                              //This thingimmingy crashes Web but seems to work on Windows native
                              final filePath = result.files.single.path!;
                              final file = File(filePath);
                              final fileBytes = file.readAsBytesSync();
                              debugPrint("Bytes before send Event: $fileBytes, size: ${fileBytes.length}, filename: ${file.path}");
                              final fileName = filePath.substring(filePath.lastIndexOf('/') + 1);
                              context.read<ServerBloc>().add(SetFileToSendEvent(fileBytes, state.portAddress, fileName));
                            }


                          },
                          child: const Text('Choose File to Send'),
                        ),
                      ],
                    ),
                  );
                } else if (state is ServerFileChosenState) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Port: ${state.portAddress}"),
                        Text("File: ${state.chosenFileName}"),
                      ],
                    ),
                  );
                } else if (state is ServerErrorState) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Error: ${state.errorMessage}", style: const TextStyle(color: Colors.red)),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            context.read<ServerBloc>().add(ServerResetEvent());
                          },
                          child: const Text('Restart Setup'),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        );
      })
    );
  }
}
