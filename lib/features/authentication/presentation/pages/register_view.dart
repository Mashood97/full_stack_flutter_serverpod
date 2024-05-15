import 'package:ecom_flutter/features/authentication/presentation/manager/register_bloc.dart';
import 'package:ecom_flutter/features/authentication/presentation/pages/mobile/register_mobile_view.dart';
import 'package:ecom_flutter/utils/dependency_injection/di_container.dart';
import 'package:ecom_flutter/widgets/responsive.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final RegisterBloc registerBloc;

  @override
  void initState() {
    super.initState();
    registerBloc = getItInstance.get<RegisterBloc>();
  }

  @override
  void dispose() {
    registerBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveView(
      mobile: RegisterMobileView(
        registerBloc: registerBloc,
      ),
    );
  }
}
