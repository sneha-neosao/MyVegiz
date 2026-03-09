part of 'addresses_bloc.dart';

sealed class AddressEvent extends Equatable {
  const AddressEvent();

  @override
  List<Object> get props => [];
}

class FetchAddressesEvent extends AddressEvent {
  final String clientCode;

  const FetchAddressesEvent(this.clientCode);

  @override
  List<Object> get props => [clientCode];
}

class DeleteAddressEvent extends AddressEvent {
  final String id;
  final String clientCode;

  const DeleteAddressEvent({required this.id, required this.clientCode});

  @override
  List<Object> get props => [id, clientCode];
}

class AddAddressEvent extends AddressEvent {
  final String clientCode;
  final String address;
  final String latitude;
  final String longitude;
  final String addressType;
  final String flat;
  final String landMark;
  final String directionToReach;
  final String areaCode;
  final String cityCode;

  const AddAddressEvent({
    required this.clientCode,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.addressType,
    required this.flat,
    required this.landMark,
    required this.directionToReach,
    required this.areaCode,
    required this.cityCode,
  });

  @override
  List<Object> get props => [
    clientCode,
    address,
    latitude,
    longitude,
    addressType,
    flat,
    landMark,
    directionToReach,
    areaCode,
    cityCode,
  ];
}

class UpdateAddressEvent extends AddressEvent {
  final String id;
  final String clientCode;
  final String address;
  final String latitude;
  final String longitude;
  final String addressType;
  final String flat;
  final String landMark;
  final String directionToReach;
  final String areaCode;
  final String cityCode;

  const UpdateAddressEvent({
    required this.id,
    required this.clientCode,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.addressType,
    required this.flat,
    required this.landMark,
    required this.directionToReach,
    required this.areaCode,
    required this.cityCode,
  });

  @override
  List<Object> get props => [
    id,
    clientCode,
    address,
    latitude,
    longitude,
    addressType,
    flat,
    landMark,
    directionToReach,
    areaCode,
    cityCode,
  ];
}
