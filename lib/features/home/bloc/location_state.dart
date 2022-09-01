part of 'location_bloc.dart';

@immutable
abstract class LocationState {}

class LocationInitial extends LocationState {}

class AbsenSuccess extends LocationState {
  String? success;

  AbsenSuccess({this.success});
}

class AbsenError extends LocationState {
  String? error;

  AbsenError({this.error});
}
