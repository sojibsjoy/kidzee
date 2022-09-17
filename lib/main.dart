import 'package:dogventurehq/states/bindings/initial.dart';
import 'package:dogventurehq/ui/screens/home/home.dart';
import 'package:dogventurehq/ui/screens/login/login.dart';
import 'package:dogventurehq/ui/screens/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          getPages: [
            GetPage(
              name: SplashScreen.routeName,
              page: () => const SplashScreen(),
            ),
            GetPage(
              name: HomeScreen.routeName,
              page: () => const HomeScreen(),
              binding: InitialBinding(),
            ),
            GetPage(
              name: LoginScreen.routeName,
              page: () => const LoginScreen(),
            ),
          ],
          initialRoute: SplashScreen.routeName,
          initialBinding: InitialBinding(),
        );
      },
    );
  }
}
