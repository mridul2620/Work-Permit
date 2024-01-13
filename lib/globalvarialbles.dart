import 'package:flutter/material.dart';

const maincolor = Color(0xFF6E45FF);
const bodyColor = Color(0xFFE1E1E1);
const yellowColor = Color(0xFF9EFF00);

const gradientColor1 = Color(0xff0f17ad);
const gradientColor2 = Color(0xFF6985e8);

const baseAPI = "https://workpermit.safetycircle.in/api/";
const baseUrl = "https://workpermit.safetycircle.in/";

const questionAPI = "question";
const category_list = "category-list";
const videoApi = "get-videos-list";
const sendPermit = "work-permit";
const extensionAPI = "work-permit-extension";
const statusUpdateAPI = 'update-work-permit';
const registerAPI = "register";
const sendQueryAPI = "upgrade-query";

List imageList = [
  {"id": 1, "image_path": 'assets/images/home.png'},
  {"id": 2, "image_path": 'assets/images/home.png'},
  {"id": 3, "image_path": 'assets/images/home.png'}
];

String dropdownvalue = 'in-progress';
String completed = 'completed';

// List of items in our dropdown menu
var items = [
  'completed',
  'in-progress',
];

String selectedFilter = 'All'; // Default filter

const List<String> filterOptions = [
  'All',
  'Pending',
  'Approved',
  'Extension',
  'Declined',
  'In-Progress',
  'Completed',
  'Closed'
];
