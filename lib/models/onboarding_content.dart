class OnboardingContent {
  String? image;
  String? title;
  String? discription;

  OnboardingContent({this.image, this.title, this.discription});
}

List<OnboardingContent> contents = [
  OnboardingContent(
      title: "Welcome to SheCan",
      image: 'assets/images/intro_a.svg',
      discription:
          "View the list of courses and select the one you wish to study."),
  OnboardingContent(
      title: "Anytime, Anywhere",
      image: 'assets/images/intro_b.svg',
      discription: "Get updated with latest news and articles"),
  OnboardingContent(
      title: "Be Informed",
      image: 'assets/images/intro_c.svg',
      discription: "Get notified whenever new contents are added to the app"),
];
