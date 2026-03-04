part of 'search_product_bloc.dart';

sealed class SearchProductState extends Equatable {
  const SearchProductState();

  @override
  List<Object?> get props => [];
}

class SearchProductInitial extends SearchProductState {}

class SearchProductLoading extends SearchProductState {}

class SearchProductSuccess extends SearchProductState {
  final ProductByCategoryResponse response;

  const SearchProductSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class SearchProductFailure extends SearchProductState {
  final String message;

  const SearchProductFailure(this.message);

  @override
  List<Object?> get props => [message];
}
