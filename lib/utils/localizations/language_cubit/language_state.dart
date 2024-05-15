part of 'language_cubit.dart';

abstract class LanguageState extends Equatable {
  const LanguageState();
}

class LanguageLoaded extends LanguageState {
  final String languageCode;

  const LanguageLoaded({
    required this.languageCode,
  });

  @override
  List<Object> get props => [
        languageCode,
      ];
}
