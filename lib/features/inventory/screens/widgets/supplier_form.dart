import 'package:flutter/material.dart';

import '../../models/supplier.dart';

class SupplierFormCard extends StatefulWidget {
  const SupplierFormCard({
    super.key,
    required this.newSupplier,
    required this.onSupplierChanged,
    required this.parentButtonNode,
  });

  final Supplier newSupplier;
  final void Function(Supplier updatedSupplier) onSupplierChanged;
  final FocusNode parentButtonNode;

  @override
  SupplierFormCardState createState() => SupplierFormCardState();
}

class SupplierFormCardState extends State<SupplierFormCard> {
  late final TextEditingController nameController;
  late final TextEditingController descController;
  late final TextEditingController logoController;
  late final TextEditingController originController;
  late final TextEditingController socialController;
  late final TextEditingController emailController;
  late final TextEditingController phoneController;
  late final TextEditingController bannerController;
  late final TextEditingController websiteController;
  late final TextEditingController cityController;
  late final TextEditingController countryController;
  late final TextEditingController bankController;
  late final TextEditingController statusController;
  late final TextEditingController extraController;

  final FocusNode nameFocus = FocusNode();
  final FocusNode descFocus = FocusNode();
  final FocusNode logoFocus = FocusNode();
  final FocusNode websiteFocus = FocusNode();
  final FocusNode originFocus = FocusNode();
  final FocusNode socialFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode bannerFocus = FocusNode();
  final FocusNode cityFocus = FocusNode();
  final FocusNode countryFocus = FocusNode();
  final FocusNode bankFocus = FocusNode();
  final FocusNode statusFocus = FocusNode();
  final FocusNode extraFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.newSupplier.name);
    descController = TextEditingController(text: widget.newSupplier.description);
    logoController = TextEditingController(text: widget.newSupplier.logourl);
    originController = TextEditingController(text: widget.newSupplier.countryOfOrigin);
    socialController = TextEditingController(text: widget.newSupplier.socialMediaLinks);
    emailController = TextEditingController(text: widget.newSupplier.contactEmail);
    phoneController = TextEditingController(text: widget.newSupplier.phoneNumber);
    bannerController = TextEditingController(text: widget.newSupplier.bannerUrl);
    websiteController = TextEditingController(text: widget.newSupplier.website);
    cityController = TextEditingController(text: widget.newSupplier.locatedCity);
    countryController = TextEditingController(text: widget.newSupplier.locatedCountry);
    bankController = TextEditingController(text: widget.newSupplier.bankDetails);
    statusController = TextEditingController(text: widget.newSupplier.status);
    extraController = TextEditingController(text: widget.newSupplier.extraData);
  }

  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    logoController.dispose();
    originController.dispose();
    socialController.dispose();
    emailController.dispose();
    phoneController.dispose();
    bannerController.dispose();
    websiteController.dispose();
    cityController.dispose();
    countryController.dispose();
    bankController.dispose();
    statusController.dispose();
    extraController.dispose();

    nameFocus.dispose();
    descFocus.dispose();
    logoFocus.dispose();
    websiteFocus.dispose();
    originFocus.dispose();
    socialFocus.dispose();
    emailFocus.dispose();
    phoneFocus.dispose();
    bannerFocus.dispose();
    cityFocus.dispose();
    countryFocus.dispose();
    bankFocus.dispose();
    statusFocus.dispose();
    extraFocus.dispose();
    super.dispose();
  }

  void _update() {
    widget.onSupplierChanged(
      widget.newSupplier.copyWith(
        name: nameController.text,
        description: descController.text,
        logourl: logoController.text,
        countryOfOrigin: originController.text,
        socialMediaLinks: socialController.text,
        contactEmail: emailController.text,
        phoneNumber: phoneController.text,
        bannerUrl: bannerController.text,
        website: websiteController.text,
        locatedCity: cityController.text,
        locatedCountry: countryController.text,
        bankDetails: bankController.text,
        status: statusController.text,
        extraData: extraController.text,
      ),
    );
  }

  void clearFields() {
    nameController.clear();
    descController.clear();
    logoController.clear();
    originController.clear();
    socialController.clear();
    emailController.clear();
    phoneController.clear();
    bannerController.clear();
    websiteController.clear();
    cityController.clear();
    countryController.clear();
    bankController.clear();
    statusController.clear();
    extraController.clear();
    // You may also want to reset the Supplier object itself
    // widget.onSupplierChanged(const Supplier());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    InputDecoration inputDecoration(String label) => InputDecoration(
          labelText: label,
          labelStyle: theme.textTheme.titleMedium!.copyWith(
            color: theme.colorScheme.primary,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          focusNode: nameFocus,
          onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(descFocus),
          textInputAction: TextInputAction.next,
          controller: nameController,
          onChanged: (_) => _update(),
          decoration: inputDecoration('Supplier Name'),
        ),
        const SizedBox(height: 12),
        TextFormField(
          focusNode: descFocus,
          onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(logoFocus),
          textInputAction: TextInputAction.next,
          controller: descController,
          maxLines: 3,
          onChanged: (_) => _update(),
          decoration: inputDecoration('Description'),
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: logoController,
          onChanged: (_) => _update(),
          decoration: inputDecoration('Logo URL'),
          focusNode: logoFocus,
          onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(websiteFocus),
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: websiteController,
          onChanged: (_) => _update(),
          decoration: inputDecoration('Website'),
          focusNode: websiteFocus,
          onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(originFocus),
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: originController,
          onChanged: (_) => _update(),
          decoration: inputDecoration('Country of Origin'),
          focusNode: originFocus,
          onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(socialFocus),
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: socialController,
          onChanged: (_) => _update(),
          decoration: inputDecoration('Social Media Links'),
          focusNode: socialFocus,
          onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(emailFocus),
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: emailController,
          onChanged: (_) => _update(),
          decoration: inputDecoration('Contact Email'),
          focusNode: emailFocus,
          onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(phoneFocus),
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: phoneController,
          onChanged: (_) => _update(),
          decoration: inputDecoration('Phone Number'),
          focusNode: phoneFocus,
          onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(bannerFocus),
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: bannerController,
          onChanged: (_) => _update(),
          decoration: inputDecoration('Banner URL'),
          focusNode: bannerFocus,
          onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(cityFocus),
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: cityController,
          onChanged: (_) => _update(),
          decoration: inputDecoration('City'),
          focusNode: cityFocus,
          onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(countryFocus),
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: countryController,
          onChanged: (_) => _update(),
          decoration: inputDecoration('Country'),
          focusNode: countryFocus,
          onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(bankFocus),
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: bankController,
          onChanged: (_) => _update(),
          decoration: inputDecoration('Bank Details'),
          focusNode: bankFocus,
          onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(statusFocus),
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: statusController,
          onChanged: (_) => _update(),
          decoration: inputDecoration('Status'),
          focusNode: statusFocus,
          onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(extraFocus),
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: extraController,
          onChanged: (_) => _update(),
          decoration: inputDecoration('Extra Data'),
          focusNode: extraFocus,
          onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(widget.parentButtonNode),
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }
}
