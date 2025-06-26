import 'package:certempiree/core/shared/widgets/footer.dart';
import 'package:certempiree/core/shared/widgets/header.dart';
import 'package:certempiree/src/account_details/presentation/views/update_account_view.dart';
import 'package:certempiree/src/addresses/presentation/views/addresses_main_view.dart';
import 'package:certempiree/src/addresses/presentation/views/update_billing_address.dart';
import 'package:certempiree/src/dashboard/presentation/views/dashboard_main_view.dart';
import 'package:certempiree/src/main/presentation/bloc/navigation_cubit.dart';
import 'package:certempiree/src/main/presentation/widgets/left_navigation_view.dart';
import 'package:certempiree/src/my_reward/presentation/views/my_reward_main_view.dart';
import 'package:certempiree/src/my_tasks/presentation/views/my_task_main_veiw.dart';
import 'package:certempiree/src/order/presentation/views/order_main_view.dart';
import 'package:certempiree/src/report_history/presentation/views/report_main_view.dart';
import 'package:certempiree/src/simulation/presentation/views/download_main_view.dart';
import 'package:certempiree/src/simulation/presentation/views/simulation_main_view.dart';
import 'package:certempiree/src/submittions/views/submittion_main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                            return content(const UserMainView(), top: 70.0);
                          case 1:
                            return content(const OrderMainView(), top: 70.0);
                          case 2:
                            if (state.subTitleIndex == 0) {
                              return content(
                                const DownloadMainView(),
                                top: 70.0,
                              );
                            } else if (state.subTitleIndex == 1) {
                              return content(
                                const ExamQuestionPage(),
                                top: 20.0,
                              );
                            } else {
                              return const Center(
                                child: Text("Unknown Address Page"),
                              );
                            }
                          case 3:
                            return content(const MyTaskMainView(), top: 20.0);
                          case 4:
                            return content(ReportMainView(), top: 20.0);
                          case 5:
                            return content(const MyRewardMainView(), top: 20.0);
                          case 6:
                            return content(
                              const SubmittionMainView(),
                              top: 20.0,
                            );
                          case 7:
                            if (state.subTitleIndex == 0) {
                              return content(const AddressView(), top: 70.0);
                            } else if (state.subTitleIndex == 1) {
                              return content(
                                const UpdateBillingAddress(),
                                top: 70.0,
                              );
                            } else {
                              return const Center(
                                child: Text("Unknown Address Page"),
                              );
                            }
                          case 8:
                            return content(const UpdateAccount(), top: 70.0);
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

  Widget content(Widget widget, {double top = 50.0}) {
    return Padding(padding: EdgeInsets.only(top: top), child: widget);
  }
}
