import 'dart:convert';
import 'package:flutter/services.dart';

class Order {
  final String id;
  final bool isActive;
  final double price;
  final String company;
  final String picture;
  final String buyer;
  final List<String> tags;
  final String status;
  final DateTime registered;

  Order({
    required this.id,
    required this.isActive,
    required this.price,
    required this.company,
    required this.picture,
    required this.buyer,
    required this.tags,
    required this.status,
    required this.registered,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      isActive: json['isActive'],
      price: double.parse(json['price'].replaceAll(RegExp(r'[^\d.]'), '')),
      company: json['company'],
      picture: json['picture'],
      buyer: json['buyer'],
      tags: List<String>.from(json['tags']),
      status: json['status'],
      registered: DateTime.parse(json['registered']),
    );
  }
}

Future<List<Order>> fetchOrders() async {
  final jsonString = await rootBundle.loadString('assets/jsons/orders.json');
  final List<dynamic> jsonData = jsonDecode(jsonString);
  return jsonData.map((json) => Order.fromJson(json)).toList();
}
