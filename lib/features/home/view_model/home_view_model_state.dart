import 'package:equatable/equatable.dart';
import 'package:safqaseller/features/seller/model/models/seller_home_response.dart';

abstract class HomeViewModelState extends Equatable {
  const HomeViewModelState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeViewModelState {}

class HomeLoading extends HomeViewModelState {}

class HomeSuccess extends HomeViewModelState {
  final SellerHomeResponse data;

  const HomeSuccess(this.data);

  @override
  List<Object?> get props => [data];
}

class HomeFailure extends HomeViewModelState {
  final String error;

  const HomeFailure(this.error);

  @override
  List<Object?> get props => [error];
}
