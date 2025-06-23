import 'package:certempiree/core/shared/widgets/spaces.dart';
import 'package:flutter/material.dart';

class UpdateAccount extends StatefulWidget {
  const UpdateAccount({super.key});

  @override
  State<UpdateAccount> createState() => _UpdateAccountState();
}

class _UpdateAccountState extends State<UpdateAccount> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController(
    text: "Usmans",
  );
  final TextEditingController lastNameController = TextEditingController(
    text: "Ahmad",
  );
  final TextEditingController displayNameController = TextEditingController(
    text: "Usman Ahmad",
  );
  final TextEditingController emailController = TextEditingController(
    text: "wp.usman.personal@gmail.com",
  );

  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

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
              _buildTitle("Display name", true),
              _buildPlainTextField(displayNameController),

              const Padding(
                padding: EdgeInsets.only(left: 4, bottom: 12),
                child: Text(
                  "This will be how your name will be displayed in the account section and in reviews",
                  style: TextStyle(color: Colors.black, fontSize: 13),
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
              _buildPlainTextField(currentPasswordController, obscure: true),

              _buildTitle("", false),
              _buildPlainTextField(newPasswordController, obscure: true),

              _buildTitle("Confirm new password", false),
              _buildPlainTextField(confirmPasswordController, obscure: true),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Submit logic
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
