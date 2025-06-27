import 'package:certempiree/core/utils/log_util.dart';
import 'package:certempiree/src/dashboard/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../dashboard/models/user_model.dart';
import '../../../dashboard/presentation/bloc/user_bloc/user_events.dart';

class UpdateShippingAddress extends StatefulWidget {
  const UpdateShippingAddress({super.key});

  @override
  State<UpdateShippingAddress> createState() => _UpdateShippingAddressState();
}

class _UpdateShippingAddressState extends State<UpdateShippingAddress> {
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
    var userBloc = context.read<UserBloc>().state;
    firstNameController.text = userBloc.userData?.shipping?.firstName ?? "";
    lastNameController.text = userBloc.userData?.shipping?.lastName ?? "";
    companyName.text = userBloc.userData?.shipping?.company ?? "";
    country.text = userBloc.userData?.shipping?.country ?? "";
    streetAddress.text = userBloc.userData?.shipping?.address1 ?? "";
    streetAddress2.text = userBloc.userData?.shipping?.address2 ?? "";
    townCity.text = userBloc.userData?.shipping?.city ?? "";
    state.text = userBloc.userData?.shipping?.state ?? "";
    postCode.text = userBloc.userData?.shipping?.postcode ?? "";
    phone.text = userBloc.userData?.shipping?.phone ?? "";
    email.text = userBloc.userData?.shipping?.email ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 34),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth < 700 ? 10 : 34,
            ),
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth > 850 ? 44 : 18,
                  vertical: 38,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Responsive two-column layout
                      LayoutBuilder(
                        builder: (context, constraints) {
                          bool wide = constraints.maxWidth > 800;
                          return Wrap(
                            spacing: 30,
                            runSpacing: 0,
                            children: [
                              SizedBox(
                                width:
                                    wide
                                        ? constraints.maxWidth / 2 - 20
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
                                        ? constraints.maxWidth / 2 - 20
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
                        "Street address",
                        streetAddress,
                        required: true,
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
                            "Save Address",
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
                              final existingUserData =
                                  currentUser.state.userData;
                              final updatedShipping = Ing(
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
                              final updatedUserData = existingUserData
                                  ?.copyWith(shipping: updatedShipping);
                              context.read<UserBloc>().add(
                                UpdateUserEvent(userInfoData: updatedUserData!),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Shipping address updated!"),
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
}
