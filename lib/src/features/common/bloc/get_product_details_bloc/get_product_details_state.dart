part of 'get_product_details_bloc.dart';

sealed class GetProductDetailsState extends Equatable {
  const GetProductDetailsState();

  @override
  List<Object> get props => [];
}

final class GetProductDetailsInitial extends GetProductDetailsState {}

final class GetProductDetailsLoading extends GetProductDetailsState {}

final class GetProductDetailsLoaded extends GetProductDetailsState {
  final ProductDetailsResponse response;

  const GetProductDetailsLoaded(this.response);

  @override
  List<Object> get props => [response];
}

final class GetProductDetailsError extends GetProductDetailsState {
  final String message;

  const GetProductDetailsError(this.message);

  @override
  List<Object> get props => [message];
}
