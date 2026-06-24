import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Awn'**
  String get appTitle;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome \n Back'**
  String get welcomeBack;

  /// No description provided for @pleaseSignIn.
  ///
  /// In en, this message translates to:
  /// **'Please sign in to continue'**
  String get pleaseSignIn;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberMe;

  /// No description provided for @forgetPassword.
  ///
  /// In en, this message translates to:
  /// **'Forget Password?'**
  String get forgetPassword;

  /// No description provided for @continueAsGuest.
  ///
  /// In en, this message translates to:
  /// **'Continue as Guest'**
  String get continueAsGuest;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get dontHaveAccount;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUp;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'Or'**
  String get or;

  /// No description provided for @enterEmail.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Your Email'**
  String get enterEmail;

  /// No description provided for @validEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter valid email'**
  String get validEmail;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Your Password'**
  String get enterPassword;

  /// No description provided for @passwordLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 chars'**
  String get passwordLength;

  /// No description provided for @onboard1Title.
  ///
  /// In en, this message translates to:
  /// **'Learn Smarter with One Snap!'**
  String get onboard1Title;

  /// No description provided for @onboard1Desc.
  ///
  /// In en, this message translates to:
  /// **'Take a picture and let the app tell you what it\'s all about'**
  String get onboard1Desc;

  /// No description provided for @onboard2Title.
  ///
  /// In en, this message translates to:
  /// **'Instant Understanding'**
  String get onboard2Title;

  /// No description provided for @onboard2Desc.
  ///
  /// In en, this message translates to:
  /// **'Get the main idea of any page in seconds no reading needed'**
  String get onboard2Desc;

  /// No description provided for @onboard3Title.
  ///
  /// In en, this message translates to:
  /// **'Learn More, Watch More!'**
  String get onboard3Title;

  /// No description provided for @onboard3Desc.
  ///
  /// In en, this message translates to:
  /// **'Discover short YouTube videos that explain your image topic clearly'**
  String get onboard3Desc;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @pleaseRegister.
  ///
  /// In en, this message translates to:
  /// **'Please register to continue'**
  String get pleaseRegister;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// No description provided for @enterUsername.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Your Username'**
  String get enterUsername;

  /// No description provided for @confirmPasswordError.
  ///
  /// In en, this message translates to:
  /// **'Please Confirm Your Password'**
  String get confirmPasswordError;

  /// No description provided for @passwordsNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords don\'t match'**
  String get passwordsNotMatch;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get alreadyHaveAccount;

  /// No description provided for @registerTitle.
  ///
  /// In en, this message translates to:
  /// **'Create\nAccount'**
  String get registerTitle;

  /// No description provided for @forgetPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Forget Password'**
  String get forgetPasswordTitle;

  /// No description provided for @forgetPasswordDesc.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Your Email Address To\nReceive a Verification Code'**
  String get forgetPasswordDesc;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get newPassword;

  /// No description provided for @verifyPasswordDesc.
  ///
  /// In en, this message translates to:
  /// **'Your New Password Must Be Different\nFrom Previously Used Password'**
  String get verifyPasswordDesc;

  /// No description provided for @enterNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Password'**
  String get enterNewPassword;

  /// No description provided for @passwordMin8.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get passwordMin8;

  /// No description provided for @passwordMatch.
  ///
  /// In en, this message translates to:
  /// **'Password must match'**
  String get passwordMatch;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @mailSentDesc.
  ///
  /// In en, this message translates to:
  /// **'Please Enter The 4 Digit Code\nSent To Your Email'**
  String get mailSentDesc;

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get resendCode;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @hiUser.
  ///
  /// In en, this message translates to:
  /// **'Hi, Eman 👋'**
  String get hiUser;

  /// No description provided for @readyToLearn.
  ///
  /// In en, this message translates to:
  /// **'Ready to learn something new today'**
  String get readyToLearn;

  /// No description provided for @scanPage.
  ///
  /// In en, this message translates to:
  /// **'Scan a Page'**
  String get scanPage;

  /// No description provided for @scanPageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Capture a page and get its summary instantly'**
  String get scanPageSubtitle;

  /// No description provided for @uploadFile.
  ///
  /// In en, this message translates to:
  /// **'Upload Image or File'**
  String get uploadFile;

  /// No description provided for @uploadFileSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose an image or PDF from your phone to summarize'**
  String get uploadFileSubtitle;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @noFavorites.
  ///
  /// In en, this message translates to:
  /// **'No favorites yet'**
  String get noFavorites;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @editName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get editName;

  /// No description provided for @editEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get editEmail;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logOut;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @result.
  ///
  /// In en, this message translates to:
  /// **'Result'**
  String get result;

  /// No description provided for @mainTopic.
  ///
  /// In en, this message translates to:
  /// **'Main Topic:'**
  String get mainTopic;

  /// No description provided for @summary.
  ///
  /// In en, this message translates to:
  /// **'Summary:'**
  String get summary;

  /// No description provided for @watchVideos.
  ///
  /// In en, this message translates to:
  /// **'Watch related videos:'**
  String get watchVideos;

  /// No description provided for @hiEman.
  ///
  /// In en, this message translates to:
  /// **'Hi, Eman 👋'**
  String get hiEman;

  /// No description provided for @learnSmarter.
  ///
  /// In en, this message translates to:
  /// **'Learn smarter,\nnot harder. 💡'**
  String get learnSmarter;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @favoritesList.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favoritesList;

  /// No description provided for @historyList.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get historyList;

  /// No description provided for @profileLabel.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileLabel;

  /// No description provided for @logOutUpper.
  ///
  /// In en, this message translates to:
  /// **'LOG OUT'**
  String get logOutUpper;

  /// No description provided for @verifyEmailTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify Email'**
  String get verifyEmailTitle;

  /// No description provided for @verifyEmailDesc.
  ///
  /// In en, this message translates to:
  /// **'Please enter the 6 digit code\nsent to your email'**
  String get verifyEmailDesc;

  /// No description provided for @emailVerified.
  ///
  /// In en, this message translates to:
  /// **'Email verified successfully'**
  String get emailVerified;

  /// No description provided for @otpResent.
  ///
  /// In en, this message translates to:
  /// **'A new code has been sent'**
  String get otpResent;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @currentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current password'**
  String get currentPassword;

  /// No description provided for @passwordChanged.
  ///
  /// In en, this message translates to:
  /// **'Password changed. Please log in again.'**
  String get passwordChanged;

  /// No description provided for @profileUpdated.
  ///
  /// In en, this message translates to:
  /// **'Profile updated'**
  String get profileUpdated;

  /// No description provided for @save_changes.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save_changes;

  /// No description provided for @noDocuments.
  ///
  /// In en, this message translates to:
  /// **'No documents yet'**
  String get noDocuments;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @deleteDocumentConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete this document?'**
  String get deleteDocumentConfirm;

  /// No description provided for @documentDeleted.
  ///
  /// In en, this message translates to:
  /// **'Document deleted'**
  String get documentDeleted;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @processingTitle.
  ///
  /// In en, this message translates to:
  /// **'Processing…'**
  String get processingTitle;

  /// No description provided for @processingDesc.
  ///
  /// In en, this message translates to:
  /// **'Your document is being processed.\nThis may take a moment.'**
  String get processingDesc;

  /// No description provided for @failedTitle.
  ///
  /// In en, this message translates to:
  /// **'Processing failed'**
  String get failedTitle;

  /// No description provided for @refreshVideos.
  ///
  /// In en, this message translates to:
  /// **'Refresh videos'**
  String get refreshVideos;

  /// No description provided for @noVideos.
  ///
  /// In en, this message translates to:
  /// **'No videos found for this topic yet'**
  String get noVideos;

  /// No description provided for @noSummary.
  ///
  /// In en, this message translates to:
  /// **'No summary available yet'**
  String get noSummary;

  /// No description provided for @loadFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not load. Please try again.'**
  String get loadFailed;

  /// No description provided for @logOutAllDevices.
  ///
  /// In en, this message translates to:
  /// **'Log out of all devices'**
  String get logOutAllDevices;

  /// No description provided for @greeting.
  ///
  /// In en, this message translates to:
  /// **'Hi, {name} 👋'**
  String greeting(String name);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
