import 'package:ecom_flutter/features/authentication/presentation/manager/verify_account_bloc.dart';
import 'package:ecom_flutter/features/authentication/presentation/pages/mobile/verify_email_mobile_view.dart';
import 'package:ecom_flutter/utils/dependency_injection/di_container.dart';
import 'package:ecom_flutter/widgets/responsive.dart';
import 'package:flutter/material.dart';

class VerifyEmailView extends StatefulWidget {
  final String userEmail;

  const VerifyEmailView({
    super.key,
    required this.userEmail,
  });

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  late final VerifyAccountBloc verifyAccountBloc;

  @override
  void initState() {
    super.initState();
    verifyAccountBloc = getItInstance.get<VerifyAccountBloc>();
  }

  @override
  void dispose() {
    verifyAccountBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveView(
      mobile: VerifyEmailMobileView(
        verifyAccountBloc: verifyAccountBloc,
        email: widget.userEmail,
      ),
    );
  }
}
