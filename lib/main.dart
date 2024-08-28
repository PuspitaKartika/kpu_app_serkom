import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kpu_app_serkom/bloc/get_user/get_user_cubit.dart';
import 'package:kpu_app_serkom/firebase_options.dart';
import 'package:kpu_app_serkom/theme.dart';
import 'package:kpu_app_serkom/view/home_screen.dart';

import 'bloc/add_user/add_user_cubit.dart';

Future main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
     
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the sroot of your application.
  @override
  Widget build(BuildContext context) {
    return 
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GetUserCubit()),
        BlocProvider(create: (_) => AddUserCubit()),
      ],
     child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
        
          colorScheme: ColorScheme.fromSeed(seedColor: cDarkGreen),
          useMaterial3: true,
        ),
        home: const HomeScreen()
     ),
    );
  }
}
