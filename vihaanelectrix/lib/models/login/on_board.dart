class OnboardingModel {
  String? image;
  String? text;
  String? title;

  OnboardingModel({this.image, this.text, this.title});
  static List<OnboardingModel> list = [
    OnboardingModel(
        image: "assets/dummy.svg", title: "Step 1", text: "Description"),
    OnboardingModel(
        image: "assets/dummy.svg", title: "Step 2", text: "Description"),
    OnboardingModel(
        image: "assets/dummy.svg", title: "Step 3", text: "Description"),
    OnboardingModel(
        image: "assets/dummy.svg", title: "Step 4", text: "Description")
  ];
}
