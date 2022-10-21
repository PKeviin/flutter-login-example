// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "allow": MessageLookupByLibrary.simpleMessage("Allow"),
        "deny": MessageLookupByLibrary.simpleMessage("Deny"),
        "errorApi":
            MessageLookupByLibrary.simpleMessage("An error has occurred."),
        "errorApiNotFound": MessageLookupByLibrary.simpleMessage("Not found."),
        "errorApiUnauthorized": MessageLookupByLibrary.simpleMessage(
            "You are not authorized to access this content. Please log in again."),
        "errorBadRequestApi":
            MessageLookupByLibrary.simpleMessage("Invalid request."),
        "errorBiometrics": MessageLookupByLibrary.simpleMessage(
            "Biometric verification did not work."),
        "errorCertificatServerApi": MessageLookupByLibrary.simpleMessage(
            "An error occurred while setting up a secure connection to the server. Try Again."),
        "errorDataApi": MessageLookupByLibrary.simpleMessage(
            "An error occurred while retrieving data."),
        "errorFormatToken": MessageLookupByLibrary.simpleMessage(
            "An error occurred while retrieving the token."),
        "errorInternetConnection": MessageLookupByLibrary.simpleMessage(
            "Please check your internet connection."),
        "errorInternetNotAvailable": MessageLookupByLibrary.simpleMessage(
            "Your internet is not working."),
        "errorInvalidEmail":
            MessageLookupByLibrary.simpleMessage("Email is invalid."),
        "errorInvalidPassword": MessageLookupByLibrary.simpleMessage(
            "The password must be between 8 and 32 characters."),
        "errorInvalidURL": MessageLookupByLibrary.simpleMessage("Invalid URL."),
        "errorInvalidUsername": MessageLookupByLibrary.simpleMessage(
            "Username must not contain spaces."),
        "errorMessage": MessageLookupByLibrary.simpleMessage("Try Again."),
        "errorNoConnection":
            MessageLookupByLibrary.simpleMessage("Connection Failed"),
        "errorNoConnectionMessage": MessageLookupByLibrary.simpleMessage(
            "Could not connect to the network,\nPlease check and retry again."),
        "errorPageNotFound":
            MessageLookupByLibrary.simpleMessage("Page Not Found"),
        "errorPageNotFoundMessage": MessageLookupByLibrary.simpleMessage(
            "The page you are looking for doesn\'t seem to exist..."),
        "errorPassEmpty":
            MessageLookupByLibrary.simpleMessage("Invalid password."),
        "errorRetrievingUserCache": MessageLookupByLibrary.simpleMessage(
            "Error retrieving user from cache."),
        "errorSaveUserCache": MessageLookupByLibrary.simpleMessage(
            "Failed to save user in cache."),
        "errorServerApi": MessageLookupByLibrary.simpleMessage(
            "An error occurred while communicating with the server."),
        "errorSessionExpireApi":
            MessageLookupByLibrary.simpleMessage("Your session has expired."),
        "errorSomethingWentWrong":
            MessageLookupByLibrary.simpleMessage("Something went wrong."),
        "errorThisFieldRequired":
            MessageLookupByLibrary.simpleMessage("This field is required."),
        "errorVerificationCertificatApi": MessageLookupByLibrary.simpleMessage(
            "An error occurred while verifying the certificate. Try Again."),
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "labelError": MessageLookupByLibrary.simpleMessage("Error"),
        "labelSucces": MessageLookupByLibrary.simpleMessage("Sucess"),
        "login": MessageLookupByLibrary.simpleMessage("Sign in"),
        "loginCreateAnAccount": MessageLookupByLibrary.simpleMessage("Sign up"),
        "loginEmail": MessageLookupByLibrary.simpleMessage("Email"),
        "loginEmailField":
            MessageLookupByLibrary.simpleMessage("Enter your email"),
        "loginForgetPassword":
            MessageLookupByLibrary.simpleMessage("Forget password ?"),
        "loginHello": MessageLookupByLibrary.simpleMessage("Hello"),
        "loginNoAccount": MessageLookupByLibrary.simpleMessage(
            "You do not have an account ?"),
        "loginPassword": MessageLookupByLibrary.simpleMessage("Password"),
        "loginPasswordField":
            MessageLookupByLibrary.simpleMessage("Enter your password"),
        "loginSavePassword":
            MessageLookupByLibrary.simpleMessage("Save password"),
        "loginSignInButton": MessageLookupByLibrary.simpleMessage("Sign in"),
        "logout": MessageLookupByLibrary.simpleMessage("Logout"),
        "permissionQuestion": MessageLookupByLibrary.simpleMessage(
            "We need your permission to collect data."),
        "themeDark": MessageLookupByLibrary.simpleMessage("Dark"),
        "themeLight": MessageLookupByLibrary.simpleMessage("Light")
      };
}
