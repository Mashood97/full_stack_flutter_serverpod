import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'language_cubit/language_cubit.dart';

AppLocalizations? translate(BuildContext context) {
  return AppLocalizations.of(context);
}

Locale getLocale(String lanCode) {
  switch (lanCode) {
    case SupportedLanguageLocales.inuktitutLocale:
      return const Locale(SupportedLanguageLocales.inuktitutLocale);
    default:
      return const Locale(SupportedLanguageLocales.engLangCode);
  }
}

Future<void> changeLanguage(String languageCode) async {
  AppLocalizations.delegate.load(getLocale(languageCode)).then((value) {
    SupportedLanguageLocales.currentLocale = languageCode;
  });
}
