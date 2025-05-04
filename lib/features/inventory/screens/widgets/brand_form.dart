import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/brand.dart';
import '../../providers/brand_provider.dart';

class BrandFormCard extends ConsumerStatefulWidget {
  const BrandFormCard({
    super.key,
    required this.newBrand,
    required this.onBrandChanged,
    required this.parentButtonNode,
  });

  final Brand newBrand;
  final void Function(Brand updatedBrand) onBrandChanged;
  final FocusNode parentButtonNode;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => BrandFormCardState();
}

class BrandFormCardState extends ConsumerState<BrandFormCard> {
  late final TextEditingController nameController;
  late final TextEditingController descController;
  late final TextEditingController logoController;
  late final TextEditingController originController;
  late final TextEditingController socialController;
  late final TextEditingController emailController;
  late final TextEditingController phoneController;
  late final TextEditingController bannerController;
  late final TextEditingController websiteController;

  final FocusNode nameFocus = FocusNode();
  final FocusNode descFocus = FocusNode();
  final FocusNode logoFocus = FocusNode();
  final FocusNode originFocus = FocusNode();
  final FocusNode socialFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode bannerFocus = FocusNode();
  final FocusNode websiteFocus = FocusNode();

  bool _isUpdating = false;

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

    nameFocus.dispose();
    descFocus.dispose();
    logoFocus.dispose();
    originFocus.dispose();
    socialFocus.dispose();
    emailFocus.dispose();
    phoneFocus.dispose();
    bannerFocus.dispose();
    websiteFocus.dispose();
    super.dispose();
  }

  void _update() {
    _isUpdating = true;
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
    ref.listen<AsyncValue<List<Brand?>>>(
      brandNotifierProvider,
      (prev, next) {
        next.when(
          data: (brands) {
            final nonNullBrands = brands
                .where((b) => b != null && b.createdAt != null)
                .map((b) => b!) // Cast Brand? to Brand
                .toList();

            if (nonNullBrands.isNotEmpty) {
              nonNullBrands.sort(
                (a, b) => b.createdAt!.compareTo(a.createdAt!),
              );
              final lastEnteredBrand = nonNullBrands.first;

              // nameController.text = lastEnteredBrand.name;
              // descController.text = lastEnteredBrand.description;
              // logoController.text = lastEnteredBrand.logourl;
              // originController.text = lastEnteredBrand.countryOfOrigin;
              // socialController.text = lastEnteredBrand.socialMediaLinks;
              // emailController.text = lastEnteredBrand.contactEmail;
              // phoneController.text = lastEnteredBrand.phoneNumber;
              // bannerController.text = lastEnteredBrand.bannerUrl;
              // websiteController.text = lastEnteredBrand.website;
              // Do something with lastEnteredBrand here
            }

            if (_isUpdating) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Product updated successfully!'),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
              );
              _isUpdating = false;
              clearFields();
            }
          },
          loading: () {
            // Optional: show loading indicator
          },
          error: (error, stack) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Oops theres a problem: $error')),
            );
          },
        );
      },
    );

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
          focusNode: nameFocus,
          onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(descFocus),
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: descController,
          maxLines: 3,
          onChanged: (_) => _update(),
          decoration: inputDecoration('Description'),
          focusNode: descFocus,
          onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(logoFocus),
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: logoController,
          onChanged: (_) => _update(),
          decoration: inputDecoration('Logo URL'),
          focusNode: logoFocus,
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
          onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(websiteFocus),
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: websiteController,
          onChanged: (_) => _update(),
          decoration: inputDecoration('Website'),
          focusNode: websiteFocus,
          onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(widget.parentButtonNode),
          textInputAction: TextInputAction.next,
        ),
      ],
    );
  }
}
