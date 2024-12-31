import 'package:flutter/material.dart';
import 'package:hand_car/core/extension/theme_extension.dart';

class AddressForm extends StatelessWidget {
  const AddressForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TextField(
          decoration: InputDecoration(
            labelText: 'Full name',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: context.space.space_200),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Address line 1',
            hintText: 'Street address, company name, c/o',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: context.space.space_200),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Address line 2',
            hintText: 'Apartment, suite, unit, building, floor, etc.',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: context.space.space_200),
        const TextField(
          decoration: InputDecoration(
            labelText: 'State/Province/Region',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: context.space.space_200),
        Row(
          children: [
            const Expanded(
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'ZIP',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(width: context.space.space_200),
            Expanded(
              child: DropdownButtonFormField(
                decoration: const InputDecoration(
                  labelText: 'Country',
                  border: OutlineInputBorder(),
                ),
                items: const [],
                onChanged: (value) {},
              ),
            ),
          ],
        ),
        SizedBox(height: context.space.space_200),
       
      ],
    );
  }
}
