import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:serverpod/serverpod.dart';

import 'package:ecom_server/src/web/routes/root.dart';

import 'src/generated/protocol.dart';
import 'src/generated/endpoints.dart';
import 'package:serverpod_auth_server/module.dart' as auth;

// This is the starting point of your Serverpod server. In most cases, you will
// only need to make additions to this file if you add future calls,  are
// configuring Relic (Serverpod's web-server), or need custom setup work.

void run(List<String> args) async {
  // Initialize Serverpod and connect it with your generated code.
  final pod = Serverpod(
    args,
    Protocol(),
    Endpoints(),
  );

  // If you are using any future calls, they need to be registered here.
  // pod.registerFutureCall(ExampleFutureCall(), 'exampleFutureCall');

  // Setup a default page at the web root.
  pod.webServer.addRoute(RouteRoot(), '/');
  pod.webServer.addRoute(RouteRoot(), '/index.html');
  // Serve all files in the /static directory.
  pod.webServer.addRoute(
    RouteStaticDirectory(serverDirectory: 'static', basePath: '/'),
    '/*',
  );

  auth.AuthConfig.set(auth.AuthConfig(
    sendValidationEmail: (session, email, validationCode) async {
      // Send the validation email to the user.
      // Return `true` if the email was successfully sent, otherwise `false`.

      sendEmail(
          session: session, email: email, verificationCode: validationCode);
      return true;
    },
    sendPasswordResetEmail: (session, userInfo, validationCode) async {
      // Send the password reset email to the user.
      // Return `true` if the email was successfully sent, otherwise `false`.
      sendEmail(
          session: session,
          email: userInfo.email ?? "",
          verificationCode: validationCode);
      return true;
    },
  ));

  // Start the server.
  await pod.start();
}

sendEmail(
    {required Session session,
    required String email,
    required String verificationCode}) async {
  String username = session.passwords["mailerEmail"] ?? ''; //Your Email
  String password = session.passwords["mailerPassword"] ??
      ""; // 16 Digits App Password Generated From Google Account

  final smtpServer = gmail(username, password);
  // Use the SmtpServer class to configure an SMTP server:
  // final smtpServer = SmtpServer('smtp.domain.com');
  // See the named arguments of SmtpServer for further configuration
  // options.

  // Create our message.
  final message = Message()
    ..from = Address(username, 'Mashood Siddiquie')
    ..recipients.add(email)
    ..subject = 'Account verification for E-commerce app'
    ..text =
        'Hi, Thanks for signing up with $email on E-commerce app. Please use this code to verify your account: $verificationCode';

  try {
    await send(message, smtpServer);
  } on MailerException catch (e) {
    print('Message not sent.');
    print(e.message);
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }
}
