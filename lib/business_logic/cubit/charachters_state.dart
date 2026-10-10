part of 'charachters_cubit.dart';

abstract class CharachtersState {}

class CharachtersInitial extends CharachtersState {}

class CharactersLoading extends CharachtersState {}

class Charachtersloaded extends CharachtersState {
  final List<Character> characters;
  Charachtersloaded(this.characters);
}

class CharactersError extends CharachtersState {
  final String message;
  CharactersError(this.message);
}
