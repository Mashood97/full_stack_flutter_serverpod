import 'package:ecom_client/ecom_client.dart';
import 'package:ecom_flutter/utils/bloc_observer.dart';
import 'package:ecom_flutter/utils/dependency_injection/di_container.dart';
import 'package:ecom_flutter/utils/internet_checker/network_bloc.dart';
import 'package:ecom_flutter/utils/local_storage/local_storage.dart';
import 'package:ecom_flutter/utils/localizations/app_localizations.dart';
import 'package:ecom_flutter/utils/localizations/language_cubit/language_cubit.dart';
import 'package:ecom_flutter/utils/navigation/go_router_navigation_delegate.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:serverpod_auth_email_flutter/serverpod_auth_email_flutter.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'features/authentication/presentation/manager/authentication_bloc.dart';

late SessionManager sessionManager;
late Client client;

void main() async {
  // Need to call this as we are using Flutter bindings before runApp is called.
  WidgetsFlutterBinding.ensureInitialized();

  // The android emulator does not have access to the localhost of the machine.
  // const ipAddress = '10.0.2.2'; // Android emulator ip for the host

  // On a real device replace the ipAddress with the IP address of your computer.
  const ipAddress = 'localhost';

  // Sets up a singleton client object that can be used to talk to the server from
  // anywhere in our app. The client is generated from your server code.
  // The client is set up to connect to a Serverpod running on a local server on
  // the default port. You will need to modify this to connect to staging or
  // production servers.
  client = Client(
    'http://$ipAddress:8080/',
    authenticationKeyManager: FlutterAuthenticationKeyManager(),
  )..connectivityMonitor = FlutterConnectivityMonitor();

  // The session manager keeps track of the signed-in state of the user. You
  // can query it to see if the user is currently signed in and get information
  // about the user.
  sessionManager = SessionManager(
    caller: client.modules.auth,
  );
  await sessionManager.initialize();

  Bloc.observer = CustomBlocObserver();

  initializeDependencies();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );

  runApp(const MyApp());
}

final _router = GoRouterNavigationDelegate();

final localStorageInstance = getItInstance.get<LocalStorage>();
final internetConnection = getItInstance.get<NetworkBloc>();
final appLanguageCubit = getItInstance.get<LanguageCubit>();

final AuthenticationBloc authenticationBloc =
    getItInstance.get<AuthenticationBloc>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    appLanguageCubit.loadAppLanguageFromLocalStorage();
    if (sessionManager.isSignedIn) {
      sessionManager.refreshSession();
    }

    authenticationBloc.add(AppStarted());
  }

  @override
  void dispose() {
    appLanguageCubit.close();
    internetConnection.close();
    authenticationBloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: appLanguageCubit,
        ),
        BlocProvider.value(
          value: internetConnection,
        ),
      ],
      child: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (ctx, state) {
          if (state is LanguageLoaded) {
            return MaterialApp.router(
              title: translate(ctx)?.app_name ?? "AmpTime",
              themeMode: ThemeMode.light,
              locale: Locale(state.languageCode),
              builder: (context, child) => ResponsiveBreakpoints.builder(
                child: child!,
                breakpoints: [
                  const Breakpoint(
                    start: 0,
                    end: 650,
                    name: MOBILE,
                  ),
                  const Breakpoint(
                    start: 651,
                    end: 1000,
                    name: TABLET,
                  ),
                  const Breakpoint(
                    start: 1001,
                    end: double.infinity,
                    name: DESKTOP,
                  ),
                ],
              ),
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                scaffoldBackgroundColor: Colors.white,
                inputDecorationTheme: InputDecorationTheme(
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  disabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
                // colorScheme: ColorScheme.fromSeed(
                //   seedColor: Colors.deepPurple,
                // ),
                textTheme: GoogleFonts.latoTextTheme(),
              ),
              // darkTheme: AppDarkTheme.theme,
              themeAnimationCurve: Curves.fastEaseInToSlowEaseOut,
              routerConfig: _router.router,
            );
          }
          return MaterialApp.router(
            title: translate(ctx)?.app_name ?? "AmpTime",
            themeMode: ThemeMode.light,
            locale: const Locale(
              SupportedLanguageLocales.engLangCode,
            ),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            builder: (context, child) => ResponsiveBreakpoints.builder(
              child: child!,
              breakpoints: [
                const Breakpoint(
                  start: 0,
                  end: 700,
                  name: MOBILE,
                ),
                const Breakpoint(
                  start: 701,
                  end: 1000,
                  name: TABLET,
                ),
                const Breakpoint(
                  start: 1001,
                  end: double.infinity,
                  name: DESKTOP,
                ),
              ],
            ),
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              inputDecorationTheme: InputDecorationTheme(
                filled: true,
                fillColor: Colors.grey.shade100,
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                disabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
              // colorScheme: ColorScheme.fromSeed(
              //   seedColor: Colors.deepPurple,
              // ),
              textTheme: GoogleFonts.latoTextTheme(),
            ),
            // darkTheme: AppDarkTheme.theme,
            themeAnimationCurve: Curves.fastEaseInToSlowEaseOut,
            routerConfig: _router.router,
          );
        },
      ),
    );
  }
}
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   MyHomePageState createState() => MyHomePageState();
// }
//
// class MyHomePageState extends State<MyHomePage> {
//   // These fields hold the last result or error message that we've received from
//   // the server or null if no result exists yet.
//   String? _resultMessage;
//   String? _errorMessage;
//
//   final _textEditingController = TextEditingController();
//
//   // Calls the `hello` method of the `example` endpoint. Will set either the
//   // `_resultMessage` or `_errorMessage` field, depending on if the call
//   // is successful.
//   void _callHello() async {
//     try {
//       final result = await client.example.hello(_textEditingController.text);
//       setState(() {
//         _errorMessage = null;
//         _resultMessage = result;
//       });
//     } catch (e) {
//       setState(() {
//         _errorMessage = '$e';
//       });
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     sessionManager.addListener(() {
//       setState(() {});
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(bottom: 16.0),
//               child: TextField(
//                 controller: _textEditingController,
//                 decoration: const InputDecoration(
//                   hintText: 'Enter your name',
//                 ),
//               ),
//             ),
//             Padding(
//                 padding: const EdgeInsets.only(bottom: 16.0),
//                 child: SignInWithEmailButton(
//                   caller: client.modules.auth,
//                   onSignedIn: () {
//                     print("User Signed In Successfully");
//                   },
//                 )
//
//                 // ElevatedButton(
//                 //   onPressed: _callHello,
//                 //   child: const Text('Send to Server'),
//                 // ),
//                 ),
//             _ResultDisplay(
//               resultMessage: _resultMessage,
//               errorMessage: _errorMessage,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // _ResultDisplays shows the result of the call. Either the returned result from
// // the `example.hello` endpoint method or an error message.
// class _ResultDisplay extends StatelessWidget {
//   final String? resultMessage;
//   final String? errorMessage;
//
//   const _ResultDisplay({
//     this.resultMessage,
//     this.errorMessage,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     String text;
//     Color backgroundColor;
//     if (errorMessage != null) {
//       backgroundColor = Colors.red[300]!;
//       text = errorMessage!;
//     } else if (resultMessage != null) {
//       backgroundColor = Colors.green[300]!;
//       text = resultMessage!;
//     } else {
//       backgroundColor = Colors.grey[300]!;
//       text = 'No server response yet.';
//     }
//
//     return Container(
//       height: 50,
//       color: backgroundColor,
//       child: Center(
//         child: Text(text),
//       ),
//     );
//   }
// }
