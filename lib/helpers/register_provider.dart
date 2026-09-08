import 'package:provider/provider.dart';

import '../provider/auth_provider.dart';
import '../provider/support_provider.dart';
var providers = [
  ChangeNotifierProvider<AuthProvider>(
    create: ((context) => AuthProvider()),
  ),
  ChangeNotifierProvider<SupportProvider>(
    create: ((context) => SupportProvider()),
  ),
];
