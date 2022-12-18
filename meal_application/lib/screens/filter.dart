import 'package:flutter/material.dart';

// Widget
import '../widgets/drawer.dart';

class Filters extends StatefulWidget {
  static const routeName = '/filters';
  final Function storeFilters;
  final Map<String, bool> currentFilter;

  Filters(this.storeFilters, this.currentFilter);

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactosefree = false;

  @override
  void initState() {
    // TODO: implement initState
    _glutenFree = widget.currentFilter['Gluten']!;
    _lactosefree = widget.currentFilter['Lactose']!;
    _vegan = widget.currentFilter['Vegan']!;
    _vegetarian = widget.currentFilter['Vegetarian']!;
    super.initState();
  }

  Widget _buildSwitchList(bool excludeType, String title, String subtitle,
      Function(bool?) updateValue) {
    return SwitchListTile(
        title: Text(title),
        value: excludeType,
        subtitle: Text(subtitle),
        onChanged: updateValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: [
          IconButton(
              onPressed: () {
                Map<String, bool> filters = {
                  'Gluten': _glutenFree,
                  'Lactose': _lactosefree,
                  'Vegan': _vegan,
                  'Vegetarian': _vegetarian,
                };
                widget.storeFilters(filters);
              },
              icon: Icon(Icons.save))
        ],
      ),
      drawer: DrawerTab(),
      body: Column(children: [
        Container(
          padding: EdgeInsets.all(20),
          child: Text(
            'Add filters to your mean selection:',
            style: TextStyle(fontSize: 24, fontFamily: 'RobotoCondensed'),
          ),
        ),
        Expanded(
            child: ListView(
          children: [
            _buildSwitchList(
                _glutenFree, 'Gluten free', 'Exclude food with gluten.',
                (newValue) {
              setState(() {
                _glutenFree = newValue!;
              });
            }),
            _buildSwitchList(
                _lactosefree, 'Lactose free', 'Exclude food with lactose.',
                (newValue) {
              setState(() {
                _lactosefree = newValue!;
              });
            }),
            _buildSwitchList(_vegan, 'Vegan meal', 'Show vegan meals only.',
                (newValue) {
              setState(() {
                _vegan = newValue!;
              });
            }),
            _buildSwitchList(
                _vegetarian, 'Vegetarian meal', 'Show vegetarian meals only.',
                (newValue) {
              setState(() {
                _vegetarian = newValue!;
              });
            }),
          ],
        ))
      ]),
    );
  }
}
