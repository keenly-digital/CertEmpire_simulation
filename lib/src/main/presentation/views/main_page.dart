import 'package:certempiree/src/my_reward/presentation/views/my_reward_main_view.dart';
import 'package:certempiree/src/my_tasks/presentation/views/my_task_main_veiw.dart';
import 'package:certempiree/src/report_history/presentation/views/report_main_view.dart';
import 'package:certempiree/src/simulation/presentation/views/download_main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/shared/widgets/footer.dart';
import '../../../../core/shared/widgets/header.dart';
import '../../../account_details/presentation/views/update_account_view.dart';
import '../../../addresses/presentation/views/addresses_main_view.dart';
import '../../../addresses/presentation/views/update_billing_address.dart';
import '../../../dashboard/presentation/views/dashboard_main_view.dart';
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            header(),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Row(
                children: [
                  // if (!BreakpointConfig().isMobile)
                  Expanded(
                    flex: 1,
                    child: Card(
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
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
                            return content(UserMainView());
                          case 1:
                            return content(OrderMainView());
                          case 2:
                            if (state.subTitleIndex == 0) {
                              return content(DownloadMainView());
                            } else if (state.subTitleIndex == 1) {
                              return content(ExamQuestionPage());
                            } else {
                              return const Center(
                                child: Text("Unknown Address Page"),
                              );
                            }
                          case 3:
                            return content(MyTaskMainView());
                          case 4:
                            return content(ReportMainView());
                          case 5:
                            return content(MyRewardMainView());
                          case 6:
                            return content(SubmittionMainView());
                          case 7:
                            if (state.subTitleIndex == 0) {
                              return content(AddressView());
                            } else if (state.subTitleIndex == 1) {
                              return content(UpdateBillingAddress());
                            } else {
                              return const Center(
                                child: Text("Unknown Address Page"),
                              );
                            }
                          case 8:
                            return content(UpdateAccount());
                          default:
                            return const Center(child: Text("Unknown Page"));
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            const Footer(),
          ],
        ),
      ),
    );
  }

  Widget content(Widget widget) {
    return Padding(padding: const EdgeInsets.only(top: 80.0), child: widget);
  }
}
