import 'package:fitwiz/features/address/data/models/society.dart';
import 'package:fitwiz/features/address/data/models/tower_short.dart';
import 'package:fitwiz/features/address/presentation/blocs/edit_society/edit_society_bloc.dart';
import 'package:fitwiz/features/address/presentation/blocs/edit_tower/edit_tower_bloc.dart';
import 'package:fitwiz/utils/components/custom_dropdown.dart';
import 'package:fitwiz/utils/theme/app_colors.dart';
import 'package:fitwiz/utils/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TowerEditSection extends StatelessWidget {
  final Society? society;
  final TowerShort? tower;

  final ValueChanged<Society?> onSocietyChanged;
  final ValueChanged<TowerShort?> onTowerChanged;

  const TowerEditSection({
    super.key,
    this.society,
    this.tower,
    required this.onSocietyChanged,
    required this.onTowerChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Society',
          style: AppTextStyles.FFF_16_700(color: AppColors.textHeader),
        ),
        8.verticalSpacingRadius,
        _SocietyPicker(
          society: society,
          onChanged: (society) => _onSocietyChanged(context, society),
        ),
        16.verticalSpacingRadius,
        Text(
          'Tower',
          style: AppTextStyles.FFF_16_700(color: AppColors.textHeader),
        ),
        8.verticalSpacingRadius,
        _TowerPicker(
          tower: tower,
          onChanged: onTowerChanged,
          disabled: society == null,
        ),
      ],
    );
  }

  void _onSocietyChanged(BuildContext context, Society? society) {
    onSocietyChanged(society);
    if (society != null) {
      context.read<EditTowerBloc>().add(FetchTowers(society));
    }
  }
}

class _SocietyPicker extends StatelessWidget {
  final Society? society;
  final ValueChanged<Society?> onChanged;

  const _SocietyPicker({
    this.society,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditSocietyBloc, EditSocietyState>(
      builder: (context, state) {
        List<Society> societies = [];
        if (state is EditSocietyLoaded) {
          societies = state.societies;
        }

        return CustomDropdown<Society>(
          items: societies.map((society) {
            return DropdownMenuItem<Society>(
              value: society,
              child: Text(society.name),
            );
          }).toList(),
          onChanged: onChanged,
          value: society,
          validator: (_) {
            if (society == null) {
              return 'Please select a society';
            }
            return null;
          },
          isLoading: state is EditSocietyLoading,
        );
      },
    );
  }
}

class _TowerPicker extends StatelessWidget {
  final TowerShort? tower;
  final ValueChanged<TowerShort?> onChanged;
  final bool disabled;

  const _TowerPicker({
    this.tower,
    required this.onChanged,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditTowerBloc, EditTowerState>(
      builder: (context, state) {
        List<TowerShort> towers = [];
        if (state is EditTowerLoaded) {
          towers = state.towers;
        }

        return CustomDropdown<TowerShort>(
          items: towers.map((tower) {
            return DropdownMenuItem<TowerShort>(
              value: tower,
              child: Text(tower.name),
            );
          }).toList(),
          onChanged: onChanged,
          value: tower,
          validator: (_) {
            if (tower == null) {
              return 'Please select a tower';
            }
            return null;
          },
          disabled: disabled,
          isLoading: state is EditTowerLoading,
        );
      },
    );
  }
}
