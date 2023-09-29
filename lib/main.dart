import 'package:admin_gardenia/bloc/product_bloc/add_product_bloc.dart';
import 'package:admin_gardenia/firebase_options.dart';
import 'package:admin_gardenia/screens/auth/auth.dart';
import 'package:admin_gardenia/screens/auth/splash_screen.dart';
import 'package:admin_gardenia/screens/home/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AddProductBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SplashScreen();
              }
              if (snapshot.hasData) {
                return HomeScreen();
              }
              return const ScreenLogin();
            }),
        // home: AddProductScreen(),
      ),
    );
  }
}
