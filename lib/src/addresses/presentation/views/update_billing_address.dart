import 'package:certempiree/core/utils/log_util.dart';
import 'package:certempiree/src/dashboard/models/user_model.dart';
import 'package:certempiree/src/dashboard/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:certempiree/src/dashboard/presentation/bloc/user_bloc/user_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/shared/widgets/spaces.dart';

class UpdateBillingAddress extends StatefulWidget {
  const UpdateBillingAddress({super.key});

  @override
  State<UpdateBillingAddress> createState() => _UpdateBillingAddressState();
}

class _UpdateBillingAddressState extends State<UpdateBillingAddress> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController(
    text: "Usmans",
  );
  final TextEditingController lastNameController = TextEditingController(
    text: "Ahmad",
  );
  final TextEditingController companyName = TextEditingController(
    text: "Usman Ahmad",
  );
  final TextEditingController country = TextEditingController(
    text: "wp.usman.personal@gmail.com",
  );

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
    LogUtil.debug("lsjdlksajdlksajuweoiwqu ${userBloc.userData?.toJson()}");
    firstNameController.text = userBloc.userData?.firstName ?? "";
    lastNameController.text = userBloc.userData?.lastName ?? "";
    companyName.text = userBloc.userData?.billing?.company ?? "";
    country.text = userBloc.userData?.billing?.country ?? "";
    streetAddress.text = userBloc.userData?.billing?.address1 ?? "";
    streetAddress2.text = userBloc.userData?.billing?.address2 ?? "";
    townCity.text = userBloc.userData?.billing?.city ?? "";
    state.text = userBloc.userData?.billing?.state ?? "";
    postCode.text = userBloc.userData?.billing?.postcode ?? "";
    phone.text = userBloc.userData?.billing?.phone ?? "";
    email.text = userBloc.userData?.email ?? "";
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

              _buildTitle("Street address (optional)", true),
              _buildPlainTextField(streetAddress, obscure: false),
              _buildPlainTextField(streetAddress2, obscure: false),

              _buildTitle("Town / City", false),
              _buildPlainTextField(townCity, obscure: false),
              _buildTitle("State / Country", false),
              _buildPlainTextField(state, obscure: false),
              _buildTitle("Post Code / ZIP", false),
              _buildPlainTextField(postCode, obscure: false),
              _buildTitle("Phone", false),
              _buildPlainTextField(phone, obscure: false),
              _buildTitle("Email address", false),
              _buildPlainTextField(email, obscure: false),

              const SizedBox(height: 20),
              ElevatedButton(
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
                  }
                },
                child: const Text("Save Changes"),
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
