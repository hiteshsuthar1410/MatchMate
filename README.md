# 📱 MatchMate - Matrimonial Card Interface

**MatchMate** is a matrimonial app built with **SwiftUI** that showcases clean UI, modular architecture, offline persistence, and rich user interaction — inspired by popular platforms like Shaadi.com.

---

## 🚀 Features

1. **Built With**:  
   - `SwiftUI`
   - `Core Data`
   - `URLSession`
   - `SDWebImageSwiftUI`
   - Architecture: `MVVM`

2. **Two-Tab Interface**:
   - **Explore Tab**: Displays a scrollable list of new and existing profiles.
   - **History Tab**: Shows profiles that the user has accepted or declined, sorted by latest interaction.

3. **Pull to Refresh**:
   - Swipe down on the Explore tab to fetch new profiles and update the list dynamically.

4. **Interactive Match Cards**:
   - Each card shows:
     - User Image
     - Online Status
     - Full Address
     - Action Buttons: ✅ Accept or ❌ Decline

5. **Smart History Management**:
   - Accepted/Declined users are stored in the History tab.
   - Recently interacted profiles appear at the top.

6. **Toast Notifications**:
   - Visual feedback for Accept or Decline actions.

7. **Offline Mode Support**:
   - Profiles and user decisions are persisted with Core Data.
   - Works seamlessly without internet — including the ability to accept/decline offline.

8. **Custom App Icon**:
   - Beautiful 3D heart icon in pink-red gradient for better branding.

9. **Loading Experience**:
   - Fun message like _"Finding people you’ll love to meet 🥰"_ during initial load.

10. **Modular Architecture**:
    - Reusable SwiftUI components and a well-structured codebase.

11. **iOS 16+**:
    - Minimum supported deployment target is iOS 16.

---

## 📸 Screenshots

| Explore Tab | History Tab |
|-------------|-------------|
| ![Explore Tab](https://github.com/user-attachments/assets/62b826c3-c181-410f-a607-8a1dbbbe3690) | ![History Tab](https://github.com/user-attachments/assets/1c6bad87-ce1c-450b-a5bb-901f9c77fcfa) |

| Refresh | Initial Load | Offline Mode |
|--------|--------------|--------------|
| ![Loader](https://github.com/user-attachments/assets/7c8d92ee-4305-4cb2-82d8-d599daba57d2) | ![Loading](https://github.com/user-attachments/assets/37a803d0-99c0-4050-b888-e2d60a3ae463) | ![Offline](https://github.com/user-attachments/assets/9e884feb-94c9-485d-beaa-fb068320b739) |

---

## 🎬 App Walkthrough

👉 [Watch the full walkthrough video](https://jumpshare.com/s/IC4Y1Gk2nVIaFldCgYqD)

---

## 🛠️ Getting Started

```bash
git clone https://github.com/your-username/MatchMate.git
