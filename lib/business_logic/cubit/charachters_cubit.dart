import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/data/models/charachters.dart';
import 'package:project1/data/repositry/charachter_repository.dart';
part 'charachters_state.dart';

class CharachtersCubit extends Cubit<CharachtersState> {
  final CharactersRepository charachtersRepository;
  CharachtersCubit(this.charachtersRepository) : super(CharachtersInitial());
  Future<void> getAllCharacters({int page = 1}) async {
    emit(CharactersLoading());
    try {
      final characters = await charachtersRepository.getAllCharachters(
        page: page,
      );
      if (!isClosed) emit(Charachtersloaded(characters));
    } catch (_) {
      if (!isClosed) {
        emit(
          CharactersError(
            'Could not load this page. Check your connection and try again.',
          ),
        );
      }
    }
  }
}
