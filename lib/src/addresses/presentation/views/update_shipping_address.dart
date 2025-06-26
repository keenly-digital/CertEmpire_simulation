import 'package:certempiree/core/utils/log_util.dart';
import 'package:certempiree/src/dashboard/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/shared/widgets/spaces.dart';
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
  final TextEditingController newPasswordController = TextEditingController();
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
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              _buildTitle("Company name", true),
              _buildPlainTextField(companyName),

              const Padding(
                padding: EdgeInsets.only(left: 4, bottom: 12),
                child: Text(
                  "This will be how your name will be displayed in the account section and in reviews",
                  style: TextStyle(color: Colors.black, fontSize: 13),
                ),
              ),

              _buildTitle("Country / Region", false),
              _buildPlainTextField(country),

              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 20),

              _buildTitle("Street address", true),
              _buildPlainTextField(streetAddress, obscure: false),
              _buildPlainTextField(streetAddress2, obscure: false),

              _buildTitle("Town / City", false),
              _buildPlainTextField(townCity, obscure: false),
              _buildTitle("State / Country", false),
              _buildPlainTextField(state, obscure: false),
              _buildTitle("Post Code / ZIP", false),
              _buildPlainTextField(postCode, obscure: false),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final currentUser = context.read<UserBloc>();
                    final existingUserData = currentUser.state.userData;

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

                    final updatedUserData = existingUserData?.copyWith(
                      shipping: updatedShipping,
                    );

                    context.read<UserBloc>().add(
                      UpdateUserEvent(userInfoData: updatedUserData!),
                    );
                  }
                },

                child: const Text("Save Addresses"),
              ),
            ],
          ),
        ),
      ),
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
