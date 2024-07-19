import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mealapp/screens/taps.dart';
import 'package:mealapp/widgets/main_drawer.dart';
import 'package:mealapp/providers/filters_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FiltersScreen extends ConsumerStatefulWidget {
  const FiltersScreen({super.key});

  @override
  ConsumerState<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends ConsumerState<FiltersScreen> {
  var _gluttenFreeFilterSet = false;
  var _vegetarianFilterSet = false;
  var _veganFilterSet = false;
  var _lactoseFreeFilterSet = false;

  @override
  void initState() {
    super.initState();
    final activeFilters = ref.read(filterProvider);
    _gluttenFreeFilterSet = activeFilters[Filter.glutenFree]!;
    _vegetarianFilterSet = activeFilters[Filter.vegetarian]!;
    _veganFilterSet = activeFilters[Filter.vegan]!;
    _lactoseFreeFilterSet = activeFilters[Filter.lactoseFree]!;
  }

  Future<bool> _onWillPop() async {
    ref.read(filterProvider.notifier).setFilters({
      Filter.glutenFree: _gluttenFreeFilterSet,
      Filter.vegetarian: _vegetarianFilterSet,
      Filter.vegan: _veganFilterSet,
      Filter.lactoseFree: _lactoseFreeFilterSet,
    });
    return false;
  }

  void _saveFilters() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('glutenFree', _gluttenFreeFilterSet);
    prefs.setBool('vegetarian', _vegetarianFilterSet);
    prefs.setBool('vegan', _veganFilterSet);
    prefs.setBool('lactoseFree', _lactoseFreeFilterSet);
  }

  void _updateFilter(Filter filter, bool value) {
    setState(() {
      switch (filter) {
        case Filter.glutenFree:
          _gluttenFreeFilterSet = value;
          break;
        case Filter.vegetarian:
          _vegetarianFilterSet = value;
          break;
        case Filter.vegan:
          _veganFilterSet = value;
          break;
        case Filter.lactoseFree:
          _lactoseFreeFilterSet = value;
          break;
      }
      _saveFilters();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Your Filters'),
        ),
        drawer: MainDrawer(
          onSelectScreen: (identifier) {
            Navigator.of(context).pop();
            if (identifier == 'meals') {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => const TapScreen(),
                ),
              );
            }
          },
        ),
        body: Column(children: [
          SwitchListTile(
            value: _gluttenFreeFilterSet,
            onChanged: (isChecked) =>
                _updateFilter(Filter.glutenFree, isChecked),
            title: Text(
              'Gluten Free',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            subtitle: Text(
              'Only include gluten-free meals.',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 32, right: 22),
          ),
          SwitchListTile(
            value: _vegetarianFilterSet,
            onChanged: (isChecked) =>
                _updateFilter(Filter.vegetarian, isChecked),
            title: Text(
              'Vegetarian',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            subtitle: Text(
              'Only include vegetarian meals.',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 32, right: 22),
          ),
          SwitchListTile(
            value: _lactoseFreeFilterSet,
            onChanged: (isChecked) =>
                _updateFilter(Filter.lactoseFree, isChecked),
            title: Text(
              'Lactose Free',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            subtitle: Text(
              'Only include lactose-free meals.',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 32, right: 22),
          ),
          SwitchListTile(
            value: _veganFilterSet,
            onChanged: (isChecked) => _updateFilter(Filter.vegan, isChecked),
            title: Text(
              'Vegan',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            subtitle: Text(
              'Only include vegan meals.',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 32, right: 22),
          ),
        ]),
      ),
    );
  }
}
