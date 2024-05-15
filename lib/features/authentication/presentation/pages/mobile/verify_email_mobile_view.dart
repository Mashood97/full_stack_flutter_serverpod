import 'package:ecom_flutter/utils/app_snackbar.dart';
import 'package:ecom_flutter/utils/constant.dart';
import 'package:ecom_flutter/utils/extensions/context_extensions.dart';
import 'package:ecom_flutter/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

import '../../manager/verify_account_bloc.dart';

class VerifyEmailMobileView extends StatelessWidget {
  final VerifyAccountBloc verifyAccountBloc;
  final String email;

  const VerifyEmailMobileView({
    super.key,
    required this.verifyAccountBloc,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: AppConstants.appPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppConstants.sizedBoxHeight(context, defaultValue: 35),
                Text(
                  "Let's Verify!",
                  textAlign: TextAlign.center,
                  style: context.theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: AppFontWeight().boldFontWeight,
                  ),
                ),
                AppConstants.sizedBoxHeight(context, defaultValue: 75),
                Image.asset(
                  AppImages().verifyAccountImage,
                  fit: BoxFit.contain,
                  height: getResponsiveValue(context, 325),
                  width: context.screenWidth,
                ),
                AppConstants.sizedBoxHeight(context, defaultValue: 30),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: "We have sent a verification email to: ",
                      style: context.theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: AppFontWeight().thinFontWeight,
                        color: Colors.black54,
                      ),
                      children: [
                        TextSpan(
                          text: email,
                          style: context.theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: AppFontWeight().boldFontWeight,
                          ),
                        ),
                      ]),
                ),
                AppConstants.sizedBoxHeight(
                  context,
                  defaultValue: 35,
                ),
                Pinput(
                  onCompleted: (pin) => print(pin),
                  closeKeyboardWhenCompleted: true,
                  controller: verifyAccountBloc.verification,
                  length: 8,
                  defaultPinTheme: PinTheme(
                    height: AppConstants.kAppButtonHeight(context),
                    width: AppConstants.kAppButtonHeight(context),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                ),
                AppConstants.sizedBoxHeight(context, defaultValue: 60),
        
                SizedBox(
                  height: AppConstants.kAppButtonHeight(context),
                  child: BlocConsumer<VerifyAccountBloc, VerifyAccountState>(
                    bloc: verifyAccountBloc,
                    listener: (ctx, state) {
                      if (state is VerifyAccountFailure) {
                        AppSnackBar().showSuccessSnackBar(
                            context: ctx, successMsg: state.error);
                      }
                    },
                    builder: (context, state) {
                      if (state is VerifyAccountLoading) {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      }
                      return FilledButton(
                        onPressed: () {
                          verifyAccountBloc.onVerificationButtonPressed(
                              email: email);
                        },
                        child: Text(
                          "Verify",
                          style: context.theme.textTheme.bodyLarge?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Text(
                //   "",
                //   style: context.theme.textTheme.labelMedium
                //       ?.copyWith(fontWeight: AppFontWeight().thinFontWeight),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
