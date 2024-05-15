import 'package:ecom_flutter/utils/app_snackbar.dart';
import 'package:ecom_flutter/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../utils/constant.dart';
import '../../../../../utils/navigation/app_navigations.dart';
import '../../manager/register_bloc.dart';

class RegisterMobileView extends StatelessWidget {
  final RegisterBloc registerBloc;

  const RegisterMobileView({
    super.key,
    required this.registerBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: AppConstants.appPadding,
          child: Form(
            key: registerBloc.registerFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppConstants.sizedBoxHeight(context, defaultValue: 30),
                Text(
                  "Let's Register!",
                  textAlign: TextAlign.center,
                  style: context.theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: AppFontWeight().boldFontWeight,
                  ),
                ),
                AppConstants.sizedBoxHeight(context, defaultValue: 75),
                TextFormField(
                  controller: registerBloc.email,
                  validator: (val) => val?.isEmpty == true
                      ? "Please enter email address"
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
                  controller: registerBloc.userName,
                  validator: (val) => val?.isEmpty == true
                      ? "Please enter your full name"
                      : null,
                  decoration: (const InputDecoration())
                      .applyDefaults(context.theme.inputDecorationTheme)
                      .copyWith(
                        prefixIcon: const Icon(
                          Icons.text_fields,
                          color: Colors.grey,
                        ),
                        hintText: "Full Name",
                        hintStyle: context.theme.textTheme.titleSmall?.copyWith(
                          fontWeight: AppFontWeight().lightFontWeight,
                          color: Colors.grey,
                        ),
                      ),
                ),
                AppConstants.sizedBoxHeight(context, defaultValue: 25),
                TextFormField(
                  controller: registerBloc.password,
                  validator: (val) =>
                      val?.isEmpty == true ? "Please enter password" : null,
                  obscureText: true,
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
                AppConstants.sizedBoxHeight(context, defaultValue: 25),
                TextFormField(
                  controller: registerBloc.confirmPassword,
                  validator: (val) => val?.isEmpty == true
                      ? "Please enter confirm password"
                      : val != registerBloc.password.text.toString()
                          ? "Password and confirm password are not same."
                          : null,
                  obscureText: true,
                  decoration: (const InputDecoration())
                      .applyDefaults(context.theme.inputDecorationTheme)
                      .copyWith(
                        prefixIcon: const Icon(
                          Icons.password,
                          color: Colors.grey,
                        ),
                        hintText: "Confirm Password",
                        hintStyle: context.theme.textTheme.titleSmall?.copyWith(
                          fontWeight: AppFontWeight().lightFontWeight,
                          color: Colors.grey,
                        ),
                      ),
                ),
                AppConstants.sizedBoxHeight(context, defaultValue: 35),
                SizedBox(
                  height: AppConstants.kAppButtonHeight(context),
                  child: BlocConsumer<RegisterBloc, RegisterState>(
                    bloc: registerBloc,
                    listener: (ctx, state) {
                      if (state is RegisterFailure) {
                        AppSnackBar().showErrorSnackBar(
                            context: ctx, error: state.error);
                      }
                      if (state is RegisterSuccess) {
                        if (state.isRegistered == true) {
                          AppSnackBar().showSuccessSnackBar(
                            context: ctx,
                            successMsg: state.message,
                          );
                          AppNavigations()
                              .navigateFromRegisterScreenToVerifyEmail(
                                  context: context,
                                  email: registerBloc.email.text.toString());
                        }
                      }
                    },
                    builder: (context, state) {
                      if (state is RegisterLoading) {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      }
                      return FilledButton(
                        onPressed: () {
                          if (registerBloc.registerFormKey.currentState
                                  ?.validate() ==
                              true) {
                            registerBloc.callRegisterMethod();
                          }
                        },
                        child: Text(
                          "Register",
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
                      AppNavigations().navigateBack(context: context);
                    },
                    child: Text(
                      "Login Now",
                      style: context.theme.textTheme.bodyLarge,
                    ),
                  ),
                ),
              ],
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
