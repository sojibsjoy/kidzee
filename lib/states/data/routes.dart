import 'package:dogventurehq/ui/screens/home/home.dart';
import 'package:dogventurehq/ui/screens/login/login.dart';
import 'package:dogventurehq/ui/screens/puzzle/puzzle.dart';
import 'package:dogventurehq/ui/screens/splash/splash.dart';
import 'package:get/route_manager.dart';

class AllRoutes {
  static List<GetPage> allroutes = [
    GetPage(
      name: SplashScreen.routeName,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: HomeScreen.routeName,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: LoginScreen.routeName,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: PuzzleScreen.routeName,
      page: () => const PuzzleScreen(),
    ),
  ];
}
