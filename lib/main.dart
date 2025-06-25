import 'package:feed/config/app_config.dart';
import 'package:feed/config/dependency_injection.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencyInjection.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Airline Review',
      theme: AppConfig.theme,
      routerConfig: AppConfig.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
