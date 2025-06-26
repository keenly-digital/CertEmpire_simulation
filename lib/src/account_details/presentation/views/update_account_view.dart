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
  String selectedCurrency = 'USD';

  @override
  void initState() {
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
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      appBar: AppBar(
        title: const Text("Update Account"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 34),
        children: [
          // Main form section, full width but with padding on the sides
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth < 700 ? 12 : 36,
            ),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 40,
                ),
                child: Form(
                  key: _formKey,
                  child: BlocBuilder<UserBloc, UserInitialState>(
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Two columns on wide screens, stacked on mobile
                          LayoutBuilder(
                            builder: (context, constraints) {
                              bool wide = constraints.maxWidth > 650;
                              return Wrap(
                                spacing: 32,
                                runSpacing: 0,
                                children: [
                                  SizedBox(
                                    width:
                                        wide
                                            ? constraints.maxWidth / 2 - 18
                                            : double.infinity,
                                    child: _buildTitleInput(
                                      "First name",
                                      firstNameController,
                                      required: true,
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        wide
                                            ? constraints.maxWidth / 2 - 18
                                            : double.infinity,
                                    child: _buildTitleInput(
                                      "Last name",
                                      lastNameController,
                                      required: true,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 12),
                          _buildTitleInput(
                            "Display name",
                            displayNameController,
                            required: true,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 2,
                              bottom: 13,
                              top: 2,
                            ),
                            child: Text(
                              "This will be how your name will be displayed in the account section and in reviews.",
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.67),
                                fontSize: 13,
                              ),
                            ),
                          ),
                          _buildTitleInput(
                            "Email address",
                            emailController,
                            required: true,
                          ),
                          const SizedBox(height: 20),
                          Divider(
                            thickness: 1.1,
                            color: Colors.grey.shade200,
                            height: 32,
                          ),
                          _buildTitleInput(
                            "Current password (leave blank to leave unchanged)",
                            currentPasswordController,
                            obscure: true,
                          ),
                          _buildTitleInput(
                            "New password",
                            newPasswordController,
                            obscure: true,
                          ),
                          _buildTitleInput(
                            "Confirm new password",
                            confirmPasswordController,
                            obscure: true,
                          ),
                          const SizedBox(height: 22),
                          const Text(
                            "Default currency",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 10),
                          DropdownButtonFormField<String>(
                            value:
                                state.userData?.selectedCurrency?.name ?? "USD",
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 15,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                            ),
                            items:
                                (state.userData?.currencyOptions ?? []).map((
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
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                        ),
                                        horizontalSpace(7),
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
                          const SizedBox(height: 34),
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton.icon(
                              icon: const Icon(Icons.save_rounded, size: 21),
                              label: const Text(
                                "Save Changes",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.5,
                                ),
                              ),
                              style: FilledButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                ),
                                backgroundColor: Theme.of(context).primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                foregroundColor: Colors.white,
                                elevation: 2,
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  // Submit logic
                                }
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleInput(
    String label,
    TextEditingController controller, {
    bool required = false,
    bool obscure = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFF111339),
                fontSize: 15.5,
              ),
              children:
                  required
                      ? [
                        const TextSpan(
                          text: " *",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ]
                      : [],
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            obscureText: obscure,
            validator: (val) {
              if (required && (val == null || val.trim().isEmpty)) {
                return "$label is required";
              }
              if (label == "Email address" && val != null && val.isNotEmpty) {
                final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                if (!emailRegex.hasMatch(val)) {
                  return "Invalid email format";
                }
              }
              if (label.contains("password") &&
                  val != null &&
                  val.isNotEmpty &&
                  val.length < 6) {
                return "Password must be at least 6 characters";
              }
              return null;
            },
            style: const TextStyle(fontSize: 15.7, color: Colors.black87),
            decoration: InputDecoration(
              isDense: true,
              filled: true,
              fillColor: const Color(0xFFF4F6FB),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 13,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
                borderSide: const BorderSide(color: Color(0xFFE0E4F0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
                borderSide: const BorderSide(
                  color: Color(0xFF6C63FF),
                  width: 1.7,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
                borderSide: const BorderSide(color: Color(0xFFE0E4F0)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
