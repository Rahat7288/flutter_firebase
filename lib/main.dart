import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase/bloc/auth/auth_bloc.dart';
import 'package:flutter_firebase/bloc/signin/signin_cubit.dart';
import 'package:flutter_firebase/pages/home_page.dart';
import 'package:flutter_firebase/pages/sign_page.dart';
import 'package:flutter_firebase/pages/signup_page.dart';
import 'package:flutter_firebase/pages/splash_page.dart';
import 'package:flutter_firebase/repositories/auth_repository.dart';
import 'firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // multi repository provider help us to use multiple repositories
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(
              firebaseFirestore: FirebaseFirestore.instance,
              firebaseAuth: FirebaseAuth.instance),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<SigninCubit>(
            create: (context) => SigninCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: SplashPage(),
          routes: {
            SignPage.routeName: (context) => SignPage(),
            SignUpPage.routeName: (context) => SignUpPage(),
            HomePage.routeName: (context) => HomePage(),
          },
        ),
      ),
    );
  }
}
