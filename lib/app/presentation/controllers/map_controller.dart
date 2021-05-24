import 'package:acolhimento_digital/app/repositories/places/models/place_model.dart';
import 'package:acolhimento_digital/app/repositories/places/places_repository_interface.dart';
import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';

part 'map_controller.g.dart';

class MapController = _MapControllerBase with _$MapController;

abstract class _MapControllerBase with Store {
  _MapControllerBase(this._placesRepository);
  final IPlacesRepository _placesRepository;

  @observable
  Set<Marker> markers = {};

  List<Place> _places = [];

  List<Place> get favorites => _places.where((p) => p.favorite).toList();

  Future<Either<bool, List<Place>>> loadPlaces() {
    return _placesRepository.places();
  }

  @action
  void setPlaces(List<Place> places) {
    _places = places;
    var _newMarkers = <Marker>{};
    for (var place in places) {
      _newMarkers.add(Marker(markerId: MarkerId(place.id.toString()), position: place.latLng, onTap: () => onMarkerPressed(place)));
    }
    markers = _newMarkers;
  }

  void addFavorite(String id) {
    _placesRepository.addFavorite(id);
  }

  void removeFavorite(String id) {
    _placesRepository.removeFavorite(id);
  }

  void Function(Place) onMarkerPressed = (_) {};
}
