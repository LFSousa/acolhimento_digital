import 'package:acolhimento_digital/app/repositories/places/models/place_model.dart';
import 'package:dartz/dartz.dart';

abstract class IPlacesRepository {
  Future<Either<bool, List<Place>>> places();
  Future<bool> addFavorite(String id);
  Future<bool> removeFavorite(String id);
  Future<Either<bool, List<Place>>> favorites();
}
