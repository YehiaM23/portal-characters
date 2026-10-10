import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'business_logic/cubit/charachters_cubit.dart';
import 'data/repositry/charachter_repository.dart';
import 'data/web_servers/charachter_web_services.dart';
import 'data/models/charachters.dart';
import 'constants/strings.dart';
import 'presentation/screens/charachter_screen.dart';
import 'presentation/screens/charachters_details.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    if (settings.name == allcharachtersRoute) {
      return MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => CharachtersCubit(
            CharactersRepository(
              charachterWebServices: CharachterWebServices(),
            ),
          )..getAllCharacters(),
          child: const CharachterScreen(),
        ),
      );
    }
    if (settings.name == charachterDetailsScreen &&
        settings.arguments is Character) {
      return MaterialPageRoute(
        builder: (_) =>
            CharachterDetailsScreen(character: settings.arguments as Character),
      );
    }
    return null;
  }
}
