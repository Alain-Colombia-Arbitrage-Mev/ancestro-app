import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: AncestroApp()));
}

class AncestroApp extends StatelessWidget {
  const AncestroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ancestro',
      theme: ThemeData.dark(),
      home: const Scaffold(
        body: Center(child: Text('Ancestro')),
      ),
    );
  }
}
