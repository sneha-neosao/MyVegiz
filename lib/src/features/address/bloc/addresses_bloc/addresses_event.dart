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
