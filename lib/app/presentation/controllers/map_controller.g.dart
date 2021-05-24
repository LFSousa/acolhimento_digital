// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MapController on _MapControllerBase, Store {
  final _$markersAtom = Atom(name: '_MapControllerBase.markers');

  @override
  Set<Marker> get markers {
    _$markersAtom.reportRead();
    return super.markers;
  }

  @override
  set markers(Set<Marker> value) {
    _$markersAtom.reportWrite(value, super.markers, () {
      super.markers = value;
    });
  }

  final _$_MapControllerBaseActionController =
      ActionController(name: '_MapControllerBase');

  @override
  void setPlaces(List<Place> places) {
    final _$actionInfo = _$_MapControllerBaseActionController.startAction(
        name: '_MapControllerBase.setPlaces');
    try {
      return super.setPlaces(places);
    } finally {
      _$_MapControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
markers: ${markers}
    ''';
  }
}
