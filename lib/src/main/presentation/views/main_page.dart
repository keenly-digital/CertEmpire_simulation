import 'package:certempiree/src/my_reward/presentation/views/my_reward_main_view.dart';
import 'package:certempiree/src/my_tasks/presentation/views/my_task_main_veiw.dart';
import 'package:certempiree/src/report_history/presentation/views/report_main_view.dart';
import 'package:certempiree/src/simulation/presentation/views/download_main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/shared/widgets/footer.dart';
import '../../../../core/shared/widgets/header.dart';
import '../../../../core/utils/breakpoints_config.dart';
import '../../../account_details/presentation/views/update_account_view.dart';
import '../../../addresses/presentation/views/addresses_main_view.dart';
import '../../../addresses/presentation/views/update_billing_address.dart';
import '../../../order/presentation/views/order_main_view.dart';
import '../../../simulation/presentation/views/simulation_main_view.dart';
import '../../../submittions/views/submittion_main_view.dart';
import '../bloc/navigation_cubit.dart';
import '../widgets/left_navigation_view.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Place header at the top
            header(),

            // Main content with optional sidebar
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Row(
                children: [
                  if (!BreakpointConfig().isMobile)
                  Expanded(
                    flex: 1,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: LeftNavigationView(),
                      ),
                    ),
                  ),
                  // Main view content
                  Expanded(
                    flex: 4,
                    child: BlocConsumer<NavigationCubit, NavigationCubitState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        switch (state.index) {
                          case 0:
                            return ExamQuestionPage();
                          case 1:
                            return OrderMainView();
                          case 2:
                            return DownloadMainView();
                          case 3:
                            return MyTaskMainView();
                          case 4:
                            return ReportMainView();
                          case 5:
                            return MyRewardMainView();
                          case 6:
                            return AddressView();
                          case 7:
                            return SubmittionMainView();
                          case 8:
                            return UpdateAccount();
                            case 9:
                            return UpdateBillingAddress();
                          default:
                            return const Center(child: Text("Unknown Page"));
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Footer shown below the main content
            const Footer(),
          ],
        ),
      ),
    );
  }

  Widget content(Widget widget) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child:
      widget,
    );
  }
}
