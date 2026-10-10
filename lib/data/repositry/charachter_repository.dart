import 'package:project1/data/models/charachters.dart';
import 'package:project1/data/web_servers/charachter_web_services.dart';

class CharactersRepository {
  final CharachterWebServices charachterWebServices;
  CharactersRepository({required this.charachterWebServices});
  Future<List<Character>> getAllCharachters({int page = 1}) async {
    final data = await charachterWebServices.getAllCharachters(page: page);
    return data
        .map((item) => Character.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
