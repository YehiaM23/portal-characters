import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project1/business_logic/cubit/charachters_cubit.dart';
import 'package:project1/data/models/charachters.dart';
import 'package:project1/data/repositry/charachter_repository.dart';
import 'package:project1/data/web_servers/charachter_web_services.dart';
import 'package:project1/presentation/screens/charachter_screen.dart';

class FakeRepository extends CharactersRepository {
  bool fail = false;
  FakeRepository() : super(charachterWebServices: CharachterWebServices());
  @override
  Future<List<Character>> getAllCharachters({int page = 1}) async {
    if (fail) throw Exception('offline');
    return [
      Character.fromJson({
        'id': 1,
        'name': 'Rick Sanchez',
        'image': '',
        'status': 'Alive',
        'species': 'Human',
        'gender': 'Male',
        'origin': {'name': 'Earth'},
        'location': {'name': 'Citadel'},
      }),
    ];
  }
}

void main() {
  test('Parses API fields and exposes load/error states', () async {
    final repo = FakeRepository();
    final cubit = CharachtersCubit(repo);
    await cubit.getAllCharacters();
    expect((cubit.state as Charachtersloaded).characters.single.charId, 1);
    repo.fail = true;
    await cubit.getAllCharacters();
    expect(cubit.state, isA<CharactersError>());
    await cubit.close();
  });
  testWidgets('Can retry a failed request', (tester) async {
    final repo = FakeRepository()..fail = true;
    final cubit = CharachtersCubit(repo);
    await cubit.getAllCharacters();
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(value: cubit, child: const CharachterScreen()),
      ),
    );
    expect(find.text('Retry'), findsOneWidget);
    repo.fail = false;
    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();
    expect(find.text('Rick Sanchez'), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
    await cubit.close();
  });
}
