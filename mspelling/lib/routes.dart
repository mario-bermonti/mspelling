import 'package:get/route_manager.dart';
import 'package:mspelling/activity/begin_view.dart';
import 'package:mspelling/end/end_view.dart';
import 'package:mspelling/login/login_view.dart';
import 'package:mspelling/rest/rest_view.dart';
import 'package:mspelling/setup/setup_view.dart';
import 'package:mspelling/activity/trial_response_view.dart';
import 'package:mspelling/activity/trial_stim_view.dart';
import 'package:mspelling/setup/workspace_view.dart';

List<GetPage> routes = <GetPage>[
  GetPage(name: '/setup', page: () => SetupView()),
  GetPage(name: '/workspace', page: () => WorkspaceView()),
  GetPage(name: '/login', page: () => LoginView()),
  GetPage(name: '/begin', page: () => const BeginView()),
  GetPage(name: '/trialstim', page: () => TrialStimView()),
  GetPage(name: '/trialresponse', page: () => TrialResponseView()),
  GetPage(name: '/rest', page: () => RestView()),
  GetPage(name: '/end', page: () => const EndView()),
];
