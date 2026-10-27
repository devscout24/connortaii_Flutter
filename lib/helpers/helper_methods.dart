// ignore_for_file: use_build_context_synchronously, unused_local_variable, avoid_print
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/common_widget/exit_button.dart';
import 'package:connortaii_app/helpers/toast.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../constants/app_constants.dart';
import '../constants/text_font_style.dart';
import '../provider/provides.dart';
import 'di.dart';
// import 'package:google_sign_in/google_sign_in.dart';

//final appData = locator.get<GetStorage>();
final plcaeMarkAddress = locator.get<PlcaeMarkAddress>();
//declared for cart scrren calling bottom shit with this from reorder rx
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
final GlobalKey<PopupMenuButtonState<String>> popUpGlobalkey =
    GlobalKey<PopupMenuButtonState<String>>();

enum StatusType { order, delivery }

Color statuscolor(StatusType status, String statusCode) {
  late Color stcolor;
  if (StatusType.order == status) {
    switch (statusCode) {
      case OrderStatusNo.kPENDING:
        stcolor = OrderStatusColor.kPENDING;
        break;
      case OrderStatusNo.kACCEPTED:
        stcolor = OrderStatusColor.kACCEPTED;
        break;
      case OrderStatusNo.kFOODPROCESSING:
        stcolor = OrderStatusColor.kFOODPROCESSING;
        break;
      case OrderStatusNo.kFOODREADY:
        stcolor = OrderStatusColor.kFOODREADY;
        break;
      case OrderStatusNo.kFOODPICKED:
        stcolor = OrderStatusColor.kFOODPICKED;
        break;
      case OrderStatusNo.kFOODDELIVERED:
        stcolor = OrderStatusColor.kFOODDELIVERED;
        break;
      case OrderStatusNo.kCANCELLED:
        stcolor = OrderStatusColor.kCANCELLED;
        break;
      case OrderStatusNo.kREJECTEDBYSHOP:
        stcolor = OrderStatusColor.kREJECTEDBYSHOP;
        break;
      case OrderStatusNo.kFAILED:
        stcolor = OrderStatusColor.kFAILED;
        break;
    }
  }
  if (StatusType.delivery == status) {
    switch (statusCode) {
      case DeliveryStatusNo.kPENDIG:
        stcolor = DeliveryStatusColor.kPENDING;
        break;
      case DeliveryStatusNo.kONTRANSIT:
        stcolor = DeliveryStatusColor.kONTRANSIT;
        break;
      case DeliveryStatusNo.kARRIVEDATSHOP:
        stcolor = DeliveryStatusColor.kARRIVEDATSHOP;
        break;
      case DeliveryStatusNo.kDELIVERYMANCONFIRMED:
        stcolor = DeliveryStatusColor.kDELIVERYMANCONFIRMED;
        break;
      case DeliveryStatusNo.kDELIVERYSTARTED:
        stcolor = DeliveryStatusColor.kDELIVERYSTARTED;
        break;
      case DeliveryStatusNo.kDELIVERED:
        stcolor = DeliveryStatusColor.kDELIVERED;
        break;
    }
  }

  return stcolor;
}

String language(String languageKey) {
  late String language;

  switch (languageKey) {
    case kKeyEnglish:
      language = "English";
      break;
    case kKeyFrench:
      language = "French";
      break;
    case kKeyGerman:
      language = "Dutch";
      break;
    case kKeyRussian:
      language = "Russian";
      break;
    case kKeyPortuguese:
      language = "Portuguese";
      break;
    case kKeySpanish:
      language = "Spanish";
      break;
    default:
      language = "Portuguese";
  }
  return language;
}

Future<String?> networkImageToBase64(String imageUrl) async {
  http.Response response = await http.get(Uri.parse(imageUrl));
  final bytes = response.bodyBytes;

  // ignore: unnecessary_null_comparison, dead_code
  return (bytes != null ? base64Encode(bytes) : null);
}

