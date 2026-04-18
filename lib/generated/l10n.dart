import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'l10n_ar.dart';
import 'l10n_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of S
/// returned by `S.of(context)`.
///
/// Applications need to include `S.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/l10n.dart';
///
/// return MaterialApp(
///   localizationsDelegates: S.localizationsDelegates,
///   supportedLocales: S.supportedLocales,
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
/// be consistent with the languages listed in the S.supportedLocales
/// property.
abstract class S {
  S(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S)!;
  }

  static const LocalizationsDelegate<S> delegate = _SDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// Validation message when a required field is empty
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get fieldRequired;

  /// Log in button label
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get logIn;

  /// Sign up button label
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// Onboarding page 1 title
  ///
  /// In en, this message translates to:
  /// **'Stop wasting time!'**
  String get onBoardingTitle1;

  /// Onboarding page 1 subtitle
  ///
  /// In en, this message translates to:
  /// **'Safqa transforms the long auction process into a fast, guaranteed digital experience, manage your auctions wherever you are.'**
  String get onBoardingSubtitle1;

  /// Onboarding page 2 title
  ///
  /// In en, this message translates to:
  /// **'Smart Bidding'**
  String get onBoardingTitle2;

  /// Onboarding page 2 subtitle
  ///
  /// In en, this message translates to:
  /// **'Participate in real-time bidding, or let the Proxy Bidding (Auto-Bid) system win automatically within your defined limit.'**
  String get onBoardingSubtitle2;

  /// Onboarding page 3 title
  ///
  /// In en, this message translates to:
  /// **'Experience Designed For You'**
  String get onBoardingTitle3;

  /// Onboarding page 3 subtitle
  ///
  /// In en, this message translates to:
  /// **'A modern, bilingual (Arabic/English) design that allows you to navigate and bid seamlessly from any device.'**
  String get onBoardingSubtitle3;

  /// Sign in button label
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// Email field label
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// Password field label
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Forgot password link label
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// Sign in with Google button label
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get signInWithGoogle;

  /// Sign in with Apple button label
  ///
  /// In en, this message translates to:
  /// **'Sign in with Apple'**
  String get signInWithApple;

  /// Sign in with Facebook button label
  ///
  /// In en, this message translates to:
  /// **'Sign in with Facebook'**
  String get signInWithFacebook;

  /// Full name field label
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// Phone number field label
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// Birthdate field label
  ///
  /// In en, this message translates to:
  /// **'Birthdate'**
  String get birthdate;

  /// Gender field label
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// Male gender option
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// Female gender option
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// Message shown when OTP is sent to email
  ///
  /// In en, this message translates to:
  /// **'OTP sent to your email'**
  String get otpSentToEmail;

  /// Prefix text before terms and conditions link
  ///
  /// In en, this message translates to:
  /// **'By signing up, you agree to our'**
  String get termsAndConditionsPrefix;

  /// Terms and conditions link label
  ///
  /// In en, this message translates to:
  /// **'Terms and Conditions'**
  String get termsAndConditions;

  /// Divider text between sign in options
  ///
  /// In en, this message translates to:
  /// **'Or'**
  String get or;

  /// Text shown when user already has an account
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get haveAccount;

  /// Text shown when user does not have an account
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// Create account button label
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// Verification code screen title
  ///
  /// In en, this message translates to:
  /// **'Verification Code'**
  String get verificationCode;

  /// Verification code screen description
  ///
  /// In en, this message translates to:
  /// **'Enter the verification code sent to your email'**
  String get verificationCodeDescription;

  /// Message shown when email is confirmed successfully
  ///
  /// In en, this message translates to:
  /// **'Email confirmed successfully'**
  String get emailConfirmedSuccessfully;

  /// Message shown when OTP is resent successfully
  ///
  /// In en, this message translates to:
  /// **'OTP resent successfully'**
  String get otpResentSuccessfully;

  /// Message shown when OTP has expired
  ///
  /// In en, this message translates to:
  /// **'OTP has expired'**
  String get otpExpired;

  /// Message shown when OTP is invalid
  ///
  /// In en, this message translates to:
  /// **'Invalid OTP'**
  String get invalidOtp;

  /// Verify button label
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// Text shown when user did not receive verification code
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive a code?'**
  String get dontReceiveCode;

  /// Resend button label
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resend;

  /// Forgot password screen title
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgetPasswordTitle;

  /// Forgot password screen description
  ///
  /// In en, this message translates to:
  /// **'Enter your email address and we\'ll send you a code to reset your password'**
  String get forgetPasswordDescription;

  /// Send code button label
  ///
  /// In en, this message translates to:
  /// **'Send Code'**
  String get sendCode;

  /// Create password screen title and button label
  ///
  /// In en, this message translates to:
  /// **'Create Password'**
  String get createPassword;

  /// Create password screen description
  ///
  /// In en, this message translates to:
  /// **'Create a new password for your account'**
  String get createPasswordDescription;

  /// New password field label
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// Confirm password field label
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// Message shown when password is reset successfully
  ///
  /// In en, this message translates to:
  /// **'Password reset successfully'**
  String get passwordResetSuccessfully;

  /// Validation message when passwords do not match
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// Terms: platform compliance paragraph
  ///
  /// In en, this message translates to:
  /// **'All users must comply with the platform\'s rules and regulations at all times.'**
  String get termsPlatformCompliance;

  /// Terms: accurate info paragraph
  ///
  /// In en, this message translates to:
  /// **'Users are required to provide accurate and truthful information when using the platform.'**
  String get termsAccurateInfo;

  /// Terms: suspend accounts paragraph
  ///
  /// In en, this message translates to:
  /// **'Safqa reserves the right to suspend or terminate accounts that violate these terms.'**
  String get termsSuspendAccounts;

  /// Terms: monitored paragraph
  ///
  /// In en, this message translates to:
  /// **'All activities on the platform are monitored to ensure compliance and security.'**
  String get termsMonitored;

  /// Terms: buyer app section title
  ///
  /// In en, this message translates to:
  /// **'Buyer Application'**
  String get termsBuyerAppTitle;

  /// Terms: account usage section title
  ///
  /// In en, this message translates to:
  /// **'Account Usage'**
  String get termsAccountUsageTitle;

  /// Terms: buyer age paragraph
  ///
  /// In en, this message translates to:
  /// **'Buyers must be at least 18 years of age to create an account and participate in auctions.'**
  String get termsBuyerAge;

  /// Terms: buyer credentials paragraph
  ///
  /// In en, this message translates to:
  /// **'Buyers are responsible for maintaining the confidentiality of their account credentials.'**
  String get termsBuyerCredentials;

  /// Terms: buyer multiple accounts paragraph
  ///
  /// In en, this message translates to:
  /// **'Creating multiple accounts for the same individual is strictly prohibited.'**
  String get termsBuyerMultipleAccounts;

  /// Terms: bidding rules section title
  ///
  /// In en, this message translates to:
  /// **'Bidding Rules'**
  String get termsBiddingRulesTitle;

  /// Terms: binding bids paragraph
  ///
  /// In en, this message translates to:
  /// **'All bids placed on the platform are legally binding and cannot be retracted.'**
  String get termsBindingBids;

  /// Terms: highest bid wins paragraph
  ///
  /// In en, this message translates to:
  /// **'The highest bid at the close of the auction wins the item.'**
  String get termsHighestBidWins;

  /// Terms: proxy bidding rules paragraph
  ///
  /// In en, this message translates to:
  /// **'Proxy bidding allows the system to automatically bid on your behalf up to your maximum limit.'**
  String get termsProxyBiddingRules;

  /// Terms: manipulate bids paragraph
  ///
  /// In en, this message translates to:
  /// **'Any attempt to manipulate bids or collude with other bidders is strictly prohibited.'**
  String get termsManipulateBids;

  /// Terms: payments section title
  ///
  /// In en, this message translates to:
  /// **'Payments'**
  String get termsPaymentsTitle;

  /// Terms: wallet balance paragraph
  ///
  /// In en, this message translates to:
  /// **'Buyers must maintain sufficient wallet balance to cover their bids and purchases.'**
  String get termsWalletBalance;

  /// Terms: security deposits paragraph
  ///
  /// In en, this message translates to:
  /// **'Security deposits may be required for certain high-value auctions.'**
  String get termsSecurityDeposits;

  /// Terms: refunds policy paragraph
  ///
  /// In en, this message translates to:
  /// **'Refunds are processed within 7 business days after a valid dispute is resolved in the buyer\'s favor.'**
  String get termsRefundsPolicy;

  /// Terms: disputes section title
  ///
  /// In en, this message translates to:
  /// **'Disputes'**
  String get termsDisputesTitle;

  /// Terms: raise disputes paragraph
  ///
  /// In en, this message translates to:
  /// **'Buyers may raise a dispute within 48 hours of receiving an item that does not match the description.'**
  String get termsRaiseDisputes;

  /// Terms: dispute decisions paragraph
  ///
  /// In en, this message translates to:
  /// **'Safqa\'s dispute resolution team will review all submitted evidence and make a final decision.'**
  String get termsDisputeDecisions;

  /// Terms: seller app section title
  ///
  /// In en, this message translates to:
  /// **'Seller Application'**
  String get termsSellerAppTitle;

  /// Terms: seller registration section title
  ///
  /// In en, this message translates to:
  /// **'Seller Registration'**
  String get termsSellerRegTitle;

  /// Terms: seller verification paragraph
  ///
  /// In en, this message translates to:
  /// **'All sellers must complete identity verification before listing items for auction.'**
  String get termsSellerVerification;

  /// Terms: seller approval paragraph
  ///
  /// In en, this message translates to:
  /// **'Seller accounts are subject to approval by the Safqa team before becoming active.'**
  String get termsSellerApproval;

  /// Terms: seller accuracy paragraph
  ///
  /// In en, this message translates to:
  /// **'Sellers are responsible for the accuracy and completeness of their product listings.'**
  String get termsSellerAccuracy;

  /// Terms: auction management section title
  ///
  /// In en, this message translates to:
  /// **'Auction Management'**
  String get termsAuctionMgmtTitle;

  /// Terms: honest descriptions paragraph
  ///
  /// In en, this message translates to:
  /// **'Sellers must provide honest and accurate descriptions of all items listed for auction.'**
  String get termsHonestDescriptions;

  /// Terms: auction rules paragraph
  ///
  /// In en, this message translates to:
  /// **'Sellers must adhere to all platform auction rules, including minimum pricing guidelines.'**
  String get termsAuctionRules;

  /// Terms: no modify active paragraph
  ///
  /// In en, this message translates to:
  /// **'Active auction listings cannot be modified once bidding has commenced.'**
  String get termsNoModifyActive;

  /// Terms: delivery section title
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get termsDeliveryTitle;

  /// Terms: timely delivery paragraph
  ///
  /// In en, this message translates to:
  /// **'Sellers are obligated to deliver items to winning buyers within the agreed timeframe.'**
  String get termsTimelyDelivery;

  /// Terms: delivery info paragraph
  ///
  /// In en, this message translates to:
  /// **'Accurate delivery information must be provided to ensure smooth and timely shipments.'**
  String get termsDeliveryInfo;

  /// Terms: failure to deliver paragraph
  ///
  /// In en, this message translates to:
  /// **'Failure to deliver items may result in account suspension and financial penalties.'**
  String get termsFailureToDeliver;

  /// Terms: fees section title
  ///
  /// In en, this message translates to:
  /// **'Fees'**
  String get termsFeesTitle;

  /// Terms: platform fees paragraph
  ///
  /// In en, this message translates to:
  /// **'Safqa charges a platform fee on all successfully completed auction transactions.'**
  String get termsPlatformFees;

  /// Terms: track earnings paragraph
  ///
  /// In en, this message translates to:
  /// **'Sellers can track their earnings and fee deductions in real time through the seller dashboard.'**
  String get termsTrackEarnings;

  /// Terms: notification policy section title
  ///
  /// In en, this message translates to:
  /// **'Notification Policy'**
  String get termsNotifPolicyTitle;

  /// Terms: notifications generated paragraph
  ///
  /// In en, this message translates to:
  /// **'Notifications are automatically generated for key events such as new bids, auction endings, and payments.'**
  String get termsNotifGenerated;

  /// Terms: notifications informational paragraph
  ///
  /// In en, this message translates to:
  /// **'Notifications are for informational purposes only and do not constitute legal or financial advice.'**
  String get termsNotifInformational;

  /// Terms: review notifications paragraph
  ///
  /// In en, this message translates to:
  /// **'Users are responsible for reviewing all notifications and taking appropriate action in a timely manner.'**
  String get termsReviewNotif;

  /// Terms: privacy and data section title
  ///
  /// In en, this message translates to:
  /// **'Privacy & Data'**
  String get termsPrivacyDataTitle;

  /// Terms: data collected paragraph
  ///
  /// In en, this message translates to:
  /// **'Safqa collects personal data including name, email, phone number, and transaction history.'**
  String get termsDataCollected;

  /// Terms: data protected paragraph
  ///
  /// In en, this message translates to:
  /// **'All collected data is stored securely and protected against unauthorized access.'**
  String get termsDataProtected;

  /// Terms: no share data paragraph
  ///
  /// In en, this message translates to:
  /// **'Safqa does not share personal user data with third parties without explicit user consent.'**
  String get termsNoShareData;

  /// Terms: liability section title
  ///
  /// In en, this message translates to:
  /// **'Liability'**
  String get termsLiabilityTitle;

  /// Terms: not responsible paragraph
  ///
  /// In en, this message translates to:
  /// **'Safqa is not responsible for losses arising from user errors or third-party service failures.'**
  String get termsNotResponsible;

  /// Terms: downtime paragraph
  ///
  /// In en, this message translates to:
  /// **'The platform may experience scheduled or unscheduled downtime for maintenance purposes.'**
  String get termsDowntime;

  /// Terms: intermediary paragraph
  ///
  /// In en, this message translates to:
  /// **'Safqa acts solely as an intermediary between buyers and sellers and does not guarantee transaction outcomes.'**
  String get termsIntermediary;

  /// Terms: changes to terms section title
  ///
  /// In en, this message translates to:
  /// **'Changes to Terms'**
  String get termsChangesTitle;

  /// Terms: updated anytime paragraph
  ///
  /// In en, this message translates to:
  /// **'Safqa reserves the right to update these terms and conditions at any time without prior notice.'**
  String get termsUpdatedAnytime;

  /// Terms: continued use paragraph
  ///
  /// In en, this message translates to:
  /// **'Continued use of the platform after any changes constitutes acceptance of the updated terms.'**
  String get termsContinuedUse;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'No previous page to navigate back to'**
  String get kNoPreviousPageTo;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Login Successful!'**
  String get kLoginSuccessful;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get kCountry;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get kCity;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Please fill all fields including City'**
  String get kPleaseFillAllFiel;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Account Type'**
  String get kAccountType;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Please select a bank'**
  String get kPleaseSelectABank;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Legal documents are missing. Please go back.'**
  String get kLegalDocumentsAre;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Financial Details'**
  String get kFinancialDetails;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Insta Pay Number (Optional)'**
  String get kInstaPayNumberOp;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Bank Name'**
  String get kBankName;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Account Name / Beneficiary Name'**
  String get kAccountNameBenef;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Company IBAN'**
  String get kCompanyIban;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Local Account Number (Optional)'**
  String get kLocalAccountNumber;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Please upload all three documents'**
  String get kPleaseUploadAllTh;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Identity Verification'**
  String get kIdentityVerificatio;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Upload National ID (Front)'**
  String get kUploadNationalId;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Take a Selfie with ID'**
  String get kTakeASelfieWithI;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Legal Documents'**
  String get kLegalDocuments;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Upload Commercial Registration (CR)'**
  String get kUploadCommercialRe;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Upload Tax ID'**
  String get kUploadTaxId;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Upload Owner\\'**
  String get kUploadOwner;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Please upload all four documents'**
  String get kPleaseUploadAllFo;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Please select a country and a city'**
  String get kPleaseSelectACoun;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Seller Information'**
  String get kSellerInformation;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Store Name'**
  String get kStoreName;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get kPhoneNumber;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Select Country'**
  String get kSelectCountry;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Select City'**
  String get kSelectCity;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Logo (Optional)'**
  String get kLogoOptional;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get kDescription;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Store Information'**
  String get kStoreInformation;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Legal Business Name'**
  String get kLegalBusinessName;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Business Number'**
  String get kBusinessNumber;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Business Address'**
  String get kBusinessAddress;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Store Logo (Optional)'**
  String get kStoreLogoOptional;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Store Description'**
  String get kStoreDescription;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'New Lot Auction'**
  String get kNewLotAuction;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'New Single Auction'**
  String get kNewSingleAuction;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get kHistory;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get kStatistics;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Opening chat...'**
  String get kOpeningChat;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Business Account'**
  String get kBusinessAccount;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Upgrade'**
  String get kUpgrade;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get kEdit;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Edit account'**
  String get kEditAccount;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get kSave;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get kProfileUpdatedSuccessfully;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Change profile photo'**
  String get kEditAccountPhotoHint;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get kWallet;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Cairo, Egypt'**
  String get kCairoEgypt;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Reviews & Ratings'**
  String get kReviewsRatings;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get kChangeLanguage;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get kLogout;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get kEnglish;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Deposit successful!'**
  String get kDepositSuccessful;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Deposit'**
  String get kDeposit;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Enter deposit amount'**
  String get kEnterDepositAmount;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'No saved cards'**
  String get kNoSavedCards;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Add Card'**
  String get kAddCard;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get kTransactions;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'No transactions yet'**
  String get kNoTransactionsYet;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Primary'**
  String get kPrimary;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Withdrawal'**
  String get kWithdrawal;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Deposit\\nmoney'**
  String get kDepositNmoney;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Withdrawal\\nmoney'**
  String get kWithdrawalNmoney;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Transaction History'**
  String get kTransactionHistory;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'EXPIRES'**
  String get kExpires;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Withdrawal successful!'**
  String get kWithdrawalSuccessfu;

  /// Auto-generated
  ///
  /// In en, this message translates to:
  /// **'Enter withdrawal amount'**
  String get kEnterWithdrawalAmo;

  /// No description provided for @kUploadOwners.
  ///
  /// In en, this message translates to:
  /// **'Upload Owner\'s National ID'**
  String get kUploadOwners;

  /// No description provided for @kBasic.
  ///
  /// In en, this message translates to:
  /// **'Basic'**
  String get kBasic;

  /// No description provided for @kPremium.
  ///
  /// In en, this message translates to:
  /// **'Premium'**
  String get kPremium;

  /// No description provided for @kElite.
  ///
  /// In en, this message translates to:
  /// **'Elite'**
  String get kElite;

  /// No description provided for @kBoostNow.
  ///
  /// In en, this message translates to:
  /// **'Boost Now'**
  String get kBoostNow;

  /// No description provided for @kUpgradeToPremium.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Premium'**
  String get kUpgradeToPremium;

  /// No description provided for @kGoElite.
  ///
  /// In en, this message translates to:
  /// **'Go Elite'**
  String get kGoElite;

  /// No description provided for @kAppearsAtTheTop24.
  ///
  /// In en, this message translates to:
  /// **'Appears at the top of search results for 24 hours'**
  String get kAppearsAtTheTop24;

  /// No description provided for @kFeaturedBadge.
  ///
  /// In en, this message translates to:
  /// **'Featured badge on your auction'**
  String get kFeaturedBadge;

  /// No description provided for @kHighlightedCard.
  ///
  /// In en, this message translates to:
  /// **'Highlighted card color to attract buyers'**
  String get kHighlightedCard;

  /// No description provided for @kAppearsAtTheTop3D.
  ///
  /// In en, this message translates to:
  /// **'Appears at the top of search results for 3 days'**
  String get kAppearsAtTheTop3D;

  /// No description provided for @kPushNotifications.
  ///
  /// In en, this message translates to:
  /// **'Push notifications sent to interested buyers'**
  String get kPushNotifications;

  /// No description provided for @kFeaturedBadgeHighl.
  ///
  /// In en, this message translates to:
  /// **'Featured badge & highlighted card'**
  String get kFeaturedBadgeHighl;

  /// No description provided for @kBasicAnalytics.
  ///
  /// In en, this message translates to:
  /// **'Basic Analytics'**
  String get kBasicAnalytics;

  /// No description provided for @kPinnedAsTopBanner.
  ///
  /// In en, this message translates to:
  /// **'Pinned as a Top Banner on the homepage for 7 days'**
  String get kPinnedAsTopBanner;

  /// No description provided for @kInstantPushNotific.
  ///
  /// In en, this message translates to:
  /// **'Instant push notifications to all interested buyers'**
  String get kInstantPushNotific;

  /// No description provided for @kDetailedAnalytics.
  ///
  /// In en, this message translates to:
  /// **'Detailed Analytics'**
  String get kDetailedAnalytics;

  /// Shown when a seller upgrades successfully
  ///
  /// In en, this message translates to:
  /// **'Upgrade successful!'**
  String get kSubscriptionUpgradeSuccess;

  /// Shown when a seller upgrade request fails
  ///
  /// In en, this message translates to:
  /// **'Upgrade failed. Please try again.'**
  String get kSubscriptionUpgradeFailed;

  /// Label for the seller current upgrade plan
  ///
  /// In en, this message translates to:
  /// **'Active Plan'**
  String get kActivePlan;

  /// Shown when the seller has no active upgrade plan
  ///
  /// In en, this message translates to:
  /// **'No active plan'**
  String get kNoPlanActive;

  /// Button label for the seller active subscription tier
  ///
  /// In en, this message translates to:
  /// **'Current Plan'**
  String get kCurrentPlan;

  /// Button label for lower tiers already covered by a higher plan
  ///
  /// In en, this message translates to:
  /// **'Included in Current Plan'**
  String get kIncludedInCurrentPlan;

  /// Title and button label for change password screen
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get kChangePassword;

  /// Current password field label
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get kCurrentPassword;

  /// New password field label
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get kNewPassword;

  /// Confirm password field label
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get kConfirmPassword;

  /// Shown after successful password change
  ///
  /// In en, this message translates to:
  /// **'Password changed successfully.'**
  String get kPasswordChanged;

  /// Validation when confirm password does not match
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match.'**
  String get kPasswordMismatch;

  /// Validation for password minimum length
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters.'**
  String get kPasswordTooShort;

  /// Validation when new password matches current password
  ///
  /// In en, this message translates to:
  /// **'New password must differ from current.'**
  String get kPasswordSameAsCurrent;

  /// Search field hint in history screen
  ///
  /// In en, this message translates to:
  /// **'Search history'**
  String get historySearchHint;

  /// Retry button text in history screen
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get historyRetry;

  /// Export button label in history screen
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get historyExport;

  /// Auctions label in history header
  ///
  /// In en, this message translates to:
  /// **'Auctions'**
  String get historyAuctions;

  /// Empty state text when there are no history items
  ///
  /// In en, this message translates to:
  /// **'No history found.'**
  String get historyNoItems;

  /// Empty state text when search has no results in history
  ///
  /// In en, this message translates to:
  /// **'No matching history found.'**
  String get historyNoMatchingItems;

  /// Upcoming auction status label in history
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get historyStatusUpcoming;

  /// Active auction status label in history
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get historyStatusActive;

  /// Ending soon auction status label in history
  ///
  /// In en, this message translates to:
  /// **'Ending Soon'**
  String get historyStatusEndingSoon;

  /// Finished auction status label in history
  ///
  /// In en, this message translates to:
  /// **'Finished'**
  String get historyStatusFinished;

  /// Canceled auction status label in history
  ///
  /// In en, this message translates to:
  /// **'Canceled'**
  String get historyStatusCanceled;

  /// Sold auction status label in history
  ///
  /// In en, this message translates to:
  /// **'Sold'**
  String get historyStatusSold;

  /// Starting price label in history card
  ///
  /// In en, this message translates to:
  /// **'Starting Price'**
  String get historyStartingPrice;

  /// Current price label in history card
  ///
  /// In en, this message translates to:
  /// **'Current Price'**
  String get historyCurrentPrice;

  /// Final price label in history card
  ///
  /// In en, this message translates to:
  /// **'Final Price'**
  String get historyFinalPrice;

  /// Lot label prefix in history card
  ///
  /// In en, this message translates to:
  /// **'Lot'**
  String get historyLotLabel;

  /// Edit auction screen title
  ///
  /// In en, this message translates to:
  /// **'Edit Auction'**
  String get auctionEditTitle;

  /// Price and duration screen title
  ///
  /// In en, this message translates to:
  /// **'Price & Duration'**
  String get auctionPriceDuration;

  /// Bid increment section title
  ///
  /// In en, this message translates to:
  /// **'Bid Increment'**
  String get auctionBidIncrement;

  /// Auction date section title
  ///
  /// In en, this message translates to:
  /// **'Auction Date'**
  String get auctionDate;

  /// Auction start date field hint
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get auctionStartDate;

  /// Auction end date field hint
  ///
  /// In en, this message translates to:
  /// **'End Date'**
  String get auctionEndDate;

  /// Auction duration label
  ///
  /// In en, this message translates to:
  /// **'Auction Duration'**
  String get auctionDuration;

  /// Publish auction button label
  ///
  /// In en, this message translates to:
  /// **'Boost & Publish'**
  String get auctionBoostPublish;

  /// Publishing auction button label
  ///
  /// In en, this message translates to:
  /// **'Publishing...'**
  String get auctionPublishing;

  /// Specify custom value option
  ///
  /// In en, this message translates to:
  /// **'Specify'**
  String get auctionSpecify;

  /// Missing auction draft validation
  ///
  /// In en, this message translates to:
  /// **'Auction draft is missing.'**
  String get auctionDraftMissing;

  /// Invalid starting price validation
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid starting price.'**
  String get auctionValidStartingPriceError;

  /// Invalid bid increment validation
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid bid increment.'**
  String get auctionValidBidIncrementError;

  /// Missing start date validation
  ///
  /// In en, this message translates to:
  /// **'Please select a start date.'**
  String get auctionSelectStartDateError;

  /// Missing end date validation
  ///
  /// In en, this message translates to:
  /// **'Please select an end date.'**
  String get auctionSelectEndDateError;

  /// End date ordering validation
  ///
  /// In en, this message translates to:
  /// **'End date must be after start date.'**
  String get auctionEndDateAfterStart;

  /// Invalid duration validation
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid duration.'**
  String get auctionValidDurationError;

  /// Auction start info label
  ///
  /// In en, this message translates to:
  /// **'Starts in'**
  String get auctionStartsIn;

  /// Auction end info label
  ///
  /// In en, this message translates to:
  /// **'Ends in'**
  String get auctionEndsIn;

  /// Auction remaining time label
  ///
  /// In en, this message translates to:
  /// **'Time Left'**
  String get auctionTimeLeft;

  /// Auction item details and documents label
  ///
  /// In en, this message translates to:
  /// **'Details & Docs'**
  String get auctionDetailsDocs;

  /// Used condition label
  ///
  /// In en, this message translates to:
  /// **'Used'**
  String get auctionUsed;

  /// Lot details section title
  ///
  /// In en, this message translates to:
  /// **'Lot Details'**
  String get auctionLotDetails;

  /// Auction title field hint
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get auctionTitle;

  /// Auction category field hint
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get auctionCategory;

  /// Auction item label
  ///
  /// In en, this message translates to:
  /// **'Item'**
  String get auctionItem;

  /// Auction item count field hint
  ///
  /// In en, this message translates to:
  /// **'Count'**
  String get auctionCount;

  /// Auction warranty info field hint
  ///
  /// In en, this message translates to:
  /// **'Warranty INFO'**
  String get auctionWarrantyInfo;

  /// Auction condition section title
  ///
  /// In en, this message translates to:
  /// **'Condition'**
  String get auctionCondition;

  /// Add item action label
  ///
  /// In en, this message translates to:
  /// **'Add Item'**
  String get auctionAddItem;

  /// Lot description section title
  ///
  /// In en, this message translates to:
  /// **'Lot Description'**
  String get auctionLotDescription;

  /// Save edits button label
  ///
  /// In en, this message translates to:
  /// **'Save edits'**
  String get auctionSaveEdits;

  /// Hint below the auction image picker
  ///
  /// In en, this message translates to:
  /// **'Tap to change image'**
  String get auctionTapToChangeImage;

  /// Hint below the auction item images picker
  ///
  /// In en, this message translates to:
  /// **'Tap to add images'**
  String get auctionTapToAddImages;

  /// Validation when required item fields are empty
  ///
  /// In en, this message translates to:
  /// **'Please fill all required fields for item {index}.'**
  String auctionItemFieldsRequired(int index);

  /// Validation when item count is invalid
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid count for item {index}.'**
  String auctionItemInvalidCount(int index);

  /// Edit auction success message
  ///
  /// In en, this message translates to:
  /// **'Changes saved successfully'**
  String get auctionChangesSaved;

  /// Delete auction action label
  ///
  /// In en, this message translates to:
  /// **'Delete Auction'**
  String get auctionDeleteButton;

  /// Delete auction confirmation message
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this auction? This action cannot be undone.'**
  String get auctionDeleteConfirmMessage;

  /// Delete auction success message
  ///
  /// In en, this message translates to:
  /// **'Auction deleted successfully'**
  String get auctionDeleteSuccess;

  /// Edit auction success message from API
  ///
  /// In en, this message translates to:
  /// **'Auction updated successfully'**
  String get auctionEditSuccess;

  /// Auction details load failure fallback
  ///
  /// In en, this message translates to:
  /// **'Failed to load auction details'**
  String get auctionLoadError;

  /// New condition label
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get auctionNew;

  /// Used like new condition label
  ///
  /// In en, this message translates to:
  /// **'Used-Like New'**
  String get auctionUsedLikeNew;

  /// Generic retry action label
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// Chat list screen title
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get chatTitle;

  /// Chat list search field hint
  ///
  /// In en, this message translates to:
  /// **'Search conversations'**
  String get chatSearchHint;

  /// Shown when the seller has no conversations
  ///
  /// In en, this message translates to:
  /// **'No conversations yet'**
  String get chatNoConversations;

  /// Chat thread composer hint
  ///
  /// In en, this message translates to:
  /// **'Type a message...'**
  String get chatTypeMessage;

  /// Chat send action label
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get chatSend;

  /// Shown when a chat thread is empty
  ///
  /// In en, this message translates to:
  /// **'No messages yet'**
  String get chatNoMessages;

  /// Shown when sending a chat message fails
  ///
  /// In en, this message translates to:
  /// **'Failed to send message'**
  String get chatSendFailed;

  /// Label for the current user in chat
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get chatYou;

  /// Wallet saved cards section title
  ///
  /// In en, this message translates to:
  /// **'Saved Cards'**
  String get savedCards;

  /// Wallet saved card field label
  ///
  /// In en, this message translates to:
  /// **'Saved Card'**
  String get savedCard;

  /// See all action label
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get seeAll;

  /// Wallet add new card shortcut label
  ///
  /// In en, this message translates to:
  /// **'Add new card'**
  String get addNewCard;

  /// Wallet balance section label
  ///
  /// In en, this message translates to:
  /// **'Wallet balance'**
  String get walletBalance;

  /// Generic card label
  ///
  /// In en, this message translates to:
  /// **'Card'**
  String get card;

  /// Validation message when amount is empty
  ///
  /// In en, this message translates to:
  /// **'Enter an amount'**
  String get enterAmount;

  /// Validation message when amount is invalid
  ///
  /// In en, this message translates to:
  /// **'Enter a valid amount'**
  String get enterValidAmount;

  /// Withdrawal OTP screen description
  ///
  /// In en, this message translates to:
  /// **'Enter the verification code sent to your email to continue your withdrawal.'**
  String get verifyWithdrawalDescription;

  /// Confirm withdrawal action label
  ///
  /// In en, this message translates to:
  /// **'Confirm withdrawal'**
  String get confirmWithdrawal;

  /// Withdrawal password confirmation description
  ///
  /// In en, this message translates to:
  /// **'Enter your password to confirm this withdrawal request.'**
  String get confirmWithdrawalDescription;

  /// Current password field label
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get currentPassword;

  /// Notifications screen title
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsTitle;

  /// Mark all notifications as read action
  ///
  /// In en, this message translates to:
  /// **'Mark all'**
  String get notificationsMarkAll;

  /// Bottom sheet title for notification actions
  ///
  /// In en, this message translates to:
  /// **'Notification Options'**
  String get notificationsOptionsTitle;

  /// Delete notification action
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get notificationsDelete;

  /// Cancel notification action
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get notificationsCancel;

  /// Empty state text on notifications screen
  ///
  /// In en, this message translates to:
  /// **'No notifications yet'**
  String get notificationsEmpty;

  /// Relative time label for notifications created moments ago
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get notificationsJustNow;

  /// Relative time label for notifications created minutes ago
  ///
  /// In en, this message translates to:
  /// **'{count} min ago'**
  String notificationsMinutesAgo(int count);

  /// Relative time label for notifications created hours ago
  ///
  /// In en, this message translates to:
  /// **'{count} hr ago'**
  String notificationsHoursAgo(int count);

  /// Relative time label for notifications created days ago
  ///
  /// In en, this message translates to:
  /// **'{count} day(s) ago'**
  String notificationsDaysAgo(int count);

  /// Lot auction creation screen title
  ///
  /// In en, this message translates to:
  /// **'Lot Auction'**
  String get auctionLotAuctionTitle;

  /// Item auction creation screen title
  ///
  /// In en, this message translates to:
  /// **'Item Auction'**
  String get auctionItemAuctionTitle;

  /// Auction image picker label before selecting an image
  ///
  /// In en, this message translates to:
  /// **'Head Image +'**
  String get auctionHeadImage;

  /// Auction file selected label
  ///
  /// In en, this message translates to:
  /// **'Selected: {name}'**
  String auctionSelectedFile(Object name);

  /// Hint shown while auction categories are loading
  ///
  /// In en, this message translates to:
  /// **'Loading categories...'**
  String get auctionLoadingCategories;

  /// Hint telling the seller to choose a category for each lot item
  ///
  /// In en, this message translates to:
  /// **'Select a category for each item below.'**
  String get auctionSelectCategoryPerItem;

  /// Auction save and continue button label
  ///
  /// In en, this message translates to:
  /// **'Save & Continue'**
  String get auctionSaveContinue;

  /// Remove item action in auction forms
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get auctionRemove;

  /// Auction item image picker label before selecting images
  ///
  /// In en, this message translates to:
  /// **'Add Images +'**
  String get auctionAddImages;

  /// Auction selected images count label
  ///
  /// In en, this message translates to:
  /// **'{count} image(s) selected'**
  String auctionSelectedImagesCount(int count);

  /// Auction attributes section title
  ///
  /// In en, this message translates to:
  /// **'Attributes'**
  String get auctionAttributes;

  /// Auction category dropdown empty hint
  ///
  /// In en, this message translates to:
  /// **'No categories found'**
  String get auctionNoCategoriesFound;

  /// Auction category dropdown hint
  ///
  /// In en, this message translates to:
  /// **'Select category'**
  String get auctionSelectCategoryHint;

  /// Auction attribute dropdown hint
  ///
  /// In en, this message translates to:
  /// **'Select value'**
  String get auctionSelectValue;

  /// Boolean true option in auction attribute dropdown
  ///
  /// In en, this message translates to:
  /// **'True'**
  String get auctionTrue;

  /// Boolean false option in auction attribute dropdown
  ///
  /// In en, this message translates to:
  /// **'False'**
  String get auctionFalse;

  /// Auction date selection label
  ///
  /// In en, this message translates to:
  /// **'Select date'**
  String get auctionSelectDate;

  /// Auction date and time selection label
  ///
  /// In en, this message translates to:
  /// **'Select date & time'**
  String get auctionSelectDateTime;

  /// Validation when lot title is empty
  ///
  /// In en, this message translates to:
  /// **'Please enter the lot title.'**
  String get auctionEnterLotTitle;

  /// Validation when lot description is empty
  ///
  /// In en, this message translates to:
  /// **'Please enter the lot description.'**
  String get auctionEnterLotDescription;

  /// Validation when a lot item title is empty
  ///
  /// In en, this message translates to:
  /// **'Please enter a title for item {index}.'**
  String auctionEnterItemTitle(int index);

  /// Validation when a lot item count is empty
  ///
  /// In en, this message translates to:
  /// **'Please enter a count for item {index}.'**
  String auctionEnterItemCount(int index);

  /// Validation when a lot item count is invalid
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid count for item {index}.'**
  String auctionEnterValidItemCount(int index);

  /// Validation when a lot item description is empty
  ///
  /// In en, this message translates to:
  /// **'Please enter a description for item {index}.'**
  String auctionEnterItemDescription(int index);

  /// Validation when a lot item warranty info is empty
  ///
  /// In en, this message translates to:
  /// **'Please enter warranty info for item {index}.'**
  String auctionEnterItemWarrantyInfo(int index);

  /// Validation when a lot item category is missing
  ///
  /// In en, this message translates to:
  /// **'Please select a category for item {index}.'**
  String auctionSelectItemCategory(int index);

  /// Validation when lot item attributes could not be loaded
  ///
  /// In en, this message translates to:
  /// **'Could not load attributes for item {index}. Please retry or choose another category.'**
  String auctionItemAttributesLoadError(int index);

  /// Validation when a numeric lot item attribute is invalid
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid number for {attribute} in item {index}.'**
  String auctionInvalidNumberForItemAttribute(Object attribute, int index);

  /// Validation when a required lot item attribute is missing
  ///
  /// In en, this message translates to:
  /// **'Please provide {attribute} for item {index}.'**
  String auctionProvideItemAttribute(Object attribute, int index);

  /// Error shown when item category attributes fail to load
  ///
  /// In en, this message translates to:
  /// **'Could not load category attributes for this item. Try another category or retry later.'**
  String get auctionLoadCategoryAttributesForItemError;

  /// Validation when single item auction title is empty
  ///
  /// In en, this message translates to:
  /// **'Please enter the item title.'**
  String get auctionEnterItemTitleSingle;

  /// Validation when auction category is missing
  ///
  /// In en, this message translates to:
  /// **'Please select a category.'**
  String get auctionSelectCategoryError;

  /// Validation when warranty info is empty
  ///
  /// In en, this message translates to:
  /// **'Please enter warranty info.'**
  String get auctionEnterWarrantyInfoError;

  /// Validation when description is empty
  ///
  /// In en, this message translates to:
  /// **'Please enter the description.'**
  String get auctionEnterDescriptionError;

  /// Validation when auction count is invalid
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid count.'**
  String get auctionEnterValidCountError;

  /// Validation when category attributes could not be loaded
  ///
  /// In en, this message translates to:
  /// **'Could not load category attributes. Try another category.'**
  String get auctionLoadCategoryAttributesError;

  /// Validation when a numeric auction attribute is invalid
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid number for {attribute}.'**
  String auctionInvalidNumberForAttribute(Object attribute);

  /// Validation when a required auction attribute is missing
  ///
  /// In en, this message translates to:
  /// **'Please provide {attribute}.'**
  String auctionProvideAttribute(Object attribute);

  /// Error shown when category attributes fail to load for the single item auction form
  ///
  /// In en, this message translates to:
  /// **'Could not load category attributes for this item.'**
  String get auctionLoadCategoryAttributesForThisItemError;

  /// Shown when email is missing before starting withdrawal verification
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t find your account email. Please refresh your profile and try again.'**
  String get withdrawalEmailMissing;
}

class _SDelegate extends LocalizationsDelegate<S> {
  const _SDelegate();

  @override
  Future<S> load(Locale locale) {
    return SynchronousFuture<S>(lookupS(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_SDelegate old) => false;
}

S lookupS(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return SAr();
    case 'en': return SEn();
  }

  throw FlutterError(
    'S.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
