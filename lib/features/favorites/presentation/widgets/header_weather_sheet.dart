import 'package:clima_app/core/colors/app_colors_light.dart';
import 'package:clima_app/core/extensions/color_extension.dart';
import 'package:clima_app/core/shared/ui/cubits/network_cubit.dart';
import 'package:clima_app/core/shared/ui/cubits/network_state.dart';
import 'package:clima_app/core/shared/ui/widgets/network_status_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HeaderWeatherSheet extends StatelessWidget {
  const HeaderWeatherSheet({
    super.key,
    required this.onCancel,
    required this.onSave,
    required this.isAbleToSave,
  });

  final void Function() onCancel;
  final void Function() onSave;
  final bool isAbleToSave;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<NetworkCubit, NetworkState>(
      builder: (context, state) {
        final isConnected = state.status == NetworkStatus.connected;
        final onSaveTextColor = isConnected
            ? theme.colorScheme.onPrimary
            : AppColorsLight.onPrimary.customOpacity(0.4);

        return Column(
          children: [
            NetworkStatusBuilder(
              isConnected: isConnected,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: onCancel,
                  child: Text("Cancelar", style: theme.textTheme.bodyMedium),
                ),
                if (isAbleToSave) ...[
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => (!isConnected) ? null : onSave(),
                    child: Text(
                      "Agregar",
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: onSaveTextColor),
                    ),
                  ),
                ]
              ],
            ),
          ],
        );
      },
    );
  }
}
