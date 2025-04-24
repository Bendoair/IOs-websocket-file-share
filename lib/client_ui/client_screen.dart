


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_file_share/bloc/client/client_bloc.dart';

class ClientScreen extends StatefulWidget {
  @override
  State<ClientScreen> createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  final TextEditingController _portController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => ClientBloc(),
        child: Builder(builder: (context){
          return PopScope(
              onPopInvokedWithResult: (_, _) {
                context.read<ClientBloc>().add(ClientResetEvent());
              },
              canPop: true,
              child: Scaffold(
                appBar: AppBar(title: const Text("Client Setup")),
                body:
                BlocBuilder<ClientBloc, ClientState>(
                  builder: (context, state) {
                    if (state is ClientInitialState) {
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
                                    color: Colors.deepOrange.withAlpha(180)
                                ),

                              ),
                            ),
                            TextField(
                              controller: _portController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  labelText: 'Enter Port Number'
                              ),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                final port = int.tryParse(_portController.text);

                                try {
                                  if (port != null && port >= 1024 &&
                                      port <= 65535) {
                                    debugPrint("http://localhost:$port");
                                    context.read<ClientBloc>().add(
                                        TryConnectClientEvent(
                                            "http://localhost:$port"));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(
                                          "Incorrect port value entered, server reset")),
                                    );
                                    context.read<ClientBloc>().add(
                                        ClientResetEvent());
                                  }
                                } on Exception catch (e) {
                                  context.read<ClientBloc>().add(
                                      ClientExceptionEvent(e));
                                }
                              },
                              child: const Text('Set Up Client'),
                            ),
                          ],
                        ),
                      );
                    } else if (state is ClientConnectedState) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if(state.sharedFileBytes == null)
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                spacing: 5,
                                children: [
                                  const Text("No file shared yet"),
                                  ElevatedButton(
                                    onPressed: () =>
                                        context.read<ClientBloc>().add(
                                            ClientRequestFileEvent()),
                                    child: const Text(
                                        "Request loaded File from Server"),
                                  )
                                ],
                              )
                            else
                              Text("File shared with name: ${state
                                  .sharedFileName}")
                          ],
                        ),
                      );
                    } else if (state is ClientErrorState) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Error: ${state.errorMessage}",
                                style: const TextStyle(color: Colors.red)),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                context.read<ClientBloc>().add(
                                    ClientResetEvent());
                              },
                              child: const Text('Restart Setup'),
                            ),
                          ],
                        ),
                      );
                    } else if (state is ClientLoadingState) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              )
          );
        }),

    );
  }
}