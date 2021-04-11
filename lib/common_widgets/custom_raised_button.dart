import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  final String label;
  final Color color;
  final Color onPrimary;
  final VoidCallback onPressed;
  final double height;
  final String asset;

  const CustomRaisedButton({
    Key key,
    @required this.label,
    @required this.color,
    @required this.onPressed,
    @required this.onPrimary,
    this.height: 40.0,
    this.asset: "",
  })  : assert(
          label != null,
          color != null,
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        child: asset != ""
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(asset),
                  Text(label),
                  Opacity(opacity: 1)
                ],
              )
            : Text(label),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(4.0),
            ),
          ),
          primary: color,
          onPrimary: onPrimary,
          onSurface: Colors.black54,
          textStyle: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
