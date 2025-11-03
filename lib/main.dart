import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'bloc/image_generation_bloc.dart';
import 'screens/prompt_screen.dart';
import 'screens/result_screen.dart';
import 'services/mock_api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final GoRouter _router;
  late final ImageGenerationBloc _imageGenerationBloc;

  @override
  void initState() {
    super.initState();
    _imageGenerationBloc = ImageGenerationBloc(MockApiService());
    
    // init routes
    _router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const PromptScreen(),
        ),
        GoRoute(
          path: '/result',
          builder: (context, state) => const ResultScreen(),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _imageGenerationBloc.close();
    _router.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _imageGenerationBloc,
      child: MaterialApp.router(
        title: 'AI Image Generator',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF6C5CE7),
            brightness: Brightness.light,
          ),
          scaffoldBackgroundColor: const Color(0xFFF8F9FA),
          fontFamily: 'SF Pro Display',
        ),
        routerConfig: _router,
      ),
    );
  }
}
