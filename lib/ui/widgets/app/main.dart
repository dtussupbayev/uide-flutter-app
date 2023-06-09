import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:uide/navigation/main_navigation.dart';
import 'package:uide/provider/connectivity_provider.dart';
import 'package:uide/ui/theme/project_colors.dart';
import 'main_app_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final model = MainAppModel();

  await model.checkAuth();
  final app = RestartWidget(
    child: MainApp(
      model: model,
    ),
  );

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: ProjectColors.kDarkerDarkGreen,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
      statusBarColor: ProjectColors.kTransparent,
    ),
  );

  runApp(app);
}

class MainApp extends StatelessWidget {
  final MainAppModel model;
  static final mainNavigation = MainNavigation();
  const MainApp({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ConnectivityProvider(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Montserrat',
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
        ),
        initialRoute: mainNavigation.initialRoute(model.isAuth),
        routes: mainNavigation.routes,
      ),
    );
  }
}

class MyArguments {
  final int message;

  MyArguments(this.message);
}

class RestartWidget extends StatefulWidget {
  const RestartWidget({super.key,required this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()?.restartApp();
  }

  @override
  State<RestartWidget> createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}
