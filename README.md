
# BuiltBuddy

_Work in progress_

BuiltBuddy is a comprehensive Flutter application designed for fitness enthusiasts who wish to track their progress, set fitness goals, and personalize their fitness journey. The app offers a user-friendly interface for logging workouts, monitoring progress over time, and customizing fitness plans. With a focus on inclusivity and flexibility, BuiltBuddy supports various measurement systems and integrates seamlessly with Firebase to manage user profiles and data securely.

## Getting Started

### Prerequisites

- Flutter SDK
- Dart SDK
- Firebase SDK
- Android Studio or VS Code with Flutter plugins installed

### Installation

1. Clone the repository:
```git clone https://github.com/traftonrey/power_tracker.git```

2. Install Flutter dependencies:
```flutter pub get```

3. Configure firebase:
- Follow the instructions on the Firebase console to add your project.
- Download the google-services.json (for Android) and GoogleService-Info.plist (for iOS) and place them in the respective directories.

3. Run the app:
```flutter run```

## Usage

_Work in progress_

BuiltBuddy is designed to be intuitive and easy to use:

- **Complete Your Profile**: New users will be prompted to complete their profile, including selecting preferred units (metric or imperial) for measurements such as height and weight.

- **Track Your Workouts**: Log each workout session with details such as type of exercise, duration, and intensity.

- **Set Goals and Monitor Progress**: Set fitness goals and track your progress over time through visual graphs and summaries.

- **Customize Your Fitness Plan**: Adjust your workout plans based on your progress and goals.

## Contributing

Contributions are what make the open-source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

_Work in progress_
Distributed under the Apache License 2.0. See `LICENSE` for more information.

## Contact

Trafton Reynolds - [@traftonrey](https://twitter.com/traftonrey) - reynoldstrafton@gmail.com

Project Link: [https://github.com/traftonrey/power_tracker](https://github.com/traftonrey/power_tracker)

## Acknowledgments

- Flutter documentation and community for guidance.
- Firebase for providing a comprehensive backend solution.
- All contributors who have helped to make this project better.

## Future Plans

### Social Aspect
App will give users ability to add friends. Friends will be able to:
-  View each others created workouts
- Check in on their recent gym activity (introducing a social responsibility aspect)
- Challeng

### Workout generation
- Either come up with a formula, or use AI to select exercises based on a user's height, weight, sex, other data if applicable.
- Most importantly, for this, we'll use recent workout data if it exists. Take user feedback on intensity, and let them report injury to adjust generated workouts.

### Premade workouts
- Have a number of premade workout programs available in the app. Maybe a PPL split, upper/lower, HIIT, for example.

### More workout types
- Include things like yoga, crossfit, etc.
- Maybe even little PT workouts for common injuries, disclaimer definitely needed, legal disclaimer might be needed if this was ever to be released to public

### At-home workouts
- Hand in hand with more workout types and workout generation, be able to generate workouts that users can do without the use of any gym equipment.

### Fitness ecosystem integrations
- Be able to use data from apple and other smart watches
- Be able to connect with health app, android equivalent if it exists

### Nutrition Advice
- Self-explanatory, but just articles and maybe some nutrition plans that users can follow

### Accessibility Features
- Make application accessible to all users
- - Voice commands
- - Screen reader support
- - Customizable interface options
- - Dark mode

### Monetization Strategies
I want to stay away from subscriptions. I feel like there is a big market of people that are willing to pay for premium fitness apps but don't want to pay the same amount as their monthly gym membership for access.

- One-time purchase
- - Offer a sort of free trial, then hide prominent features behind a one-time paywall

- In-App Advertisements
- - Have a portion of the screen taken up by an ad-bar, would definitely exist for free accounts if above method is used. Even if the ads don't make money, users will consider buying to get rid of them

- Affiliate Marketing and Partnerships
- - Of course, this is only really applicable to if we release the app and it takes off, but we could partner with fitness equipment brands, supplement suppliers, fitness clothing brands to offer discounts and promotions