Future<void> setInitValue() async {
  Map<String, dynamic> arabicDefault = {};
  await appData.writeIfNull(kKeyIsLoggedIn, false);
  await appData.writeIfNull(kKeyIsExploring, false);
  await appData.writeIfNull(kKeyIsFirstTime, true);
  appData.writeIfNull(kKeyLanguage, kKeyEnglish);
  appData.writeIfNull(kKeyCountryCode, countriesCode[kKeyEnglish]);
  appData.writeIfNull(kKeySelectedLocation, false);
  appData.writeIfNull(kKeyQuranArabic, arabicDefault);
  appData.writeIfNull(kKeyQuranTranslation, arabicDefault);
  appData.writeIfNull(kKeyQuranAudio, arabicDefault);
  appData.writeIfNull(kKeyQuranAudio, arabicDefault);
  appData.writeIfNull(kKeyScheduledPrayers, []);
  //lisbon
  // appData.writeIfNull(kKeySelectedLat, 38.74631383626653);
  // appData.writeIfNull(kKeySelectedLng, -9.130169921874991);
  //codemen
  await appData.writeIfNull(kKeySelectedLat, 22.818285677915657);
  await appData.writeIfNull(kKeySelectedLng, 89.5535583794117);

  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    var iosDeviceInfo = await deviceInfo.iosInfo;
    appData.writeIfNull(
      kKeyDeviceID,
      iosDeviceInfo.identifierForVendor,
    ); // unique ID on iOS
  } else if (Platform.isAndroid) {
    var androidDeviceInfo =
        await deviceInfo.androidInfo; // unique ID on Android
    appData.writeIfNull(kKeyDeviceID, androidDeviceInfo.id);
  }
  await Future.delayed(const Duration(seconds: 2));
}

String extractAndConvertAmPm(String time) {
  // Use a regular expression to find AM or PM
  final match = RegExp(r'(AM|PM)').firstMatch(time);

  // If a match is found, convert to lowercase and return; otherwise, return an empty string
  return match != null ? match.group(0)!.toLowerCase() : '';
}

String removeAmPm(String time) {
  // Use a regular expression to replace AM or PM with an empty string
  return time
      .replaceAll(RegExp(r'\s*(AM|PM)', caseSensitive: false), '')
      .trim();
}
//
// Future<Position> getCurrentPosition() async {
//   try {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     // Check if location services are enabled
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       throw 'Location services are disabled.';
//     }
//
//     // Check location permissions
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         throw 'Location permissions are denied.';
//       }
//     } else if (permission == LocationPermission.deniedForever) {
//       throw 'Location permissions are permanently denied.';
//     }
//
//     // Get current position
//     return await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     );
//   } catch (e) {
//     log("Error: $e");
//     throw e.toString();
//   }
// }
//
// Future<Placemark> getCityAndCountry(Position position) async {
//   try {
//     List<Placemark> placemarks = await placemarkFromCoordinates(
//       position.latitude,
//       position.longitude,
//     );
//
//     Placemark? place = placemarks.isNotEmpty ? placemarks[0] : null;
//     if (place != null) {
//       return place;
//     } else {
//       throw 'Unable to get the location.';
//     }
//   } catch (e) {
//     log("Error: $e");
//     throw e.toString();
//   }
// }

