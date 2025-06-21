import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/res/app_strings.dart';
import '../../../order/presentation/bloc/report_bloc/order_bloc.dart';
import '../../../order/presentation/bloc/report_bloc/order_events.dart';
import '../../../order/presentation/bloc/report_bloc/order_state.dart';

class DownloadMainView extends StatefulWidget {
  const DownloadMainView({super.key});

  @override
  State<DownloadMainView> createState() => _DownloadMainViewState();
}

class _DownloadMainViewState extends State<DownloadMainView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<OrderBloc>().add(
      GetOrderEvent(pageNumber: 1, pageSize: 10, userId: AppStrings.userId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Color(0x99EFEFEF),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Product",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "File",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "  Remaining",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "  Expires",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            BlocBuilder<OrderBloc, OrderInitialState>(
              builder: (context, state) {
                return Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      var element = state.orders?[index];

                      return Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Text(element?.order ?? ""),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Text(element?.date ?? ""),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Text(element?.status ?? ""),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.purple,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Text(
                                          "Download",
                                          style: TextStyle(
                                            color: AppColors.purple,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.purple,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Text(
                                          "Practice Online",
                                          style: TextStyle(
                                            color: AppColors.purple,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    itemCount: state.orders?.length,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
