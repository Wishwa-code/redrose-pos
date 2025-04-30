import 'package:flutter/material.dart';

import '../../models/brand.dart';

class BrandFormCard extends StatefulWidget {
  const BrandFormCard({
    super.key,
    required this.newBrand,
    required this.onBrandChanged,
  });

  final Brand newBrand;
  final void Function(Brand updatedBrand) onBrandChanged;

  @override
  State<BrandFormCard> createState() => BrandFormCardState();
}

class BrandFormCardState extends State<BrandFormCard> {
  late final TextEditingController nameController;
  late final TextEditingController descController;
  late final TextEditingController logoController;
  late final TextEditingController originController;
  late final TextEditingController socialController;
  late final TextEditingController emailController;
  late final TextEditingController phoneController;
  late final TextEditingController bannerController;
  late final TextEditingController websiteController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.newBrand.name);
    descController = TextEditingController(text: widget.newBrand.description);
    logoController = TextEditingController(text: widget.newBrand.logourl);
    originController = TextEditingController(text: widget.newBrand.countryOfOrigin);
    socialController = TextEditingController(text: widget.newBrand.socialMediaLinks);
    emailController = TextEditingController(text: widget.newBrand.contactEmail);
    phoneController = TextEditingController(text: widget.newBrand.phoneNumber);
    bannerController = TextEditingController(text: widget.newBrand.bannerUrl);
    websiteController = TextEditingController(text: widget.newBrand.website);
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
    super.dispose();
  }

  void _update() {
    widget.onBrandChanged(
      widget.newBrand.copyWith(
        name: nameController.text,
        description: descController.text,
        logourl: logoController.text,
        countryOfOrigin: originController.text,
        socialMediaLinks: socialController.text,
        contactEmail: emailController.text,
        phoneNumber: phoneController.text,
        bannerUrl: bannerController.text,
        website: websiteController.text,
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
    // widget.onBrandChanged(const Brand()); // reset state outside too
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
          controller: nameController,
          onChanged: (_) => _update(),
          decoration: inputDecoration('Brand Name'),
        ),
        const SizedBox(height: 12),
        TextFormField(
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
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: originController,
          onChanged: (_) => _update(),
          decoration: inputDecoration('Country of Origin'),
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: socialController,
          onChanged: (_) => _update(),
          decoration: inputDecoration('Social Media Links'),
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: emailController,
          onChanged: (_) => _update(),
          decoration: inputDecoration('Contact Email'),
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: phoneController,
          onChanged: (_) => _update(),
          decoration: inputDecoration('Phone Number'),
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: bannerController,
          onChanged: (_) => _update(),
          decoration: inputDecoration('Banner URL'),
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: websiteController,
          onChanged: (_) => _update(),
          decoration: inputDecoration('Website'),
        ),
      ],
    );
  }
}
