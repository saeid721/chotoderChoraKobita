import 'package:flutter/material.dart';

class BanglaNumberModel {
  final String letter;
  final String pronunciation;

  BanglaNumberModel({
    required this.letter,
    required this.pronunciation,
  });

  static final List<BanglaNumberModel> letters = [
    BanglaNumberModel(letter: '১', pronunciation: 'এক'),
    BanglaNumberModel(letter: '২', pronunciation: 'দুই'),
    BanglaNumberModel(letter: '৩', pronunciation: 'তিন'),
    BanglaNumberModel(letter: '৪', pronunciation: 'চার'),
    BanglaNumberModel(letter: '৫', pronunciation: 'পাঁচ'),
    BanglaNumberModel(letter: '৬', pronunciation: 'ছয়'),
    BanglaNumberModel(letter: '৭', pronunciation: 'সাত'),
    BanglaNumberModel(letter: '৮', pronunciation: 'আট'),
    BanglaNumberModel(letter: '৯', pronunciation: 'নয়'),
    BanglaNumberModel(letter: '১০', pronunciation: 'দশ'),
    BanglaNumberModel(letter: '১১', pronunciation: 'এগারো'),
    BanglaNumberModel(letter: '১২', pronunciation: 'বারো'),
    BanglaNumberModel(letter: '১৩', pronunciation: 'তেরো'),
    BanglaNumberModel(letter: '১৪', pronunciation: 'চৌদ্দ'),
    BanglaNumberModel(letter: '১৫', pronunciation: 'পনেরো'),
    BanglaNumberModel(letter: '১৬', pronunciation: 'ষোল'),
    BanglaNumberModel(letter: '১৭', pronunciation: 'সতেরো'),
    BanglaNumberModel(letter: '১৮', pronunciation: 'আঠারো'),
    BanglaNumberModel(letter: '১৯', pronunciation: 'উনিশ'),
    BanglaNumberModel(letter: '২০', pronunciation: 'বিশ'),
    BanglaNumberModel(letter: '২১', pronunciation: 'একুশ'),
    BanglaNumberModel(letter: '২২', pronunciation: 'বাইশ'),
    BanglaNumberModel(letter: '২৩', pronunciation: 'তেইশ'),
    BanglaNumberModel(letter: '২৪', pronunciation: 'চব্বিশ'),
    BanglaNumberModel(letter: '২৫', pronunciation: 'পঁচিশ'),
    BanglaNumberModel(letter: '২৬', pronunciation: 'ছাব্বিশ'),
    BanglaNumberModel(letter: '২৭', pronunciation: 'সাতাশ'),
    BanglaNumberModel(letter: '২৮', pronunciation: 'আঠাশ'),
    BanglaNumberModel(letter: '২৯', pronunciation: 'ঊনত্রিশ'),
    BanglaNumberModel(letter: '৩০', pronunciation: 'ত্রিশ'),
    BanglaNumberModel(letter: '৩১', pronunciation: 'একত্রিশ'),
    BanglaNumberModel(letter: '৩২', pronunciation: 'বত্রিশ'),
    BanglaNumberModel(letter: '৩৩', pronunciation: 'তেত্রিশ'),
    BanglaNumberModel(letter: '৩৪', pronunciation: 'চৌত্রিশ'),
    BanglaNumberModel(letter: '৩৫', pronunciation: 'পঁয়ত্রিশ'),
    BanglaNumberModel(letter: '৩৬', pronunciation: 'ছত্রিশ'),
    BanglaNumberModel(letter: '৩৭', pronunciation: 'সাঁইত্রিশ'),
    BanglaNumberModel(letter: '৩৮', pronunciation: 'আটত্রিশ'),
    BanglaNumberModel(letter: '৩৯', pronunciation: 'ঊনচল্লিশ'),
    BanglaNumberModel(letter: '৪০', pronunciation: 'চল্লিশ'),
    BanglaNumberModel(letter: '৪১', pronunciation: 'একচল্লিশ'),
    BanglaNumberModel(letter: '৪২', pronunciation: 'বিয়াল্লিশ'),
    BanglaNumberModel(letter: '৪৩', pronunciation: 'তেতাল্লিশ'),
    BanglaNumberModel(letter: '৪৪', pronunciation: 'চুয়াল্লিশ'),
    BanglaNumberModel(letter: '৪৫', pronunciation: 'পঁয়তাল্লিশ'),
    BanglaNumberModel(letter: '৪৬', pronunciation: 'ছয়াল্লিশ'),
    BanglaNumberModel(letter: '৪৭', pronunciation: 'সাতচল্লিশ'),
    BanglaNumberModel(letter: '৪৮', pronunciation: 'আটচল্লিশ'),
    BanglaNumberModel(letter: '৪৯', pronunciation: 'ঊনপঞ্চাশ'),
    BanglaNumberModel(letter: '৫০', pronunciation: 'পঞ্চাশ'),
    BanglaNumberModel(letter: '৫১', pronunciation: 'একান্ন'),
    BanglaNumberModel(letter: '৫২', pronunciation: 'বায়ান্ন'),
    BanglaNumberModel(letter: '৫৩', pronunciation: 'তিপ্পান্ন'),
    BanglaNumberModel(letter: '৫৪', pronunciation: 'চুয়ান্ন'),
    BanglaNumberModel(letter: '৫৫', pronunciation: 'পঞ্চান্ন'),
    BanglaNumberModel(letter: '৫৬', pronunciation: 'ছাপ্পান্ন'),
    BanglaNumberModel(letter: '৫৭', pronunciation: 'সাতান্ন'),
    BanglaNumberModel(letter: '৫৮', pronunciation: 'আটান্ন'),
    BanglaNumberModel(letter: '৫৯', pronunciation: 'ঊনষাট'),
    BanglaNumberModel(letter: '৬০', pronunciation: 'ষাট'),
    BanglaNumberModel(letter: '৬১', pronunciation: 'একষট্টি'),
    BanglaNumberModel(letter: '৬২', pronunciation: 'বাষট্টি'),
    BanglaNumberModel(letter: '৬৩', pronunciation: 'তেষট্টি'),
    BanglaNumberModel(letter: '৬৪', pronunciation: 'চৌষট্টি'),
    BanglaNumberModel(letter: '৬৫', pronunciation: 'পঁয়ষট্টি'),
    BanglaNumberModel(letter: '৬৬', pronunciation: 'ছয়ষট্টি'),
    BanglaNumberModel(letter: '৬৭', pronunciation: 'সাতষট্টি'),
    BanglaNumberModel(letter: '৬৮', pronunciation: 'আটষট্টি'),
    BanglaNumberModel(letter: '৬৯', pronunciation: 'ঊনসত্তর'),
    BanglaNumberModel(letter: '৭০', pronunciation: 'সত্তর'),
    BanglaNumberModel(letter: '৭১', pronunciation: 'একাত্তর'),
    BanglaNumberModel(letter: '৭২', pronunciation: 'বায়াত্তর'),
    BanglaNumberModel(letter: '৭৩', pronunciation: 'তিয়াত্তর'),
    BanglaNumberModel(letter: '৭৪', pronunciation: 'চুয়াত্তর'),
    BanglaNumberModel(letter: '৭৫', pronunciation: 'পঁচাত্তর'),
    BanglaNumberModel(letter: '৭৬', pronunciation: 'ছিয়াত্তর'),
    BanglaNumberModel(letter: '৭৭', pronunciation: 'সাতাত্তর'),
    BanglaNumberModel(letter: '৭৮', pronunciation: 'আটাত্তর'),
    BanglaNumberModel(letter: '৭৯', pronunciation: 'ঊনআশি'),
    BanglaNumberModel(letter: '৮০', pronunciation: 'আশি'),
    BanglaNumberModel(letter: '৮১', pronunciation: 'একাশি'),
    BanglaNumberModel(letter: '৮২', pronunciation: 'বায়াশি'),
    BanglaNumberModel(letter: '৮৩', pronunciation: 'তিরাশি'),
    BanglaNumberModel(letter: '৮৪', pronunciation: 'চুরাশি'),
    BanglaNumberModel(letter: '৮৫', pronunciation: 'পঁচাশি'),
    BanglaNumberModel(letter: '৮৬', pronunciation: 'ছিয়াশি'),
    BanglaNumberModel(letter: '৮৭', pronunciation: 'সাতাশি'),
    BanglaNumberModel(letter: '৮৮', pronunciation: 'আটাশি'),
    BanglaNumberModel(letter: '৮৯', pronunciation: 'ঊননব্বই'),
    BanglaNumberModel(letter: '৯০', pronunciation: 'নব্বই'),
    BanglaNumberModel(letter: '৯১', pronunciation: 'একানব্বই'),
    BanglaNumberModel(letter: '৯২', pronunciation: 'বানব্বই'),
    BanglaNumberModel(letter: '৯৩', pronunciation: 'তিরানব্বই'),
    BanglaNumberModel(letter: '৯৪', pronunciation: 'চুরানব্বই'),
    BanglaNumberModel(letter: '৯৫', pronunciation: 'পঁচানব্বই'),
    BanglaNumberModel(letter: '৯৬', pronunciation: 'ছিয়ানব্বই'),
    BanglaNumberModel(letter: '৯৭', pronunciation: 'সাতানব্বই'),
    BanglaNumberModel(letter: '৯৮', pronunciation: 'আটানব্বই'),
    BanglaNumberModel(letter: '৯৯', pronunciation: 'নিরানব্বই'),
    BanglaNumberModel(letter: '১০০', pronunciation: 'একশো'),
  ];
}

// Particle Model for Effects
class ParticleEffect {
  double x;
  double y;
  double vx;
  double vy;
  double size;
  Color color;
  double life;
  final double maxLife;
  final String emoji;

  ParticleEffect({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.size,
    required this.color,
    required this.maxLife,
    required this.emoji,
  }) : life = maxLife;
}
