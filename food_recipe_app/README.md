#  Food Recipe App

## 1. Project Overview
The **Food Recipe App** is a premium, cross-platform mobile application built with Flutter. It serves as a comprehensive digital cookbook where users can discover delicious recipes, filter them by origin (e.g., Italy, India, Japan, Mexico), and search for specific dishes.

The application features a secure local authentication system using **SQLite**, allowing users to register, log in, and maintain a personalized list of favorite recipes that persists across sessions. The architecture follows a clean MVC-inspired pattern, ensuring scalability, fast performance, and a seamless user experience.

**Key Features:**
* Local Authentication (Sign up / Sign in) with email validation.
* Smart Search & Categorization.
* Personalized "Favorites" management tied to the user's local session.
* Modern, responsive Material 3 UI.

---

## 2. Animation Showcase (Real Device Video/GIF)
*Below is a high-quality screen recording of the Food Recipe App running on a **Physical Mobile Device** (not an emulator) to demonstrate the 60fps smoothness and quality of our implemented animations.*

> **[https://drive.google.com/drive/folders/1uBWN3VoF6DJt6q_-iX6dAi4Q7yAFlQ6i]**


---

## 3. Animation Research & Implementation

During the development phase, we conducted research on various animation techniques in Flutter to ensure our app feels alive, premium, and highly responsive without sacrificing performance.

### **Research Phase:**
We explored three main approaches:
1. **Explicit Animations (AnimationController):** Highly customizable but requires significant boilerplate code and state management.
2. **External Asset Animations (Lottie/Rive):** Great for complex, vector-based illustrations, but can increase the app size and were over-engineered for our specific UI needs.
3. **Declarative Animation Packages:** Tools that wrap Flutter's implicit and explicit animations into a streamlined, readable syntax.

### **Our Choices & Implementation:**
Based on our research, we decided to implement a mix of **Declarative Package-based Animations** and **Implicit UI Transitions**. We integrated the following specific solutions:

* **`flutter_animate`:** We chose this package for animating our core UI components (like recipe cards, buttons, and grid items). It allows for chainable, declarative animations (e.g., `.fade().slideY()`). We implemented this to create smooth staggering effects when lists load, giving a premium feel without the heavy boilerplate of standard `AnimationControllers`.
* **`animated_text_kit`:** Selected to handle dynamic text reveals (used in headers and splash screens). It immediately grabs the user's attention and adds a modern touch to the typography.
* **`smooth_page_indicator` & `google_nav_bar`:** Implemented to handle the micro-interactions during navigation. The `google_nav_bar` provides fluid, color-shifting feedback when switching tabs, while `smooth_page_indicator` ensures smooth transitions between carousel items.

**Why these choices?** They provided the perfect balance between high performance (running smoothly on physical devices), maintainable code, and a highly engaging user experience.

---

## Technical Details & Setup

### **Tech Stack**
* **Framework:** Flutter (SDK >=3.0.0)
* **Language:** Dart
* **Local Database:** `sqflite`
* **Routing:** `go_router`
* **State Persistence:** `shared_preferences`

### **How to Run the Project**
1. Clone the repository:
   ```bash
   git clone <your-repository-url>
2. Navigate to the project directory:
    ```bash
   cd food-recipe-app   
3. install dependencies:
    ```bash
   flutter pub get
4. Connect your Physical Device via USB (ensure USB Debugging is enabled).
5. Run the app:
    ```bash
   flutter run
   
---

Team / Contributors:
Mahmoud Ahmed Abdelghani 
Alyaa Ashraf Elnagar