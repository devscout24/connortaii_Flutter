import 'dart:ui';

import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:flutter/material.dart';

final months = [
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December",
];
final years = List.generate(10, (index) => (2020 + index).toString());

final List<Map<String, String>> faqList = [
  {
    'question': 'What is Trigger Cut?',
    'answer':
        'Trigger Cut is a mobile app that blocks distractions based on your behavior ( apps used, times, etc. )',
  },
  {
    'question': 'What devices does the app run on?',
    'answer':
        'Trigger Cut is a mobile app that blocks distractions based on your behavior ( apps used, times, etc. )',
  },
  {
    'question': "What can I do if I can't find an app in the list?",
    'answer':
        'Trigger Cut is a mobile app that blocks distractions based on your behavior ( apps used, times, etc. )',
  },
  {
    'question': "How do I delete my account?",
    'answer':
        'Trigger Cut is a mobile app that blocks distractions based on your behavior ( apps used, times, etc. )',
  },
];

List<String> timeOptions = [
  '06:00 AM',
  '07:00 AM',
  '08:00 AM',
  '09:00 AM',
  '10:00 AM',
  '11:00 AM',
  '12:00 PM',
  '01:00 PM',
  '02:00 PM',
  '03:00 PM',
  '04:00 PM',
  '05:00 PM',
  '06:00 PM',
  '07:00 PM',
  '08:00 PM',
  '09:00 PM',
  '10:00 PM',
];

final genderOptions = ['Male', 'Female', 'Unknown'];
// List of reasons
final List<String> reasonsForQuitList = [
  'For my health',
  'To save money',
  'For my family',
];

final List<String> subscriptionItemsList = [
  'Ai Coach Chat',
  'Breathing Exercise',
  'Access Community Post',
  'Access All Lessons',
];

final List<String> categoryItemsList = ['All', 'Woman', 'Man', 'Kids', 'More'];

final List<String> clothSizeList = ['XS', 'S', 'M', 'L', 'XL'];

final List<Color> clothColorList = [
  AppColors.green500,
  AppColors.blue500,
  AppColors.red500,
  AppColors.grey600,
];

final List<String> sliderImages = [
  'https://img.freepik.com/premium-photo/photocomposition-horizontal-shopping-banner-with-woman-big-smartphone_23-2151201773.jpg',
  'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/fashion-sale-banner-template-design-389dc7a74f096738d1d425314404a2cd_screen.jpg?ts=1605613724',
  'https://st4.depositphotos.com/6923920/41187/i/450/depositphotos_411876658-stock-photo-fashion-sale-banner-design-template.jpg',
  'https://img.freepik.com/premium-vector/summer-fashion-sale-banner-design-template_2239-1174.jpg',
];

final List<String> trendingItemList = [
  'https://images.unsplash.com/photo-1636533071235-2e2177c0d50e?q=80&w=764&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  'https://images.unsplash.com/photo-1580764194528-6a4158e3dab0?q=80&w=764&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  'https://images.unsplash.com/photo-1611261964848-0c4f5a76b445?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  'https://images.unsplash.com/photo-1514311548104-ae305aac4688?q=80&w=764&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  'https://images.unsplash.com/photo-1608366558876-185ea88608eb?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  'https://images.unsplash.com/photo-1602900017550-29f90329765b?q=80&w=715&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
];

List<Map<String, dynamic>> cartItems = [
  {
    "imageUrl":
        "https://5.imimg.com/data5/WD/MA/MY-5511146/men-s-cotton-pant-500x500.jpg",
    "title": "Fabric Jeans Pant",
    "size": "XL",
    "price": "375.00",
    "color": AppColors.red500,
    "quantity": 1,
  },
  {
    "imageUrl":
        "https://5.imimg.com/data5/WD/MA/MY-5511146/men-s-cotton-pant-500x500.jpg",
    "title": "Premium Jeans",
    "size": "L",
    "price": "399.00",
    "color": AppColors.blue500,
    "quantity": 2,
  },
  {
    "imageUrl":
        "https://5.imimg.com/data5/WD/MA/MY-5511146/men-s-cotton-pant-500x500.jpg",
    "title": "Denim Jeans",
    "size": "M",
    "price": "350.00",
    "color": AppColors.green500,
    "quantity": 1,
  },
];
