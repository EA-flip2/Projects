//import 'package:flutter/material.dart';
import 'package:sms_project_1/objects/contact.dart';
import 'package:uuid/uuid.dart';

class Group {
  Group({required this.name, required this.description})
    : id = const Uuid().v1();
  // Group.addcontact(List<Contact>)
  Group.withContacts({
    required this.name,
    required this.description,
    required List<Contact> initialContacts,
  }) : id = const Uuid().v1(),
       contacts = initialContacts;

  final String name;
  final String description;
  final String id;

  //contacts
  List<Contact> contacts = [];
  //active contacts

  // tools to import contacts
}




/*
   
          */