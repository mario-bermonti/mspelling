import 'package:get/route_manager.dart';
import 'package:mspelling/views/begin_view.dart';
import 'package:mspelling/views/end_view.dart';
import 'package:mspelling/views/loading_view.dart';
import 'package:mspelling/views/login_view.dart';
import 'package:mspelling/views/rest_view.dart';
import 'package:mspelling/views/setup_view.dart';
import 'package:mspelling/views/trial_response_view.dart';
import 'package:mspelling/views/trial_stim_view.dart';
import 'package:mspelling/views/workspace_view.dart';

List<GetPage> routes = <GetPage>[
  GetPage(name: '/setup', page: () => SetupView()),
  GetPage(name: '/workspace', page: () => WorkspaceView()),
  GetPage(name: '/login', page: () => LoginView()),
  GetPage(name: '/begin', page: () => const BeginView()),
  GetPage(name: '/trialstim', page: () => TrialStimView()),
  GetPage(name: '/trialresponse', page: () => TrialResponseView()),
  GetPage(name: '/rest', page: () => RestView()),
  GetPage(name: '/end', page: () => const EndView()),
  GetPage(name: '/loading', page: () => const LoadingView()),
];
