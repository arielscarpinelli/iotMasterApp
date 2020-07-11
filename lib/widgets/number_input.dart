import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberInputWithIncrementDecrement extends StatefulWidget {
  /// Provide a custom controller.
  final TextEditingController controller;

  /// Minimum value allowed for this field. Defaults to zero.
  final num min;

  /// Maximum value allowed for this field. Defaults to `double.infinity`.
  final num max;

  /// A factor by which the numeric value should be incremented or decremented.
  /// e.g. Setting `incDecFactor=0.5` increments or decrement the number field by 0.5.
  /// Defaults to 1.
  final num incDecFactor;

  /// Initial value for the number input field. Defaults to zero.
  final num initialValue;

  /// Decideds if the field only accepts integer values.
  /// Defaults to true.
  final bool isInt;

  /// Decoration for the TextFormField.
  /// Defaults to a simple outline border.
  final InputDecoration numberFieldDecoration;

  /// Decoration for the whole widget.
  /// defaults to a simple container with rounded border.
  final Decoration widgetContainerDecoration;

  final FormFieldValidator<String> validator;

  /// Icon to be used for Incrment button.
  final IconData incIcon;

  /// Icon to be used for Decrement button.
  final IconData decIcon;

  /// No of digits after decimal point.
  /// Defaults to value of 2 for non int fields.
  /// Should be between 0 and 20 inclusively.
  final int fractionDigits;

  final Widget subtitle;

  NumberInputWithIncrementDecrement({
    @required this.controller,
    this.min = 0,
    this.max = double.infinity,
    this.initialValue = 0,
    this.incDecFactor = 1,
    this.isInt = true,
    this.numberFieldDecoration,
    this.widgetContainerDecoration,
    this.validator,
    this.incIcon = Icons.arrow_drop_up,
    this.decIcon = Icons.arrow_drop_down,
    this.fractionDigits = 2,
    this.subtitle,
  });

  @override
  _NumberInputWithIncrementDecrementState createState() =>
      _NumberInputWithIncrementDecrementState();
}

class _NumberInputWithIncrementDecrementState
    extends State<NumberInputWithIncrementDecrement> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
    //  Setting the initial value for the field.
    _controller.text = widget.isInt
        ? widget.initialValue.toString()
        : widget.initialValue.toStringAsFixed(widget.fractionDigits);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: TextFormField(
        validator: widget.validator,
        decoration: widget.numberFieldDecoration,
        controller: _controller,
        keyboardType: TextInputType.numberWithOptions(
          decimal: !widget.isInt,
          signed: true,
        ),
        inputFormatters: <TextInputFormatter>[
          widget.isInt
              ? WhitelistingTextInputFormatter.digitsOnly
              : WhitelistingTextInputFormatter(
                  RegExp("[0-9.]"),
                )
        ],
      ),
      subtitle: widget.subtitle,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(color: Colors.black),
                )),
            child: InkWell(
              child: Icon(
                widget.incIcon,
              ),
              onTap: () {
                var currentValue = widget.isInt
                    ? int.parse(_controller.text)
                    : double.parse(_controller.text);
                setState(() {
                  currentValue = currentValue + widget.incDecFactor;
                  currentValue =
                  currentValue < widget.max ? currentValue : widget.max;
                  _controller.text = widget.isInt
                      ? currentValue.toString()
                      : currentValue.toStringAsFixed(
                      widget.fractionDigits); // incrementing value
                });
              },
            ),
          ),
          InkWell(
            child: Icon(
              widget.decIcon,
            ),
            onTap: () {
              var currentValue = widget.isInt
                  ? int.parse(_controller.text)
                  : double.parse(_controller.text);
              setState(() {
                currentValue = currentValue - widget.incDecFactor;
                currentValue =
                currentValue > widget.min ? currentValue : widget.min;
                _controller.text = widget.isInt
                    ? currentValue.toString()
                    : currentValue.toStringAsFixed(
                    widget.fractionDigits); // decrementing value
              });
            },
          ),
        ],
      ),
    );
  }
}
