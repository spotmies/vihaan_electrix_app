import 'dart:convert';

class OnboardingModel {
  String? image;
  String? text;
  String? title;

  OnboardingModel({this.image, this.text, this.title});
  static List<OnboardingModel> list = [
    OnboardingModel(
        image: "assets/pngs/vebond.png", title: "Step 3", text: "Description"),
    OnboardingModel(
        image: "assets/pngs/apmap.png", title: "Step 1", text: "Description"),
    OnboardingModel(
        image: "assets/pngs/charginglocation.png",
        title: "Step 2",
        text: "Description"),
    
  ];

  OnboardingModel copyWith({
    String? image,
    String? text,
    String? title,
  }) {
    return OnboardingModel(
      image: image ?? this.image,
      text: text ?? this.text,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'text': text,
      'title': title,
    };
  }

  factory OnboardingModel.fromMap(Map<String, dynamic> map) {
    return OnboardingModel(
      image: map['image'] != null ? map['image']! : null,
      text: map['text'] != null ? map['text']! : null,
      title: map['title'] != null ? map['title']! : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OnboardingModel.fromJson(String source) =>
      OnboardingModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'OnboardingModel(image: $image, text: $text, title: $title)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OnboardingModel &&
        other.image == image &&
        other.text == text &&
        other.title == title;
  }

  @override
  int get hashCode => image.hashCode ^ text.hashCode ^ title.hashCode;
}
