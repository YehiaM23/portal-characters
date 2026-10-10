import 'package:flutter/material.dart';
import 'app_router.dart';
import 'ui.dart';

void main() => runApp(PortalCharactersApp(appRouter: AppRouter()));

class PortalCharactersApp extends StatelessWidget {
  final AppRouter appRouter;
  const PortalCharactersApp({super.key, required this.appRouter});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Portal Characters',
    debugShowCheckedModeBanner: false,
    theme: appTheme(Colors.teal),
    onGenerateRoute: appRouter.generateRoute,
  );
}
