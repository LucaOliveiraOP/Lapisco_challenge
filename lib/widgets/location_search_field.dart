import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lapisco_challenge/blocs/search_city_bloc.dart/search_city_bloc.dart';
import 'package:lapisco_challenge/blocs/search_city_bloc.dart/search_city_event.dart';

class LocationSearchField extends StatefulWidget {
  const LocationSearchField({super.key});

  @override
  State<LocationSearchField> createState() => _LocationSearchFieldState();
}

class _LocationSearchFieldState extends State<LocationSearchField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: 'Digite uma cidade',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            final cityName = _controller.text.trim();
            if (cityName.isNotEmpty) {
              context.read<SearchCityBloc>().add(GetSearchByCity(cityName));
            }
          },
        ),
      ],
    );
  }
}
