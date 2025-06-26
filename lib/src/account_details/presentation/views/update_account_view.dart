import 'package:certempiree/core/shared/widgets/spaces.dart';
import 'package:certempiree/src/dashboard/presentation/bloc/user_bloc/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html_unescape/html_unescape.dart';

import '../../../dashboard/presentation/bloc/user_bloc/user_bloc.dart';

class UpdateAccount extends StatefulWidget {
  const UpdateAccount({super.key});

  @override
  State<UpdateAccount> createState() => _UpdateAccountState();
}

class _UpdateAccountState extends State<UpdateAccount> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController displayNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final TextEditingController currentPasswordController = TextEditingController(
    text: "******",
  );
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  String selectedCurrency = '؋ AFN';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    var userBloc = context.read<UserBloc>();
    firstNameController.text = userBloc.state.userData?.firstName ?? "";
    lastNameController.text = userBloc.state.userData?.lastName ?? "";
    displayNameController.text =
        "${userBloc.state.userData?.firstName ?? ""} ${userBloc.state.userData?.lastName ?? ""}";
    emailController.text = userBloc.state.userData?.email ?? "";
    selectedCurrency = userBloc.state.userData?.selectedCurrency?.name ?? "USD";
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: BlocBuilder<UserBloc, UserInitialState>(
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // --- All your fields here ---
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    _buildTitle("First name", true),
                                    _buildPlainTextField(firstNameController),
                                  ],
                                ),
                              ),
                              horizontalSpace(15),
                              Expanded(
                                child: Column(
                                  children: [
                                    _buildTitle("Last name", true),
                                    _buildPlainTextField(lastNameController),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          _buildTitle("Display name", true),
                          _buildPlainTextField(displayNameController),
                          const Padding(
                            padding: EdgeInsets.only(left: 4, bottom: 12),
                            child: Text(
                              "This will be how your name will be displayed in the account section and in reviews",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          _buildTitle("Email address", true),
                          _buildPlainTextField(emailController),
                          const SizedBox(height: 20),
                          const Divider(),
                          const SizedBox(height: 20),
                          _buildTitle(
                            "Current password (leave blank to leave unchanged)",
                            true,
                          ),
                          _buildPlainTextField(
                            currentPasswordController,
                            obscure: true,
                          ),
                          _buildTitle("New password", false),
                          _buildPlainTextField(
                            newPasswordController,
                            obscure: true,
                          ),
                          _buildTitle("Confirm new password", false),
                          _buildPlainTextField(
                            confirmPasswordController,
                            obscure: true,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "Default currency",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          DropdownButtonFormField<String>(
                            value:
                                state.userData?.selectedCurrency?.name ?? "USD",
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            items:
                                state.userData?.currencyOptions?.map((
                                  currency,
                                ) {
                                  return DropdownMenuItem<String>(
                                    value: currency.name,
                                    child: Row(
                                      children: [
                                        Text(
                                          HtmlUnescape().convert(
                                            currency.symbol ?? "",
                                          ),
                                        ),
                                        horizontalSpace(5),

                                        Text(currency.name ?? ""),
                                      ],
                                    ),
                                  );
                                }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  selectedCurrency = value;
                                });
                              }
                            },
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Select your preferred currency for shopping and payments.",
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // Submit logic
                              }
                            },
                            child: const Text("Save Changes"),
                          ),

                          verticalSpace(150),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTitle(String text, bool steric) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 6),
      child: Row(
        children: [
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
          Text(
            steric ? "*" : "",
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlainTextField(
    TextEditingController controller, {
    bool obscure = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      style: TextStyle(color: Colors.black54, fontSize: 14),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 10,
        ),
        filled: false,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,

          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,

          borderSide: BorderSide(color: Colors.grey.shade600, width: 1.2),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.zero,

          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
      ),
    );
  }
}
