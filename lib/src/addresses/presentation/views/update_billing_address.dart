import 'package:certempiree/core/utils/log_util.dart';
import 'package:certempiree/src/dashboard/models/user_model.dart';
import 'package:certempiree/src/dashboard/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:certempiree/src/dashboard/presentation/bloc/user_bloc/user_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateBillingAddress extends StatefulWidget {
  const UpdateBillingAddress({super.key});

  @override
  State<UpdateBillingAddress> createState() => _UpdateBillingAddressState();
}

class _UpdateBillingAddressState extends State<UpdateBillingAddress> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController companyName = TextEditingController();
  final TextEditingController country = TextEditingController();
  final TextEditingController streetAddress = TextEditingController();
  final TextEditingController streetAddress2 = TextEditingController();
  final TextEditingController townCity = TextEditingController();
  final TextEditingController state = TextEditingController();
  final TextEditingController postCode = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController email = TextEditingController();

  @override
  void initState() {
    super.initState();
    populateData();
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 850;

    // --- REFACTORED: Removed Scaffold, AppBar, and ListView ---
    // This widget is now a simple layout component intended to be placed
    // inside a parent that handles scrolling and the Scaffold.
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1400),
        // Padding was moved from the ListView to here to preserve the layout.
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isWide ? 44 : 18,
                vertical: 38,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize:
                      MainAxisSize
                          .min, // Prevents column from expanding infinitely
                  children: [
                    // Responsive two-column on wide screens, one-column on mobile
                    LayoutBuilder(
                      builder: (context, constraints) {
                        if (constraints.maxWidth > 600) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: _buildTitleInput(
                                  "First name",
                                  firstNameController,
                                  required: true,
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: _buildTitleInput(
                                  "Last name",
                                  lastNameController,
                                  required: true,
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Column(
                            children: [
                              _buildTitleInput(
                                "First name",
                                firstNameController,
                                required: true,
                              ),
                              _buildTitleInput(
                                "Last name",
                                lastNameController,
                                required: true,
                              ),
                            ],
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    _buildTitleInput("Company name", companyName),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 2,
                        bottom: 12,
                        top: 2,
                      ),
                      child: Text(
                        "This will be how your name will be displayed in the account section and in reviews.",
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.68),
                          fontSize: 13,
                        ),
                      ),
                    ),
                    _buildTitleInput("Country / Region", country),
                    const SizedBox(height: 18),
                    Divider(
                      thickness: 1.1,
                      color: Colors.grey.shade200,
                      height: 30,
                    ),
                    _buildTitleInput(
                      "Street address (optional)",
                      streetAddress,
                    ),
                    _buildTitleInput("Street address 2", streetAddress2),
                    _buildTitleInput("Town / City", townCity),
                    _buildTitleInput("State / Country", state),
                    _buildTitleInput("Post Code / ZIP", postCode),
                    _buildTitleInput("Phone", phone),
                    _buildTitleInput("Email address", email),
                    const SizedBox(height: 28),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        icon: const Icon(Icons.save_rounded, size: 22),
                        label: const Text(
                          "Save Changes",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.5,
                          ),
                        ),
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          backgroundColor: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          foregroundColor: Colors.white,
                          elevation: 2,
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final currentUser = context.read<UserBloc>();
                            final existingUserData = currentUser.state.userData;
                            final updatedBilling = Ing(
                              firstName: firstNameController.text,
                              lastName: lastNameController.text,
                              company: companyName.text,
                              country: country.text,
                              address1: streetAddress.text,
                              address2: streetAddress2.text,
                              city: townCity.text,
                              state: state.text,
                              postcode: postCode.text,
                              phone: phone.text,
                            );
                            final updatedUserData = existingUserData?.copyWith(
                              billing: updatedBilling,
                            );
                            context.read<UserBloc>().add(
                              UpdateUserEvent(userInfoData: updatedUserData!),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Billing address updated!"),
                                backgroundColor: Colors.green,
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleInput(
    String label,
    TextEditingController controller, {
    bool required = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
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
              if (label == "Phone" && val != null && val.isNotEmpty) {
                final phoneRegex = RegExp(r'^[\d+\-\s]+$');
                if (!phoneRegex.hasMatch(val)) {
                  return "Invalid phone format";
                }
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
  Future<void> populateData() async {
    final userBloc = context.read<UserBloc>();

    int retries = 10;
    while (userBloc.state.userData == null && retries > 0) {
      await Future.delayed(Duration(milliseconds: 500));
      retries--;
    }

    final userData = userBloc.state.userData;

    LogUtil.debug("User Billing JSON: ${userData?.toJson()}");

    if (userData != null) {
      final billing = userData.billing;
      firstNameController.text = billing?.firstName ?? "";
      lastNameController.text = billing?.lastName ?? "";
      companyName.text = billing?.company ?? "";
      country.text = billing?.country ?? "";
      streetAddress.text = billing?.address1 ?? "";
      streetAddress2.text = billing?.address2 ?? "";
      townCity.text = billing?.city ?? "";
      state.text = billing?.state ?? "";
      postCode.text = billing?.postcode ?? "";
      phone.text = billing?.phone ?? "";
      email.text = userData.email ?? "";
    }

    setState(() {});
  }

}
