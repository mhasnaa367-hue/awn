// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Awn';

  @override
  String get welcomeBack => 'Welcome \n Back';

  @override
  String get pleaseSignIn => 'Please sign in to continue';

  @override
  String get signIn => 'Sign In';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get rememberMe => 'Remember me';

  @override
  String get forgetPassword => 'Forget Password?';

  @override
  String get continueAsGuest => 'Continue as Guest';

  @override
  String get dontHaveAccount => 'Don\'t have an account? ';

  @override
  String get signUp => 'Sign up';

  @override
  String get or => 'Or';

  @override
  String get enterEmail => 'Please Enter Your Email';

  @override
  String get validEmail => 'Enter valid email';

  @override
  String get enterPassword => 'Please Enter Your Password';

  @override
  String get passwordLength => 'Password must be at least 6 chars';

  @override
  String get onboard1Title => 'Learn Smarter with One Snap!';

  @override
  String get onboard1Desc =>
      'Take a picture and let the app tell you what it\'s all about';

  @override
  String get onboard2Title => 'Instant Understanding';

  @override
  String get onboard2Desc =>
      'Get the main idea of any page in seconds no reading needed';

  @override
  String get onboard3Title => 'Learn More, Watch More!';

  @override
  String get onboard3Desc =>
      'Discover short YouTube videos that explain your image topic clearly';

  @override
  String get next => 'Next';

  @override
  String get getStarted => 'Get Started';

  @override
  String get register => 'Register';

  @override
  String get pleaseRegister => 'Please register to continue';

  @override
  String get username => 'Username';

  @override
  String get confirmPassword => 'Confirm password';

  @override
  String get enterUsername => 'Please Enter Your Username';

  @override
  String get confirmPasswordError => 'Please Confirm Your Password';

  @override
  String get passwordsNotMatch => 'Passwords don\'t match';

  @override
  String get alreadyHaveAccount => 'Already have an account? ';

  @override
  String get registerTitle => 'Create\nAccount';

  @override
  String get forgetPasswordTitle => 'Forget Password';

  @override
  String get forgetPasswordDesc =>
      'Please Enter Your Email Address To\nReceive a Verification Code';

  @override
  String get send => 'Send';

  @override
  String get newPassword => 'New password';

  @override
  String get verifyPasswordDesc =>
      'Your New Password Must Be Different\nFrom Previously Used Password';

  @override
  String get enterNewPassword => 'Please Enter Password';

  @override
  String get passwordMin8 => 'Password must be at least 8 characters';

  @override
  String get passwordMatch => 'Password must match';

  @override
  String get save => 'Save';

  @override
  String get mailSentDesc =>
      'Please Enter The 4 Digit Code\nSent To Your Email';

  @override
  String get resendCode => 'Resend code';

  @override
  String get verify => 'Verify';

  @override
  String get hiUser => 'Hi, Eman 👋';

  @override
  String get readyToLearn => 'Ready to learn something new today';

  @override
  String get scanPage => 'Scan a Page';

  @override
  String get scanPageSubtitle => 'Capture a page and get its summary instantly';

  @override
  String get uploadFile => 'Upload Image or File';

  @override
  String get uploadFileSubtitle =>
      'Choose an image or PDF from your phone to summarize';

  @override
  String get favorites => 'Favorites';

  @override
  String get noFavorites => 'No favorites yet';

  @override
  String get profile => 'Profile';

  @override
  String get editName => 'Name';

  @override
  String get editEmail => 'Email';

  @override
  String get edit => 'Edit';

  @override
  String get cancel => 'Cancel';

  @override
  String get language => 'Language';

  @override
  String get dark => 'Dark';

  @override
  String get logOut => 'Log Out';

  @override
  String get history => 'History';

  @override
  String get result => 'Result';

  @override
  String get mainTopic => 'Main Topic:';

  @override
  String get summary => 'Summary:';

  @override
  String get watchVideos => 'Watch related videos:';

  @override
  String get hiEman => 'Hi, Eman 👋';

  @override
  String get learnSmarter => 'Learn smarter,\nnot harder. 💡';

  @override
  String get home => 'Home';

  @override
  String get favoritesList => 'Favorites';

  @override
  String get historyList => 'History';

  @override
  String get profileLabel => 'Profile';

  @override
  String get logOutUpper => 'LOG OUT';

  @override
  String get verifyEmailTitle => 'Verify Email';

  @override
  String get verifyEmailDesc =>
      'Please enter the 6 digit code\nsent to your email';

  @override
  String get emailVerified => 'Email verified successfully';

  @override
  String get otpResent => 'A new code has been sent';

  @override
  String get changePassword => 'Change Password';

  @override
  String get currentPassword => 'Current password';

  @override
  String get passwordChanged => 'Password changed. Please log in again.';

  @override
  String get profileUpdated => 'Profile updated';

  @override
  String get save_changes => 'Save';

  @override
  String get noDocuments => 'No documents yet';

  @override
  String get delete => 'Delete';

  @override
  String get deleteDocumentConfirm => 'Delete this document?';

  @override
  String get documentDeleted => 'Document deleted';

  @override
  String get retry => 'Retry';

  @override
  String get processingTitle => 'Processing…';

  @override
  String get processingDesc =>
      'Your document is being processed.\nThis may take a moment.';

  @override
  String get failedTitle => 'Processing failed';

  @override
  String get refreshVideos => 'Refresh videos';

  @override
  String get noVideos => 'No videos found for this topic yet';

  @override
  String get noSummary => 'No summary available yet';

  @override
  String get loadFailed => 'Could not load. Please try again.';

  @override
  String get logOutAllDevices => 'Log out of all devices';

  @override
  String greeting(String name) {
    return 'Hi, $name 👋';
  }
}
