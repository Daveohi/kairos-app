# Flutter Engineer - Skill Verification Case Study

## Role
Flutter Engineer

## Title
Mobile Commerce Application Prototype

## Brief
Develop a simplified Flutter application prototype for a local same-day product delivery mobile app. Build key UI screens, implement core functionality with state management, and demonstrate technical understanding of mobile architecture.

## Description

### Scenario
**Company**: Kairos (fictional mobile commerce startup)
**Product**: Mobile app for local same-day product delivery
**Business Need**: Scalable and responsive mobile experiences

**Your Role**: Flutter Developer tasked with building a functional prototype that demonstrates UI development skills, state management understanding, and mobile architecture knowledge.

### Objective
Create a working Flutter application prototype that includes onboarding, product browsing, and checkout functionality while demonstrating best practices in code quality, architecture, and mobile UX.

---

## Deliverables

### A. UI Development (40%)
Build the following screens with attention to mobile UX:

**1. Onboarding Screen**
- Multi-step onboarding flow (2-3 screens)
- Welcome message and value proposition
- Skip functionality
- Smooth transitions between onboarding steps
- "Get Started" call-to-action

**2. Product Listing Screen**
- Grid or list view of products
- Product cards with image, name, and price
- Search functionality
- Filter/sort options (optional but recommended)
- Pull-to-refresh capability
- Loading states and error handling

**3. Cart/Checkout Flow**
- Add to cart functionality
- Cart screen showing selected items
- Update quantity (increase/decrease)
- Remove items from cart
- Order summary with total calculation
- Checkout button leading to simple checkout form
- Basic form validation

**UI Requirements**:
- Clean, modern design
- Consistent spacing and typography
- Proper use of Flutter widgets
- Responsive to different screen sizes
- Smooth animations and transitions

### B. Functionality (35%)
Implement core technical features:

**1. Responsive Layouts**
- Adapts to different screen sizes
- Works on both phones and tablets
- Portrait and landscape support
- Safe area handling
- Proper keyboard behavior

**2. Navigation**
- Bottom navigation bar or drawer
- Screen-to-screen navigation
- Back navigation handling
- Deep linking structure (optional)
- Proper route management

**3. State Management Approach**
- Choose and implement a state management solution:
  - Provider
  - Riverpod
  - BLoC
  - GetX
  - Or any other preferred approach
- Explain your choice in documentation
- Demonstrate proper state management patterns
- Separation of business logic from UI

**4. Simple API Integration**
- Mock API or use a public API
- Fetch product data
- Handle loading states
- Error handling and retry logic
- Optional: Local caching with SharedPreferences or similar

### C. Technical Thinking (25%)
Document your technical approach:

**1. Architecture Decisions**
- Project structure and organization
- Why you chose your state management solution
- Code organization patterns (folders, files, modules)
- Reusable components and widgets
- Design patterns used

**2. Scalability Considerations**
- How the code can scale to more features
- Modular architecture approach
- Code reusability
- Testing strategy (even if not fully implemented)
- Performance optimization opportunities

**3. Optimization Approach**
- Widget rebuild optimization
- Memory management
- Image loading and caching
- List performance (ListView.builder, etc.)
- Bundle size considerations

---

## Technical Requirements

### Must Have
- ✅ Flutter SDK (latest stable version)
- ✅ Clean code structure
- ✅ Working navigation between screens
- ✅ State management implementation
- ✅ README with setup instructions
- ✅ Comments for complex logic

### Nice to Have
- 🌟 Unit tests
- 🌟 Widget tests
- 🌟 Custom animations
- 🌟 Dark mode support
- 🌟 Accessibility features
- 🌟 CI/CD setup

---

## Submission Requirements

### What to Submit
1. **GitHub Repository** with:
   - Complete Flutter project source code
   - README.md with:
     - Setup instructions
     - How to run the app
     - Architecture explanation
     - State management choice rationale
     - Screenshots or GIFs of the app
   - ARCHITECTURE.md (optional but recommended):
     - Technical decisions
     - Scalability considerations
     - Optimization approach

### How to Submit
1. Create a GitHub repository
2. Push your Flutter project
3. Create a Pull Request to `main` branch
4. Include screenshots/GIFs in PR description
5. Submit the repository URL

---

## Deadline
**72 hours** from repository access

---

## Evaluation Criteria

Your submission will be evaluated based on:

1. **Code Quality** (25%) - Clean, readable, maintainable code
2. **UI Responsiveness** (20%) - Adapts to different screens and orientations
3. **Mobile UX Understanding** (15%) - Intuitive navigation and user experience
4. **Technical Structure** (20%) - Architecture, state management, organization
5. **Problem-Solving** (10%) - Error handling, edge cases, loading states
6. **Documentation Clarity** (10%) - Clear README and code comments

### What We Look For
- **Clean code**: Well-organized, readable, follows Flutter conventions
- **Responsive UI**: Works on different screen sizes
- **Smooth UX**: Proper loading states, error handling, animations
- **Proper state management**: Clean separation of UI and logic
- **Good architecture**: Scalable folder structure
- **Error handling**: Graceful degradation when things go wrong
- **Documentation**: Clear setup instructions and technical explanations
- **Attention to detail**: Polish in UI and code

### Scoring Breakdown
- **Excellent (85-100)**: Production-ready code, great UX, solid architecture
- **Good (70-84)**: Working app, clean code, good practices
- **Needs Improvement (<70)**: Incomplete features, poor code quality, or broken functionality

---

## Tips for Success

### Flutter Best Practices
- **Widget composition**: Break down into smaller, reusable widgets
- **Const constructors**: Use `const` where possible for performance
- **Proper state management**: Don't use `setState` for complex state
- **Named routes**: Better navigation management
- **Theme management**: Consistent colors, fonts, spacing
- **Async/await**: Proper async handling for API calls
- **Error boundaries**: Try-catch and error widgets

### Mobile UX Guidelines
- **Touch targets**: Minimum 48x48 logical pixels
- **Loading indicators**: Show progress for async operations
- **Error messages**: User-friendly, actionable messages
- **Empty states**: Handle empty cart, no products gracefully
- **Feedback**: Visual feedback for user actions
- **Navigation**: Intuitive, consistent patterns

### Project Structure Example
```
lib/
├── main.dart
├── app.dart
├── core/
│   ├── theme/
│   ├── constants/
│   └── utils/
├── features/
│   ├── onboarding/
│   │   ├── screens/
│   │   ├── widgets/
│   │   └── providers/
│   ├── products/
│   └── cart/
└── shared/
    ├── widgets/
    └── models/
```

### Common Pitfalls to Avoid
- Overusing `setState` for complex state
- Not handling loading and error states
- Ignoring responsive design
- Poor code organization
- No error handling
- Tight coupling between UI and business logic
- Memory leaks (not disposing controllers)
- No consideration for different screen sizes

### State Management Tips
- **Provider**: Good for beginners, easy to learn
- **Riverpod**: Modern, testable, null-safe
- **BLoC**: Enterprise-grade, clear separation of concerns
- **GetX**: Quick development, dependency injection
- Choose one and use it consistently

### Testing Recommendations
Even if you don't write tests, structure code to be testable:
- Pure functions for business logic
- Dependency injection
- Mocked API responses
- Separated concerns

Good luck! 📱