Future<void> initiInternetChecker() async {
  bool isInitial = true;
  InternetConnectionStatus? lastStatus;

  InternetConnectionChecker.createInstance(
    checkTimeout: const Duration(seconds: 4),
    checkInterval: const Duration(seconds: 15),
    addresses: [
      AddressCheckOption(
        uri: Uri.parse('https://one.one.one.one'),
      ),
      AddressCheckOption(
        uri: Uri.parse('https://www.google.com'),
      ),
      AddressCheckOption(
        uri: Uri.parse('https://connortaii.thewarriors.team'),
      ),
    ],
  ).onStatusChange.listen((status) {
    if (isInitial) {
      isInitial = false;
      lastStatus = status;
      // Only show error on initial launch if genuinely disconnected
      if (status == InternetConnectionStatus.disconnected) {
        ToastUtil.showNoInternetToast();
      }
      return;
    }

    // Only toast on actual status transitions
    if (status != lastStatus) {
      lastStatus = status;
      switch (status) {
        case InternetConnectionStatus.connected:
          ToastUtil.showShortToast('Data connection is available.'.tr);
          break;
        case InternetConnectionStatus.disconnected:
          ToastUtil.showNoInternetToast();
          break;
        case InternetConnectionStatus.slow:
          break;
      }
    }
  });
}

Completer<T> wrapInCompleter<T>(Future<T> future) {
  final completer = Completer<T>();
  future.then(completer.complete).catchError(completer.completeError);
  return completer;
}

Future<void> getInvisible() async {
  Future.delayed(const Duration(milliseconds: 500), () {});
}

// GoogleSignIn googleSignIn = GoogleSignIn(scopes: []);

void loginWithSocialMedia(String driver) async {
  String userId, name, email;

  // try {
  // if (driver == kGoogle) {
  //    googleSignIn.signOut();
  // final GoogleSignInAccount? googleAccount = await googleSignIn.signIn();

  // if (googleAccount != null) {
  //   userId = googleAccount.id;
  //   name = googleAccount.displayName!;
  //   email = googleAccount.email;
  // }
  // } else if (driver == kFacebook) {
  // FacebookLoginResult loginResult = await facebookLogin.logIn(['email']);
  // switch (loginResult.status) {
  //   case FacebookLoginStatus.cancelledByUser:
  //     return;

  //   case FacebookLoginStatus.error:
  //     throw Exception(loginResult.errorMessage);
  //     break;

  //   case FacebookLoginStatus.loggedIn:
  //     final token = loginResult.accessToken.token;
  //     final graphResponse = await http.get(
  //       Uri.parse(
  //           'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=$token'),
  //     );
  //     final profile = json.decode(graphResponse.body);

  //     if (profile != null) {
  //       userId = profile['id'];
  //       name = profile['name'];
  //       email = profile['email'];
  //     }
  //     break;

  //   default:
  //     break;
  // }
  // } else if (driver == kApple) {
  // final credential = await SignInWithApple.getAppleIDCredential(
  //   scopes: [
  //     AppleIDAuthorizationScopes.email,
  //     AppleIDAuthorizationScopes.fullName,
  //   ],
  // );
  // print(credential);

  // if (credential.userIdentifier != null) {
  // await postSocailLoginRXObj.postSocailLogin(
  //     socialAuthId: credential.userIdentifier!,
  //     email: credential.email,
  //     firstName: credential.givenName,
  //     lastName: credential.familyName,
  //     registerType: "4");
}
// }
// } catch (e) {
// ToastUtil.showLongToast(e.toString());
// }
// }

Future<File> getLocalFile(String filename) async {
  File f = File(filename);
  return f;
}

void showMaterialDialog(BuildContext context) {
  showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        "Do you want to exit the app?",
        textAlign: TextAlign.center,
        style: TextFontStyle.headlinePoppins60016,
      ),
      actions: <Widget>[
        ExitButton(
          name: "No".tr,
          onCallBack: () {
            Navigator.of(context).pop(false);
          },
          height: 50.sp,
          minWidth: .3.sw,
          borderRadius: 30.r,
          color: AppColors.grey300,
          textStyle: GoogleFonts.montserrat(
            fontSize: 17.sp,
            color: AppColors.c000000,
            fontWeight: FontWeight.w700,
          ),
          context: context,
        ),
        ExitButton(
          name: "Yes".tr,
          onCallBack: () {
            if (Platform.isAndroid) {
              SystemNavigator.pop();
            } else if (Platform.isIOS) {
              exit(0);
            }
          },
          height: 50.sp,
          minWidth: .3.sw,
          borderRadius: 30.r,
          color: AppColors.c000000,
          textStyle: GoogleFonts.montserrat(
            fontSize: 17.sp,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
          context: context,
        ),
      ],
    ),
  );
}

