import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_watt_app/features/common/presentation/blocs/connector_types_bloc/connector_types_bloc.dart';
import 'package:i_watt_app/features/common/presentation/widgets/filter_category_title.dart';
import 'package:i_watt_app/features/common/presentation/widgets/filter_tile.dart';

class ConnectorTypesList extends StatefulWidget {
  final List<int> defaultSelectedTypes;
  final ValueChanged<List<int>> onChanged;
  const ConnectorTypesList({
    super.key,
    required this.defaultSelectedTypes,
    required this.onChanged,
  });

  @override
  State<ConnectorTypesList> createState() => _ConnectorTypesListState();
}

class _ConnectorTypesListState extends State<ConnectorTypesList> {
  late final ValueNotifier<List<int>> connectorTypes;
  @override
  void initState() {
    super.initState();
    connectorTypes = ValueNotifier<List<int>>([]);
    connectorTypes.value = [...widget.defaultSelectedTypes];
  }

  @override
  void didUpdateWidget(covariant ConnectorTypesList oldWidget) {
    connectorTypes.value = [...widget.defaultSelectedTypes];
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectorTypesBloc, ConnectorTypesState>(builder: (ctx, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 0, 0),
            child: FilterCategoryTitle(title: 'AC:'),
          ),
          ...List.generate(
            state.acConnectionTypes.length,
            (index) {
              final connector = state.acConnectionTypes[index];
              return ValueListenableBuilder<List<int>>(
                valueListenable: connectorTypes,
                builder: (context, v, child) {
                  return FilterTile(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    includeIcon: true,
                    hasDivider: index != state.acConnectionTypes.length - 1,
                    title: connector.name,
                    isSelectedDefault: connectorTypes.value.contains(connector.id),
                    onSwitch: (val) {
                      if (val) {
                        connectorTypes.value = [...connectorTypes.value, connector.id];
                      } else {
                        connectorTypes.value.remove(connector.id);
                        connectorTypes.value = [...connectorTypes.value];
                      }
                      widget.onChanged(connectorTypes.value);
                    },
                  );
                },
              );
            },
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 0, 0),
            child: FilterCategoryTitle(title: 'DC:'),
          ),
          ...List.generate(
            state.dcConnectionTypes.length,
            (index) {
              final connector = state.dcConnectionTypes[index];
              return ValueListenableBuilder<List<int>>(
                valueListenable: connectorTypes,
                builder: (context, v, child) {
                  return FilterTile(
                    hasDivider: index != state.dcConnectionTypes.length - 1,
                    includeIcon: true,
                    title: connector.name,
                    isSelectedDefault: connectorTypes.value.contains(connector.id),
                    onSwitch: (val) {
                      if (val) {
                        connectorTypes.value = [...connectorTypes.value, connector.id];
                      } else {
                        connectorTypes.value.remove(connector.id);
                        connectorTypes.value = [...connectorTypes.value];
                      }
                      widget.onChanged(connectorTypes.value);
                    },
                  );
                },
              );
            },
          )
        ],
      );
    });
  }
}
