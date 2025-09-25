import 'package:flutter/material.dart';

class EnglishNumberModel {
  final String letter;
  final String pronunciation;

  EnglishNumberModel({
    required this.letter,
    required this.pronunciation,
  });

  static final List<EnglishNumberModel> letters = [
    EnglishNumberModel(letter: '1', pronunciation: 'One'),
    EnglishNumberModel(letter: '2', pronunciation: 'Two'),
    EnglishNumberModel(letter: '3', pronunciation: 'Three'),
    EnglishNumberModel(letter: '4', pronunciation: 'Four'),
    EnglishNumberModel(letter: '5', pronunciation: 'Five'),
    EnglishNumberModel(letter: '6', pronunciation: 'Six'),
    EnglishNumberModel(letter: '7', pronunciation: 'Seven'),
    EnglishNumberModel(letter: '8', pronunciation: 'Eight'),
    EnglishNumberModel(letter: '9', pronunciation: 'Nine'),
    EnglishNumberModel(letter: '10', pronunciation: 'Ten'),
    EnglishNumberModel(letter: '11', pronunciation: 'Eleven'),
    EnglishNumberModel(letter: '12', pronunciation: 'Twelve'),
    EnglishNumberModel(letter: '13', pronunciation: 'Thirteen'),
    EnglishNumberModel(letter: '14', pronunciation: 'Fourteen'),
    EnglishNumberModel(letter: '15', pronunciation: 'Fifteen'),
    EnglishNumberModel(letter: '16', pronunciation: 'Sixteen'),
    EnglishNumberModel(letter: '17', pronunciation: 'Seventeen'),
    EnglishNumberModel(letter: '18', pronunciation: 'Eighteen'),
    EnglishNumberModel(letter: '19', pronunciation: 'Nineteen'),
    EnglishNumberModel(letter: '20', pronunciation: 'Twenty'),
    EnglishNumberModel(letter: '21', pronunciation: 'Twenty-One'),
    EnglishNumberModel(letter: '22', pronunciation: 'Twenty-Two'),
    EnglishNumberModel(letter: '23', pronunciation: 'Twenty-Three'),
    EnglishNumberModel(letter: '24', pronunciation: 'Twenty-Four'),
    EnglishNumberModel(letter: '25', pronunciation: 'Twenty-Five'),
    EnglishNumberModel(letter: '26', pronunciation: 'Twenty-Six'),
    EnglishNumberModel(letter: '27', pronunciation: 'Twenty-Seven'),
    EnglishNumberModel(letter: '28', pronunciation: 'Twenty-Eight'),
    EnglishNumberModel(letter: '29', pronunciation: 'Twenty-Nine'),
    EnglishNumberModel(letter: '30', pronunciation: 'Thirty'),
    EnglishNumberModel(letter: '31', pronunciation: 'Thirty-One'),
    EnglishNumberModel(letter: '32', pronunciation: 'Thirty-Two'),
    EnglishNumberModel(letter: '33', pronunciation: 'Thirty-Three'),
    EnglishNumberModel(letter: '34', pronunciation: 'Thirty-Four'),
    EnglishNumberModel(letter: '35', pronunciation: 'Thirty-Five'),
    EnglishNumberModel(letter: '36', pronunciation: 'Thirty-Six'),
    EnglishNumberModel(letter: '37', pronunciation: 'Thirty-Seven'),
    EnglishNumberModel(letter: '38', pronunciation: 'Thirty-Eight'),
    EnglishNumberModel(letter: '39', pronunciation: 'Thirty-Nine'),
    EnglishNumberModel(letter: '40', pronunciation: 'Forty'),
    EnglishNumberModel(letter: '41', pronunciation: 'Forty-One'),
    EnglishNumberModel(letter: '42', pronunciation: 'Forty-Two'),
    EnglishNumberModel(letter: '43', pronunciation: 'Forty-Three'),
    EnglishNumberModel(letter: '44', pronunciation: 'Forty-Four'),
    EnglishNumberModel(letter: '45', pronunciation: 'Forty-Five'),
    EnglishNumberModel(letter: '46', pronunciation: 'Forty-Six'),
    EnglishNumberModel(letter: '47', pronunciation: 'Forty-Seven'),
    EnglishNumberModel(letter: '48', pronunciation: 'Forty-Eight'),
    EnglishNumberModel(letter: '49', pronunciation: 'Forty-Nine'),
    EnglishNumberModel(letter: '50', pronunciation: 'Fifty'),
    EnglishNumberModel(letter: '51', pronunciation: 'Fifty-One'),
    EnglishNumberModel(letter: '52', pronunciation: 'Fifty-Two'),
    EnglishNumberModel(letter: '53', pronunciation: 'Fifty-Three'),
    EnglishNumberModel(letter: '54', pronunciation: 'Fifty-Four'),
    EnglishNumberModel(letter: '55', pronunciation: 'Fifty-Five'),
    EnglishNumberModel(letter: '56', pronunciation: 'Fifty-Six'),
    EnglishNumberModel(letter: '57', pronunciation: 'Fifty-Seven'),
    EnglishNumberModel(letter: '58', pronunciation: 'Fifty-Eight'),
    EnglishNumberModel(letter: '59', pronunciation: 'Fifty-Nine'),
    EnglishNumberModel(letter: '60', pronunciation: 'Sixty'),
    EnglishNumberModel(letter: '61', pronunciation: 'Sixty-One'),
    EnglishNumberModel(letter: '62', pronunciation: 'Sixty-Two'),
    EnglishNumberModel(letter: '63', pronunciation: 'Sixty-Three'),
    EnglishNumberModel(letter: '64', pronunciation: 'Sixty-Four'),
    EnglishNumberModel(letter: '65', pronunciation: 'Sixty-Five'),
    EnglishNumberModel(letter: '66', pronunciation: 'Sixty-Six'),
    EnglishNumberModel(letter: '67', pronunciation: 'Sixty-Seven'),
    EnglishNumberModel(letter: '68', pronunciation: 'Sixty-Eight'),
    EnglishNumberModel(letter: '69', pronunciation: 'Sixty-Nine'),
    EnglishNumberModel(letter: '70', pronunciation: 'Seventy'),
    EnglishNumberModel(letter: '71', pronunciation: 'Seventy-One'),
    EnglishNumberModel(letter: '72', pronunciation: 'Seventy-Two'),
    EnglishNumberModel(letter: '73', pronunciation: 'Seventy-Three'),
    EnglishNumberModel(letter: '74', pronunciation: 'Seventy-Four'),
    EnglishNumberModel(letter: '75', pronunciation: 'Seventy-Five'),
    EnglishNumberModel(letter: '76', pronunciation: 'Seventy-Six'),
    EnglishNumberModel(letter: '77', pronunciation: 'Seventy-Seven'),
    EnglishNumberModel(letter: '78', pronunciation: 'Seventy-Eight'),
    EnglishNumberModel(letter: '79', pronunciation: 'Seventy-Nine'),
    EnglishNumberModel(letter: '80', pronunciation: 'Eighty'),
    EnglishNumberModel(letter: '81', pronunciation: 'Eighty-One'),
    EnglishNumberModel(letter: '82', pronunciation: 'Eighty-Two'),
    EnglishNumberModel(letter: '83', pronunciation: 'Eighty-Three'),
    EnglishNumberModel(letter: '84', pronunciation: 'Eighty-Four'),
    EnglishNumberModel(letter: '85', pronunciation: 'Eighty-Five'),
    EnglishNumberModel(letter: '86', pronunciation: 'Eighty-Six'),
    EnglishNumberModel(letter: '87', pronunciation: 'Eighty-Seven'),
    EnglishNumberModel(letter: '88', pronunciation: 'Eighty-Eight'),
    EnglishNumberModel(letter: '89', pronunciation: 'Eighty-Nine'),
    EnglishNumberModel(letter: '90', pronunciation: 'Ninety'),
    EnglishNumberModel(letter: '91', pronunciation: 'Ninety-One'),
    EnglishNumberModel(letter: '92', pronunciation: 'Ninety-Two'),
    EnglishNumberModel(letter: '93', pronunciation: 'Ninety-Three'),
    EnglishNumberModel(letter: '94', pronunciation: 'Ninety-Four'),
    EnglishNumberModel(letter: '95', pronunciation: 'Ninety-Five'),
    EnglishNumberModel(letter: '96', pronunciation: 'Ninety-Six'),
    EnglishNumberModel(letter: '97', pronunciation: 'Ninety-Seven'),
    EnglishNumberModel(letter: '98', pronunciation: 'Ninety-Eight'),
    EnglishNumberModel(letter: '99', pronunciation: 'Ninety-Nine'),
    EnglishNumberModel(letter: '100', pronunciation: 'One Hundred'),
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
