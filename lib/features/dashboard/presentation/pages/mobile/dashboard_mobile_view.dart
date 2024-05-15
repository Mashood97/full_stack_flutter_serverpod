import 'package:ecom_flutter/features/authentication/presentation/manager/authentication_bloc.dart';
import 'package:ecom_flutter/main.dart';
import 'package:flutter/material.dart';

class DashboardMobileView extends StatelessWidget {
  const DashboardMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "MyApp",
        ),
        actions: [
          IconButton(
            onPressed: () async{
              authenticationBloc.add(LoggedOut());
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
