import 'package:appfit/appfit.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'AppFit Example',
      home: AppFitExample(),
    );
  }
}

class AppFitExample extends StatefulWidget {
  const AppFitExample({super.key});

  @override
  AppFitExampleState createState() => AppFitExampleState();
}

class AppFitExampleState extends State<AppFitExample> {
  final appFit = AppFit(configuration: AppFitConfiguration(apiKey: "API_KEY"));

  @override
  void initState() {
    super.initState();
    appFit.trackEvent('screen_name', properties: {'name': 'AppFit Example'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppFit Example'),
      ),
      body: const Center(
        child: Text("Welcome to the AppFit example app."),
      ),
    );
  }
}
