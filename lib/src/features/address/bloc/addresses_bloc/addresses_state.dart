part of 'addresses_bloc.dart';

sealed class AddressState extends Equatable {
  const AddressState();

  @override
  List<Object> get props => [];
}

final class AddressInitial extends AddressState {}

final class AddressLoading extends AddressState {}

final class AddressLoaded extends AddressState {
  final AddressResponse response;

  const AddressLoaded(this.response);

  @override
  List<Object> get props => [response];
}

final class AddressError extends AddressState {
  final String message;

  const AddressError(this.message);

  @override
  List<Object> get props => [message];
}

final class DeleteAddressLoading extends AddressState {}

final class DeleteAddressSuccess extends AddressState {
  final String message;

  const DeleteAddressSuccess(this.message);

  @override
  List<Object> get props => [message];
}

final class DeleteAddressError extends AddressState {
  final String message;

  const DeleteAddressError(this.message);

  @override
  List<Object> get props => [message];
}

final class AddAddressLoading extends AddressState {}

final class AddAddressSuccess extends AddressState {
  final String message;

  const AddAddressSuccess(this.message);

  @override
  List<Object> get props => [message];
}

final class AddAddressError extends AddressState {
  final String message;

  const AddAddressError(this.message);

  @override
  List<Object> get props => [message];
}

final class UpdateAddressLoading extends AddressState {}

final class UpdateAddressSuccess extends AddressState {
  final String message;

  const UpdateAddressSuccess(this.message);

  @override
  List<Object> get props => [message];
}

final class UpdateAddressError extends AddressState {
  final String message;

  const UpdateAddressError(this.message);

  @override
  List<Object> get props => [message];
}
