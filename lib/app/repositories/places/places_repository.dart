import 'package:acolhimento_digital/app/repositories/places/models/place_model.dart';
import 'package:acolhimento_digital/app/repositories/places/places_repository_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:platform_device_id/platform_device_id.dart';

@Injectable(as: IPlacesRepository)
class PlacesRepository implements IPlacesRepository {
  PlacesRepository() {
    placesRef = FirebaseFirestore.instance.collection('places');
    usersRef = FirebaseFirestore.instance.collection('users');
  }

  late CollectionReference placesRef;
  late CollectionReference usersRef;
  late String userId;

  @override
  Future<Either<bool, List<Place>>> places() async {
    userId = (await PlatformDeviceId.getDeviceId)!;
    try {
      var placesSnapshot = await placesRef.get();
      var favoriteList = await favorites();
      return favoriteList.fold((l) => const Left(false), (favs) {
        var places = placesSnapshot.docs
            .map<Place>(
              (value) => Place.fromJson(value.data() as dynamic)
                ..id = value.id
                ..ref = FirebaseFirestore.instance.collection('places').doc(value.id)
                ..favorite = favs.any((f) => f.id == value.id),
            )
            .toList();
        return Right(places);
      });
    } catch (e) {
      return const Left(false);
    }
  }

  @override
  Future<bool> addFavorite(String id) async {
    var favoriteList = await favorites();
    return favoriteList.fold(
      (l) => false,
      (favs) async {
        if (favs.where((fav) => fav.id == id).isNotEmpty) return true;
        try {
          await usersRef.doc(userId).set(
            {
              'favorites': [
                ...favs.map((r) => r.ref).toList(),
                FirebaseFirestore.instance.collection('places').doc(id),
              ]
            },
            SetOptions(merge: true),
          );
          return true;
        } catch (e) {
          return false;
        }
      },
    );
  }

  @override
  Future<bool> removeFavorite(String id) async {
    var favoriteList = await favorites();
    return favoriteList.fold(
      (l) => false,
      (favs) async {
        var favorites = favs.where((fav) => fav.id != id);
        try {
          await usersRef.doc(userId).set(
            {
              'favorites': favorites.map((fav) => fav.ref).toList(),
            },
            SetOptions(merge: true),
          );
          return true;
        } catch (e) {
          return false;
        }
      },
    );
  }

  @override
  Future<Either<bool, List<Place>>> favorites() async {
    try {
      var user = await usersRef.doc(userId).get();
      if (!user.exists) return const Right([]);
      List<dynamic> favoriteReferences = user.get('favorites');
      var favs = [];
      for (var favRef in favoriteReferences) {
        favs.add(await favRef.get());
      }
      var places = favs
          .map<Place>((value) => Place.fromJson(value.data() as dynamic)
            ..id = value.id
            ..ref = FirebaseFirestore.instance.collection('places').doc(value.id))
          .toList();
      return Right(places);
    } catch (e) {
      return const Left(false);
    }
  }
}
