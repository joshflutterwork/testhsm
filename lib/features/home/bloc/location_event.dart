part of 'location_bloc.dart';

@immutable
abstract class LocationEvent {}

class GetAbsenLocation extends LocationEvent {
  GetAbsenLocation();
}
