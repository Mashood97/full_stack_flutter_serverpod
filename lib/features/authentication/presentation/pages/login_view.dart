import 'package:ecom_flutter/features/authentication/presentation/manager/login_bloc.dart';
import 'package:ecom_flutter/utils/dependency_injection/di_container.dart';
import 'package:ecom_flutter/widgets/responsive.dart';
import 'package:flutter/material.dart';

import 'mobile/login_mobile_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final LoginBloc loginBloc;

  @override
  void initState() {
    super.initState();
    loginBloc = getItInstance.get();
  }

  @override
  void dispose() {
    loginBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveView(
      mobile: LoginMobileView(
        loginBloc: loginBloc,
      ),
    );
  }
}
