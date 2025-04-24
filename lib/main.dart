import 'package:flutter/material.dart';
import 'package:flutter_file_share/server_ui/server_screen.dart';
import 'HackerTheme.dart';
import 'client_ui/client_screen.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Example',
      home: HomeScreen(),
      theme: getHackerTheme(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  void showInformationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Information"),
        content: Text(
            "To use this application please read and follow these instructions carefully.\n"
            "You will need to set up a server and a client that communicate on the same port.\n"
            "Step 1: On the device you want to share a file from, press 'Server' and enter a number\n"
            "Step 2: On the device you want to receive a file on, press 'Client' and enter THE SAME number as before\n"
            "Step 3: On the 'Server' press the File selection button\n"
            "Step 4: On the 'Client' press the File request button\n"
            "Step 5: Wait for the indicator\n"
            "You should see the downloaded file"
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Main Menu')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 10.0,
          children: [
            ElevatedButton(
              onPressed: () => showInformationDialog(context),
              child: Text('Information'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ServerScreen()),
                );
              },
              child: Text('Server'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ClientScreen()),
                );
              },
              child: Text('Client'),
            ),

          ],
        ),
      ),
    );
  }
}


