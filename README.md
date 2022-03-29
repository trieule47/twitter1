# Base source
Base source using for develop app

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
# Folder structure:
- assets:
    + images(1x,2x,3x)
    + fonts
- configs: error code and server config.
- controllers: contain bussiness flow with screen (ex: LoginController vs LoginView).
- enums: contain enum in app (file enums) and another type.
- locales: contain localize app.
- models: contain model data.
- repositories: contain repository to call api
(Repository created follow by object, ex: UserRepository, Product Repository).
- router: contain path navigate.
- styles: contain common style for app.
- utils: contain utils for app. If don't know using what util, you maybe create your function
 in Utils file.
- vales: contain constant, value all app
- views: contain screen, devide folder by function in app(ex: login, profile, order ...)
- widgets: contain widget common use many times in app, don't add widget just using in one screen.

# Run source:
- Generation .g.dart: flutter packages pub run build_runner build.

# Coding convention
- Comment variable, type variable
- Not using _ class and function
- Images: if icon have prefix ic_
- Localizes: use right name.
- DemoView: Demo control.
- Function: prefix on (onPress, onChange ...), prefix goTo(change screen), prefix render if render view.
- Dynamic vs var: Dynamic can change value from string to int but var is not.



"# twitter1" 
