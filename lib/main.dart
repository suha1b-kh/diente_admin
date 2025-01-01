import 'package:diente_admin/presentation/screens/home.dart';
import 'package:diente_admin/core/theme/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyAjFm02uVvwCUWW2IuM_hp0bZOpW_PeQyk',
        appId: "1:312200157189:web:540df623ffa727dbffe46c",
        messagingSenderId: "312200157189",
        projectId: "diente-e540a",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, widget) {
        ScreenUtil.init(context, designSize: const Size(1920, 1280));
        return const AdminHomeScreen();
      },
      theme: lightMode,
    );
  }
}
