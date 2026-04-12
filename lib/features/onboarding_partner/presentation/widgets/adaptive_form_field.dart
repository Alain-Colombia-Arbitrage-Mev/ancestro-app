import 'package:flutter/material.dart';

import '../../../../core/design/app_colors.dart';
import '../../../../core/design/app_radii.dart';
import '../../../../core/design/app_typography.dart';
import '../../domain/models/partner_field_config.dart';

class AdaptiveFormField extends StatelessWidget {
  final PartnerFieldConfig config;
  final dynamic value;
  final ValueChanged<dynamic> onChanged;

  const AdaptiveFormField({
    super.key,
    required this.config,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          config.label,
          style: AppTypography.label.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: 8),
        _buildField(),
      ],
    );
  }

  Widget _buildField() {
    switch (config.type) {
      case FieldType.text:
        return _buildTextField();
      case FieldType.number:
        return _buildTextField(keyboardType: TextInputType.number);
      case FieldType.dropdown:
        return _buildDropdown();
      case FieldType.multiSelect:
        return _buildMultiSelect();
      case FieldType.textarea:
        return _buildTextField(maxLines: 4);
      case FieldType.fileUpload:
        return _buildFileUpload();
    }
  }

  Widget _buildTextField({
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextField(
      controller: TextEditingController(text: value?.toString() ?? '')
        ..selection = TextSelection.collapsed(
          offset: (value?.toString() ?? '').length,
        ),
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: AppTypography.body.copyWith(color: AppColors.textPrimary),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.inputFill,
        hintText: config.label,
        hintStyle: AppTypography.body.copyWith(color: AppColors.textTertiary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.small),
          borderSide: BorderSide(color: AppColors.inputBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.small),
          borderSide: BorderSide(color: AppColors.inputBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.small),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      onChanged: (v) => onChanged(v),
    );
  }

  Widget _buildDropdown() {
    final options = config.options ?? [];
    final currentValue =
        (value is String && options.contains(value)) ? value as String : null;

    return DropdownButtonFormField<String>(
      initialValue: currentValue,
      dropdownColor: AppColors.surface,
      style: AppTypography.body.copyWith(color: AppColors.textPrimary),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.inputFill,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.small),
          borderSide: BorderSide(color: AppColors.inputBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.small),
          borderSide: BorderSide(color: AppColors.inputBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.small),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      hint: Text(
        'Select ${config.label}',
        style: AppTypography.body.copyWith(color: AppColors.textTertiary),
      ),
      icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textTertiary),
      items: options
          .map((o) => DropdownMenuItem(value: o, child: Text(o)))
          .toList(),
      onChanged: (v) => onChanged(v),
    );
  }

  Widget _buildMultiSelect() {
    final options = config.options ?? [];
    final selected = (value is List) ? List<String>.from(value as List) : <String>[];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options.map((option) {
        final isSelected = selected.contains(option);
        return FilterChip(
          label: Text(
            option,
            style: AppTypography.caption.copyWith(
              color: isSelected ? AppColors.onPrimary : AppColors.textSecondary,
            ),
          ),
          selected: isSelected,
          onSelected: (sel) {
            final updated = List<String>.from(selected);
            if (sel) {
              updated.add(option);
            } else {
              updated.remove(option);
            }
            onChanged(updated);
          },
          selectedColor: AppColors.primary,
          backgroundColor: AppColors.inputFill,
          side: BorderSide(
            color: isSelected ? AppColors.primary : AppColors.surfaceBorder,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.small),
          ),
          checkmarkColor: AppColors.onPrimary,
        );
      }).toList(),
    );
  }

  Widget _buildFileUpload() {
    return OutlinedButton.icon(
      onPressed: () {
        // File upload placeholder
        onChanged('file_selected');
      },
      icon: const Icon(Icons.upload_file, color: AppColors.primary),
      label: Text(
        value != null ? 'File Selected' : 'Upload File',
        style: AppTypography.body.copyWith(color: AppColors.textPrimary),
      ),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: AppColors.surfaceBorder),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.small),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      ),
    );
  }
}
