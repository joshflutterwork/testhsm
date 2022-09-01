import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  Position? position;
  LocationBloc() : super(LocationInitial()) {
    on<GetAbsenLocation>(_getAbsen);
  }

  _getAbsen(GetAbsenLocation getAbsenLocation, Emitter emit) async {
    emit(LocationInitial());
    position = await _determinePosition();

    double distanceInMeters = Geolocator.distanceBetween(
      -6.1762882,
      106.8171201,
      position!.latitude,
      position!.longitude,
    );

    double distance = distanceInMeters * 0.001;

    if (distance <= 5) {
      emit(AbsenSuccess(success: "Absen berhasil!"));
    } else {
      emit(
          AbsenError(error: "Lokasi terlalu jauh! Harap absen di kantor dong"));
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}
