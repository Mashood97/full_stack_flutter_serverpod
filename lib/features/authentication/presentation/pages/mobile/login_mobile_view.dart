import 'package:ecom_flutter/utils/app_snackbar.dart';
import 'package:ecom_flutter/utils/constant.dart';
import 'package:ecom_flutter/utils/extensions/context_extensions.dart';
import 'package:ecom_flutter/utils/extensions/string_extensions.dart';
import 'package:ecom_flutter/utils/navigation/app_navigations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../manager/login_bloc.dart';

class LoginMobileView extends StatelessWidget {
  final LoginBloc loginBloc;

  const LoginMobileView({
    super.key,
    required this.loginBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: AppConstants.appPadding,
            child: Form(
              key: loginBloc.loginFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppConstants.sizedBoxHeight(context, defaultValue: 30),
                  Text(
                    "Welcome Back!",
                    textAlign: TextAlign.center,
                    style: context.theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: AppFontWeight().boldFontWeight,
                    ),
                  ),
                  AppConstants.sizedBoxHeight(context, defaultValue: 75),
                  TextFormField(
                    controller: loginBloc.email,
                    validator: (val) => val?.isTextNullAndEmpty == true
                        ? "Please enter your email address"
                        : null,
                    decoration: (const InputDecoration())
                        .applyDefaults(context.theme.inputDecorationTheme)
                        .copyWith(
                          prefixIcon: const Icon(
                            Icons.email,
                            color: Colors.grey,
                          ),
                          hintText: "Email address",
                          hintStyle: context.theme.textTheme.titleSmall?.copyWith(
                            fontWeight: AppFontWeight().lightFontWeight,
                            color: Colors.grey,
                          ),
                        ),
                  ),
                  AppConstants.sizedBoxHeight(context, defaultValue: 25),
                  TextFormField(
                    controller: loginBloc.password,
                    obscureText: true,
                    validator: (val) => val?.isTextNullAndEmpty == true
                        ? "Please enter your password"
                        : null,
                    decoration: (const InputDecoration())
                        .applyDefaults(context.theme.inputDecorationTheme)
                        .copyWith(
                          prefixIcon: const Icon(
                            Icons.password,
                            color: Colors.grey,
                          ),
                          hintText: "Password",
                          hintStyle: context.theme.textTheme.titleSmall?.copyWith(
                            fontWeight: AppFontWeight().lightFontWeight,
                            color: Colors.grey,
                          ),
                        ),
                  ),
                  AppConstants.sizedBoxHeight(context, defaultValue: 35),
                  SizedBox(
                    height: AppConstants.kAppButtonHeight(context),
                    child: BlocConsumer<LoginBloc, LoginState>(
                      bloc: loginBloc,
                      listener: (ctx, state) {
                        if (state is LoginFailure) {
                          AppSnackBar().showErrorSnackBar(
                              context: ctx, error: state.error);
                        }
                      },
                      builder: (context, state) {
                        if (state is LoginLoading) {
                          return const Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        }
                        return FilledButton(
                          onPressed: () {
                            if(loginBloc.loginFormKey.currentState?.validate() == true)
                              {
                                loginBloc.loginButtonCalled();
                              }

                          },
                          child: Text(
                            "Login",
                            style: context.theme.textTheme.bodyLarge?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  AppConstants.sizedBoxHeight(context, defaultValue: 45),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(
                        child: Divider(
                            // color: Colors.black54,
                            ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Or",
                        style: context.theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.black45,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Expanded(
                        child: Divider(
                            // color: Colors.black54,
                            ),
                      ),
                    ],
                  ),
                  AppConstants.sizedBoxHeight(context, defaultValue: 35),
                  SizedBox(
                    height: AppConstants.kAppButtonHeight(context),
                    child: ElevatedButton(
                      onPressed: () {
                        AppNavigations()
                            .navigateFromLoginToRegisterScreen(context: context);
                      },
                      child: Text(
                        "Create Account",
                        style: context.theme.textTheme.bodyLarge,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: AppConstants.appPadding,
          child: Text(
            "By continuing, you acknowledge that you have read, and understood, and agree to our Privacy Policy.",
            style: context.theme.textTheme.labelMedium
                ?.copyWith(fontWeight: AppFontWeight().thinFontWeight),
          ),
        ),
      ),
    );
  }
}
