part of 'app_view_model.dart';

@immutable
sealed class AppState {}

final class AppInitialState extends AppState {}

final class LanguageSelectedState extends AppState {}
