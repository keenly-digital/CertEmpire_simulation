import 'package:certempiree/src/logout/logout_main_view.dart';
import 'package:certempiree/src/my_reward/presentation/views/my_reward_main_view.dart';
import 'package:certempiree/src/my_tasks/presentation/views/my_task_main_veiw.dart';
import 'package:certempiree/src/order/presentation/views/order_main_view.dart';
import 'package:certempiree/src/report_history/presentation/views/report_main_view.dart';
import 'package:certempiree/src/simulation/presentation/views/download_main_view.dart';
import 'package:certempiree/src/simulation/presentation/views/simulation_main_view.dart';
import 'package:certempiree/src/submittions/views/submittion_main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/shared/widgets/footer.dart';
import '../../../../core/shared/widgets/header.dart';
import '../../../account_details/presentation/views/update_account_view.dart';
import '../../../addresses/presentation/views/addresses_main_view.dart';
import '../../../addresses/presentation/views/update_billing_address.dart';
import '../../../addresses/presentation/views/update_shipping_address.dart';
import '../../../dashboard/presentation/views/dashboard_main_view.dart';
import '../../../order/presentation/views/order_detail_view.dart';
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
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          header(),
          // The Expanded here ensures the Row fills the viewport.
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Sticky Left Nav: Fixed width, not scrollable
                Container(
                  width: 230, // You can adjust width as needed
                  margin: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 20,
                      ),
                      child: LeftNavigationView(),
                    ),
                  ),
                ),
                // Main content: Only this part scrolls
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Your content, switched by navigation
                        BlocConsumer<NavigationCubit, NavigationCubitState>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            switch (state.index) {
                              case 0:
                                return content(const UserMainView(), top: 24.0);
                              case 1:
                                if (state.subTitleIndex == 0) {
                                  return content(OrderMainView(), top: 24.0);
                                } else if (state.subTitleIndex == 1) {
                                  return content(OrderDetailView(), top: 24.0);
                                } else {
                                  return const Center(
                                    child: Text("Unknown Order Page"),
                                  );
                                }
                              case 2:
                                if (state.subTitleIndex == 0) {
                                  return content(
                                    const DownloadMainView(),
                                    top: 24.0,
                                  );
                                } else if (state.subTitleIndex == 1) {
                                  return content(
                                    const ExamQuestionPage(),
                                    top: 1.0,
                                  );
                                } else {
                                  return const Center(
                                    child: Text("Unknown Address Page"),
                                  );
                                }
                              case 3:
                                return content(
                                  const MyTaskMainView(),
                                  top: 24.0,
                                );
                              case 4:
                                return content(ReportMainView(), top: 24.0);
                              case 5:
                                return content(
                                  const MyRewardMainView(),
                                  top: 24.0,
                                );
                              case 6:
                                return content(
                                  const SubmittionMainView(),
                                  top: 24.0,
                                );
                              case 7:
                                if (state.subTitleIndex == 0) {
                                  return content(
                                    const AddressView(),
                                    top: 24.0,
                                  );
                                } else if (state.subTitleIndex == 1) {
                                  return content(
                                    UpdateBillingAddress(),
                                    top: 24.0,
                                  );
                                } else if (state.subTitleIndex == 2) {
                                  return content(
                                    UpdateShippingAddress(),
                                    top: 23.0,
                                  );
                                } else {
                                  return const Center(
                                    child: Text("Unknown Address Page"),
                                  );
                                }
                              case 8:
                                return content(UpdateAccount(), top: 24.0);
                              case 9:
                                return content(LogoutMainView(), top: 24.0);
                            }
                            return const Center(child: Text("Unknown Page"));
                          },
                        ),
                        // Add space before the footer for breathing room
                        const SizedBox(height: 100),
                        const Footer(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper for consistent content padding
  Widget content(Widget widget, {double top = 24.0, double horizontal = 24.0}) {
    return Padding(
      padding: EdgeInsets.only(top: top, left: horizontal, right: horizontal),
      child: widget,
    );
  }
}
