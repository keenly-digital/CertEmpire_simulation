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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 650;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,

      backgroundColor: Colors.grey[50],

      drawer:
          isMobile(context)
              ? Drawer(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,

                      horizontal: 10,
                    ),

                    child: LeftNavigationView(),
                  ),
                ),
              )
              : null,

      body: Column(
        children: [
          // Header with hamburger for mobile
          header(onMenu: () => _scaffoldKey.currentState?.openDrawer()),

          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,

              children: [
                // Desktop/tablet sidebar
                if (!isMobile(context))
                  Container(
                    width: 230,

                    margin: const EdgeInsets.only(
                      left: 16,

                      top: 16,

                      bottom: 16,
                    ),

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

                // Main content
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,

                      children: [
                        BlocConsumer<NavigationCubit, NavigationCubitState>(
                          listener: (context, state) {},

                          builder: (context, state) {
                            // Adjust content padding for mobile/desktop

                            double horizontalPad =
                                isMobile(context) ? 8.0 : 24.0;

                            double topPad = isMobile(context) ? 12.0 : 24.0;

                            double examPageTopPad =
                                isMobile(context) ? 2.0 : 1.0;

                            switch (state.index) {
                              case 0:
                                return content(
                                  const UserMainView(),

                                  top: topPad,

                                  horizontal: horizontalPad,
                                );

                              case 1:
                                if (state.subTitleIndex == 0) {
                                  return content(
                                    OrderMainView(),

                                    top: topPad,

                                    horizontal: horizontalPad,
                                  );
                                } else if (state.subTitleIndex == 1) {
                                  return content(
                                    OrderDetailView(),

                                    top: topPad,

                                    horizontal: horizontalPad,
                                  );
                                } else {
                                  return const Center(
                                    child: Text("Unknown Order Page"),
                                  );
                                }

                              case 2:
                                if (state.subTitleIndex == 0) {
                                  return content(
                                    const DownloadMainView(),

                                    top: topPad,

                                    horizontal: horizontalPad,
                                  );
                                } else if (state.subTitleIndex == 1) {
                                  return content(
                                    const ExamQuestionPage(),

                                    top: examPageTopPad,

                                    horizontal: horizontalPad,
                                  );
                                } else {
                                  return const Center(
                                    child: Text("Unknown Address Page"),
                                  );
                                }

                              case 3:
                                return content(
                                  const MyTaskMainView(),

                                  top: topPad,

                                  horizontal: horizontalPad,
                                );

                              case 4:
                                return content(
                                  ReportMainView(),

                                  top: topPad,

                                  horizontal: horizontalPad,
                                );

                              case 5:
                                return content(
                                  const MyRewardMainView(),

                                  top: topPad,

                                  horizontal: horizontalPad,
                                );

                              case 6:
                                return content(
                                  const SubmittionMainView(),

                                  top: topPad,

                                  horizontal: horizontalPad,
                                );

                              case 7:
                                if (state.subTitleIndex == 0) {
                                  return content(
                                    const AddressView(),

                                    top: topPad,

                                    horizontal: horizontalPad,
                                  );
                                } else if (state.subTitleIndex == 1) {
                                  return content(
                                    UpdateBillingAddress(),

                                    top: topPad,

                                    horizontal: horizontalPad,
                                  );
                                } else if (state.subTitleIndex == 2) {
                                  return content(
                                    UpdateShippingAddress(),

                                    top: topPad,

                                    horizontal: horizontalPad,
                                  );
                                } else {
                                  return const Center(
                                    child: Text("Unknown Address Page"),
                                  );
                                }

                              case 8:
                                return content(
                                  UpdateAccount(),

                                  top: topPad,

                                  horizontal: horizontalPad,
                                );

                              case 9:
                                return content(
                                  LogoutMainView(),

                                  top: topPad,

                                  horizontal: horizontalPad,
                                );
                            }

                            return const Center(child: Text("Unknown Page"));
                          },
                        ),

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

  // Responsive content padding

  Widget content(Widget widget, {double top = 24.0, double horizontal = 24.0}) {
    return Padding(
      padding: EdgeInsets.only(top: top, left: horizontal, right: horizontal),

      child: widget,
    );
  }
}
