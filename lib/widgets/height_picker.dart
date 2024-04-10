import 'package:flutter/material.dart';

class HeightPicker extends StatefulWidget {
  final double heightInCentimeters;
  final bool isMetric;
  final ValueChanged<double> onChanged;

  const HeightPicker({
    Key? key,
    required this.heightInCentimeters,
    this.isMetric = false, // Default to Imperial
    required this.onChanged,
  }) : super(key: key);

  @override
  State<HeightPicker> createState() => _HeightPickerState();
}

class _HeightPickerState extends State<HeightPicker> {
  late TextEditingController _feetController;
  late TextEditingController _inchesController;
  late TextEditingController _cmController;
  late double _heightInCentimeters;

  @override
  void initState() {
    super.initState();
    _heightInCentimeters = widget.heightInCentimeters;
    _updateControllers(_heightInCentimeters);
  }

  @override
  void didUpdateWidget(covariant HeightPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.heightInCentimeters != oldWidget.heightInCentimeters) {
      _heightInCentimeters = widget.heightInCentimeters;
      _updateControllers(_heightInCentimeters);
    }
  }

  void _updateControllers(double heightInCentimeters) {
    final feet = (heightInCentimeters / 30.48).floor();
    final inches = ((heightInCentimeters % 30.48) / 2.54).round();
    _feetController = TextEditingController(text: '$feet');
    _inchesController = TextEditingController(text: '$inches');
    _cmController =
        TextEditingController(text: heightInCentimeters.toStringAsFixed(0));
  }

  @override
  void dispose() {
    _feetController.dispose();
    _inchesController.dispose();
    _cmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!widget.isMetric)
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _feetController,
                  decoration: const InputDecoration(labelText: 'Feet'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    final feet = int.tryParse(value) ?? 0;
                    final inches = int.tryParse(_inchesController.text) ?? 0;
                    _heightInCentimeters = ((feet * 12) + inches) * 2.54;
                    widget.onChanged(_heightInCentimeters);
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  controller: _inchesController,
                  decoration: const InputDecoration(labelText: 'Inches'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    final inches = int.tryParse(value) ?? 0;
                    final feet = int.tryParse(_feetController.text) ?? 0;
                    _heightInCentimeters = ((feet * 12) + inches) * 2.54;
                    widget.onChanged(_heightInCentimeters);
                  },
                ),
              ),
            ],
          )
        else
          TextFormField(
            controller: _cmController,
            decoration: const InputDecoration(labelText: 'Centimeters'),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              _heightInCentimeters =
                  double.tryParse(value) ?? _heightInCentimeters;
              widget.onChanged(_heightInCentimeters);
            },
          ),
      ],
    );
  }
}