void rotation() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

String formatDate(String inputDate) {
  // Parse the input date string into a DateTime object
  DateTime dateTime = DateTime.parse(inputDate);

  // Format the DateTime object into the desired output format
  String formattedDate = DateFormat(' d MMM y').format(dateTime);

  return formattedDate;
}

String formatDate2(String inputDate) {
  // Parse the input date string into a DateTime object
  DateTime dateTime = DateTime.parse(inputDate);

  // Format the DateTime object into the desired output format
  String formattedDate = DateFormat(' d/MM/yyyy').format(dateTime);

  return formattedDate;
}

// List<Map<int, List<Ayah>>> extractJuzData(QuranReponseModel quranResponse) {
//   // This map will group ayahs by their Juz number
//   Map<int, List<Ayah>> juzMap = {};

//   // Iterate over all surahs and their ayahs
//   for (var surah in quranResponse.data!.surahs!) {
//     for (var ayah in surah.ayahs!) {
//       // If the Juz number doesn't exist in the map, create a new entry
//       if (!juzMap.containsKey(ayah.juz)) {
//         juzMap[ayah.juz!] = [];
//       }
//       // Add the ayah to the correct Juz group
//       juzMap[ayah.juz!]!.add(ayah);
//     }
//   }

//   // Convert the map to a list of Juz entries for easy access
//   List<Map<int, List<Ayah>>> juzList = [];
//   juzMap.forEach((juzNumber, ayahs) {
//     juzList.add({juzNumber: ayahs});
//   });

//   return juzList;
// }

Future<bool> isAndroid13OrHigher() async {
  final deviceInfo = DeviceInfoPlugin();
  final androidInfo = await deviceInfo.androidInfo;
  final version = androidInfo.version.sdkInt;
  return version >= 33; // Android 13 corresponds to SDK version 33
}

Future<void> requestScheduleExactAlarmPermission() async {
  await Permission.scheduleExactAlarm.request();
}

String convertTimeFormat(String input) {
  // Split the input string to get the time part
  List<String> parts = input.split(' ');
  String timePart = parts[0]; // "04:37"

  // Parse the time string into a DateTime object
  DateTime dateTime = DateFormat("HH:mm").parse(timePart);

  // Format the DateTime object to display as "hh:mm a"
  String formattedTime = DateFormat("hh:mm a").format(dateTime);

  return formattedTime; // "04:37 AM"
}

String getDayName(String input) {
  // Parse the input string to a DateTime object
  DateTime dateTime = DateFormat("dd-MM-yyyy").parse(input);

  // Format the DateTime object to display the full day name
  String dayName = DateFormat('EEEE').format(dateTime);

  return dayName; // e.g., "Sunday"
}

void showPickImageBottomSheet(
  BuildContext context,
  ValueNotifier<XFile?> imageFileNotifier, {
  bool showCameraOption = true,
}) {
  final textTheme = Theme.of(
    context,
  ).textTheme.apply(displayColor: Theme.of(context).colorScheme.onSurface);

  showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      title: TextStyleExample(
        name: 'Choose Image',
        style: textTheme.headlineSmall!.copyWith(
          color: Theme.of(context).colorScheme.primary,
          letterSpacing: 0.1,
        ),
      ),
      message: TextStyleExample(
        name: "Choose an image from your camera or existing gallery.",
        style: textTheme.bodyMedium!.copyWith(letterSpacing: 0.1),
      ),
      actions: <Widget>[
        // List of actions
        showCameraOption
            ? CupertinoActionSheetAction(
                child: TextStyleExample(
                  name: 'Camera',
                  style: textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                onPressed: () {
                  selectImageFromCamera(context, imageFileNotifier);
                },
              )
            : const SizedBox.shrink(),
        CupertinoActionSheetAction(
          child: TextStyleExample(
            name: 'Gallery',
            style: textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          onPressed: () {
            selectImageFromGallery(context, imageFileNotifier);
          },
        ),
      ],
      // A cancel button at the bottom of the modal popup
      cancelButton: CupertinoActionSheetAction(
        child: TextStyleExample(
          name: 'Close',
          style: textTheme.titleLarge!.copyWith(
            color: Colors.grey,
            letterSpacing: 0.1,
          ),
        ),
        onPressed: () {
          Navigator.pop(context); // Close the modal popup
        },
      ),
    ),
  );
}

