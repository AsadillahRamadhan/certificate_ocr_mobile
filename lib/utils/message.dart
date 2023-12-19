import 'package:flutter/material.dart';
class Message{
  void message(BuildContext context, final String message) async {
  await ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                behavior: SnackBarBehavior.floating,
                                content: Text(message),
                                duration: Duration(seconds: 2),
                              ),
                            );
}
}