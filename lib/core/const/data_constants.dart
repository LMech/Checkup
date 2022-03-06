import 'package:checkup/core/const/path_constants.dart';
import 'package:checkup/core/const/text_constants.dart';
import 'package:checkup/data/features_data.dart';
import 'package:checkup/screens/onboarding/widget/onboarding_tile.dart';
import 'package:flutter/material.dart';

class DataConstants {
  // Onboarding
  static final onboardingTiles = [
    const OnboardingTile(
      title: TextConstants.onboarding1Title,
      mainText: TextConstants.onboarding1Description,
      imagePath: PathConstants.onboarding1,
    ),
    const OnboardingTile(
      title: TextConstants.onboarding2Title,
      mainText: TextConstants.onboarding2Description,
      imagePath: PathConstants.onboarding2,
    ),
    const OnboardingTile(
      title: TextConstants.onboarding3Title,
      mainText: TextConstants.onboarding3Description,
      imagePath: PathConstants.onboarding3,
    ),
  ];

  static final List<FeaturesData> homeFeatures = [
    FeaturesData(
      icon: Icons.assignment_ind_outlined,
      title: TextConstants.reportFeatureTitle,
      description: TextConstants.reportFeatureDescription,
    ),
    FeaturesData(
      icon: Icons.camera_alt_outlined,
      title: TextConstants.oximeterFeatureTitle,
      description: TextConstants.oximeterFeatureDescription,
    ),
  ];
}