Future<void> selectImageFromCamera(
  BuildContext context,
  ValueNotifier<XFile?> imageFileNotifier,
) async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.camera);
  if (pickedFile != null) {
    imageFileNotifier.value = pickedFile;
  }
  // Collapse the modal popup menu for hiding bottom sheet
  if (context.mounted) {
    Navigator.pop(context);
  }
}

Future<void> selectImageFromGallery(
  BuildContext context,
  ValueNotifier<XFile?> imageFileNotifier,
) async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    imageFileNotifier.value = pickedFile;
    // Collapse the modal popup menu for hiding bottom sheet
    if (context.mounted) {
      Navigator.pop(context);
    }
  }
}

class TextStyleExample extends StatelessWidget {
  const TextStyleExample({super.key, required this.name, required this.style});

  final String name;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(1.sp),
      child: Text(name, style: style.copyWith(letterSpacing: 1.0)),
    );
  }
}

String hideEmail(String email) {
  // Split the email into username and domain parts
  final parts = email.split('@');
  if (parts.length != 2) {
    throw const FormatException("Invalid email format");
  }
  final username = parts[0];
  final domain = parts[1];

  // Ensure at least the first two characters of the username are visible
  final visiblePart = username.length > 2 ? username.substring(0, 2) : username;

  // Replace the rest of the username with asterisks
  final hiddenPart = '*' * (username.length - visiblePart.length);

  // Return the obfuscated email
  return '$visiblePart$hiddenPart@$domain';
}

class RadioButtonList extends StatefulWidget {
  final void Function(String selectedOption) onOptionSelected;

  const RadioButtonList({super.key, required this.onOptionSelected});

  @override
  // ignore: library_private_types_in_public_api
  _RadioButtonListState createState() => _RadioButtonListState();
}

class _RadioButtonListState extends State<RadioButtonList> {
  String? _selectedOption;
  final List<String> _options = [
    'Any',
    "Today",
    "Tomorrow",
    "This week",
    "This month",
    "This year",
  ];

