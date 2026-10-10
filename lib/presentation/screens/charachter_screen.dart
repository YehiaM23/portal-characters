import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/business_logic/cubit/charachters_cubit.dart';
import 'package:project1/constants/strings.dart';
import 'package:project1/ui.dart';

class CharachterScreen extends StatefulWidget {
  const CharachterScreen({super.key});
  @override
  State<CharachterScreen> createState() => _CharachterScreenState();
}

class _CharachterScreenState extends State<CharachterScreen> {
  String search = '';
  int page = 1;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Portal Characters')),
    body: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 900),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const IntroCard(
              title: 'Meet the multiverse.',
              subtitle: 'Characters, worlds and a little curiosity.',
              icon: Icons.travel_explore,
            ),
            TextField(
              onChanged: (v) => setState(() => search = v),
              decoration: const InputDecoration(
                hintText: 'Search this page',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 20),
            BlocBuilder<CharachtersCubit, CharachtersState>(
              builder: (context, state) {
                if (state is CharactersError) {
                  return Column(
                    children: [
                      Text(state.message),
                      TextButton(
                        onPressed: () => context
                            .read<CharachtersCubit>()
                            .getAllCharacters(page: page),
                        child: const Text('Retry'),
                      ),
                    ],
                  );
                }
                if (state is! Charachtersloaded) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(40),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                final characters = state.characters
                    .where(
                      (c) =>
                          c.name.toLowerCase().contains(search.toLowerCase()),
                    )
                    .toList();
                return Column(
                  children: [
                    if (characters.isEmpty)
                      const Padding(
                        padding: EdgeInsets.all(24),
                        child: Text(
                          'No characters match your search on this page.',
                        ),
                      ),
                    for (final c in characters)
                      Card(
                        clipBehavior: Clip.antiAlias,
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(12),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              c.img,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              errorBuilder: (_, error, stack) =>
                                  const Icon(Icons.person),
                            ),
                          ),
                          title: Text(
                            c.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('${c.species} • ${c.status}'),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => Navigator.pushNamed(
                            context,
                            charachterDetailsScreen,
                            arguments: c,
                          ),
                        ),
                      ),
                    Wrap(
                      spacing: 16,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        TextButton(
                          onPressed: page == 1
                              ? null
                              : () {
                                  setState(() => page--);
                                  context
                                      .read<CharachtersCubit>()
                                      .getAllCharacters(page: page);
                                },
                          child: const Text('Previous'),
                        ),
                        Text('Page $page'),
                        FilledButton(
                          onPressed: state.characters.length < 20
                              ? null
                              : () {
                                  setState(() => page++);
                                  context
                                      .read<CharachtersCubit>()
                                      .getAllCharacters(page: page);
                                },
                          child: const Text('Next'),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    ),
  );
}
