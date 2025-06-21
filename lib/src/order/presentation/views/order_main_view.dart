import 'package:certempiree/core/res/app_strings.dart';
import 'package:certempiree/src/order/presentation/bloc/report_bloc/order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/report_bloc/order_bloc.dart';
import '../bloc/report_bloc/order_events.dart';

class OrderMainView extends StatefulWidget {
  const OrderMainView({super.key});

  @override
  State<OrderMainView> createState() => _OrderMainViewState();
}

class _OrderMainViewState extends State<OrderMainView> {
  @override
  void initState() {
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
                color: Color(0xFFEFEFEF),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      "Orders",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Date",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "  Status",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "  Total",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "   Actions",
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
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration( border: Border.all(color: Colors.grey.shade300),),
                              child: Text(element?.order ?? ""),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration( border: Border.all(color: Colors.grey.shade300),),
                              child: Text(element?.date ?? ""),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration( border: Border.all(color: Colors.grey.shade300),),
                              child: Text(element?.status ?? ""),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration( border: Border.all(color: Colors.grey.shade300),),
                              child: Text(element?.total ?? ""),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration( border: Border.all(color: Colors.grey.shade300),),
                              child: Text(element?.actions ?? ""),
                            ),
                          ),
                        ],
                      );
                    },
                    itemCount: state.orders?.length,
                  ),
                  // Row(
                  //   children: [
                  //     Expanded(child: Text("Orders")),
                  //     Expanded(child: Text("Date")),
                  //     Expanded(child: Text("Status")),
                  //     Expanded(flex: 2, child: Text("Total")),
                  //     Expanded(child: Text("Actions")),
                  //   ],
                  // ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
