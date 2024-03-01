import 'package:equatable/equatable.dart';

abstract class SplashState extends Equatable {
  const SplashState([List props = const []]) : super();

  @override
  List<Object> get props => [];
}

class SplashInitial extends SplashState {
  const SplashInitial();

  @override
  String toString() => 'SplashInitial';
}

class SplashLogoChanged extends SplashState {
  const SplashLogoChanged();
  @override
  String toString() => 'SplashLogoChanged';
}
