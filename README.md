# Neobis_iOS_Auth

An iOS app centered on efficient user authentication, streamlining the login process for both existing and new users.

<img width="200" height="400" align="center" alt="1_launchScreen" src="https://github.com/iPakTulane/Neobis_iOS_Auth/assets/117035210/2c12d72f-7093-4954-b503-153d2e62bdb8">

## Description

The authentication module is a critical component of any app, ensuring users can securely access their accounts and enjoy a seamless experience. It encompasses features such as login, registration, email confirmation, and successful login/logout actions, with a strong emphasis on data privacy and user convenience.

## Design

<img width="400" height="400" align="center" alt="2_Screenshot 2023-12-08 at 12 11 01" src="https://github.com/iPakTulane/Neobis_iOS_Auth/assets/117035210/80c1b5d8-d3aa-46e5-ae10-129a8fa345eb">

<img width="400" height="400" align="center" alt="3_Screenshot 2023-12-08 at 12 12 44" src="https://github.com/iPakTulane/Neobis_iOS_Auth/assets/117035210/67ade981-7485-49c9-ae27-7cb39abac6e6">

<img width="400" height="400" align="center" alt="4_Screenshot 2023-12-08 at 12 13 13" src="https://github.com/iPakTulane/Neobis_iOS_Auth/assets/117035210/caa7880a-e406-41bf-ae83-596ceb76dd70">

<img width="400" height="400" align="center" alt="5_Screenshot 2023-12-08 at 12 14 54" src="https://github.com/iPakTulane/Neobis_iOS_Auth/assets/117035210/e56d1ed5-5907-48b9-a609-ca8583111e93">

<img width="400" height="400" align="center" alt="6_Screenshot 2023-12-08 at 12 15 26" src="https://github.com/iPakTulane/Neobis_iOS_Auth/assets/117035210/d36bf084-91ff-4626-9e2e-80701129083b">

## Architectural Pattern

The authentication module adheres to a modular architecture, specifically implementing the MVVM (Model-View-ViewModel) pattern. This choice ensures clean code organization, maintainability, and scalability for the entire platform.

## Frameworks

The authentication module leverages the following frameworks:

- **SnapKit:** A concise Auto Layout DSL to simplify the layout code.
- **NetworkService:** Facilitates communication with the server.
- **JSON:** Handles JSON parsing for data interchange.
- **URL Session:** Manages HTTP requests for API communication.
- **HTTP Requests:** Executes various HTTP requests to interact with the server.

## How to Use

Navigate through the authentication module with ease using the following steps:

### Login
- Input your username and password.
- Click "Login" to authenticate.
- New users can conveniently register through the provided registration link.

### Registration
- Provide your email, username, and password.
- Ensure your password complies with the specified requisites.
- Click "Register" to create a new account.
- An email confirmation process adds an extra layer of security.

### Confirm Your Email Address
- View detailed information about the sent confirmation email.
- Optionally resend the confirmation email for user convenience.

### Successful Login
- Upon successful login, access the main application screen.
- Click "Logout" to securely log out, triggering a confirmation modal.

## How to Install

Installation is straightforward:

- Clone the repository to your local machine.
- Open the project in your preferred iOS development environment (preferably Xcode).
- Build and run the application on your Apple device or simulator.

## Lessons Learned

Insights gained during the development process:

- **Architectural Pattern:** Implementing the MVVM pattern improved code organization and maintainability.
- **User Interface:** Designing without Storyboard enhanced proficiency in programmatic UI development.
- **Layout:** Integration of SnapKit simplified Auto Layout constraints, improving dynamic layout.
- **Network Communication:** Efficient use of NetworkService, URL Session, and HTTP Requests for seamless API interaction.

These lessons contribute to ongoing growth and development as a software engineer.

## How to Contact

For inquiries, information, or contributions, feel free to reach out:

- Author: **[Igor Pak]** 
- GitHub: [GitHub Profile](https://github.com/iPakTulane)
- Email: [ipak.tulane@gmail.com](mailto:ipak.tulane@gmail.com)
- LinkedIn: [LinkedIn Profile](https://www.linkedin.com/in/igor-pak/)
- Telegram: [@iPak_Dev](https://t.me/iPak_Dev)

## License

This project is licensed under the MIT License.