  @override
  void initState() {
    super.initState();
    _selectedOption = _options.first; // By default, select the first item
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _options.map((option) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedOption = option;
            });
            widget.onOptionSelected(option);
          },
          child: SizedBox(
            height: 30.h,
            child: Row(
              children: [
                Radio<String>(
                  value: option,
                  groupValue: _selectedOption,

                  onChanged: (String? value) {
                    setState(() {
                      _selectedOption = value;
                    });
                    if (value != null) {
                      widget.onOptionSelected(value);
                    }
                  },
                  activeColor: AppColors
                      .cFF7A22, // Set the color of the selected radio button
                ),
                SizedBox(width: 8.w),
                Text(
                  option,
                  style: TextFontStyle.headlinePoppins50014.copyWith(
                    fontSize: 14.sp,
                    color: _selectedOption == option
                        ? AppColors.cFF7A22
                        : Colors.black, // Change color for selected item
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

// class CheckBoxListWidget extends StatefulWidget {
//   final Function(List<String>) onSelectionChanged;

//   CheckBoxListWidget({required this.onSelectionChanged});

//   @override
//   _CheckBoxListWidgetState createState() => _CheckBoxListWidgetState();
// }

// class _CheckBoxListWidgetState extends State<CheckBoxListWidget> {
//   final List<String> items = ["All Type", "8 Ball", "9 Ball", "10 Ball", "Other Ball"];
//   Map<String, bool> checkedItems = {
//     "All Type": false,
//     "8 Ball": false,
//     "9 Ball": false,
//     "10 Ball": false,
//     "Other Ball": false,
//   };

//   void _onItemCheck(String item) {
//     setState(() {
//       if (item == "All Type") {
//         // If "All Type" is selected, uncheck all other items
//         checkedItems.keys.forEach((key) {
//           checkedItems[key] = (key == "All Type");
//         });
//       } else {
//         // If any other item is selected, uncheck "All Type"
//         checkedItems["All Type"] = false;
//         checkedItems[item] = !checkedItems[item]!;
//       }
//     });

//     // Notify parent widget of the updated selection
//     widget.onSelectionChanged(
//       checkedItems.entries
//           .where((entry) => entry.value)
//           .map((entry) => entry.key)
//           .toList(),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: items.map((item) {
//         return SizedBox(
//           height: 30.h,
//           child: Row(
//             children: [
//               Checkbox(
//                 value: checkedItems[item],
//                 onChanged: (value) => _onItemCheck(item),
//               ),
//               Text(item,
//               style: TextFontStyle.text14c011510OutfitRegular.copyWith(
//                     fontSize: 14.sp,
//                     color: Colors.black, // Change color for selected item
//                   ),
//               ),
//             ],
//           ),
//         );
//       }).toList(),
//     );
//   }
// }

class CheckBoxListWidget extends StatefulWidget {
  final Function(List<String>) onSelectionChanged;

  const CheckBoxListWidget({super.key, required this.onSelectionChanged});

  @override
  _CheckBoxListWidgetState createState() => _CheckBoxListWidgetState();
}

class _CheckBoxListWidgetState extends State<CheckBoxListWidget> {
  final List<String> items = [
    "All Type",
    "8 Ball",
    "9 Ball",
    "10 Ball",
    "Others",
  ];
  Map<String, bool> checkedItems = {
    "All Type": false,
    "8 Ball": false,
    "9 Ball": false,
    "10 Ball": false,
    "Others": false,
  };

  void _onItemCheck(String item) {
    setState(() {
      if (item == "All Type") {
        // If "All Type" is selected, uncheck all other items
        for (var key in checkedItems.keys) {
          checkedItems[key] = (key == "All Type");
        }
      } else {
        // If any other item is selected, uncheck "All Type"
        checkedItems["All Type"] = false;
        checkedItems[item] = !checkedItems[item]!;
      }
    });

    // Notify parent widget of the updated selection
    widget.onSelectionChanged(
      checkedItems.entries
          .where((entry) => entry.value)
          .map((entry) => entry.key)
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.map((item) {
        final isChecked = checkedItems[item] ?? false;

        return SizedBox(
          height: 30.h,
          child: Row(
            children: [
              Checkbox(
                value: isChecked,
                onChanged: (value) => _onItemCheck(item),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5), // Rounded corners
                ),
                activeColor: AppColors.cFF7A22, // Checkbox color when selected
                checkColor: Colors.white, // Checkmark color
              ),
              Text(
                item,
                style: TextFontStyle.headlinePoppins50014.copyWith(
                  fontSize: 14.sp,
                  color: isChecked
                      ? AppColors.cFF7A22
                      : Colors.black, // Match text color with checkbox
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

String formatTime(String inputDateTime) {
  // Parse the input string into a DateTime object
  DateTime dateTime = DateTime.parse(inputDateTime);

  // Format the DateTime to the desired format using DateFormat from the intl package
  String formattedTime = DateFormat('h:mm a').format(dateTime);

  return formattedTime;
}
