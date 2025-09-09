# Testing Guide - Sabo Arena v1

## 🧪 Manual Testing Checklist

### Pre-Test Setup
- [ ] App running on http://localhost:8080
- [ ] Chrome/Edge browser opened
- [ ] No compilation errors in terminal

### Navigation Testing
- [ ] **Bottom Tab 1 (Home)**: Loads TikTok-style feed
- [ ] **Bottom Tab 2 (Club)**: Shows club profile with statistics
- [ ] **Bottom Tab 3 (Find)**: Placeholder screen (not implemented)
- [ ] **Bottom Tab 4 (Profile)**: User profile with stats
- [ ] **Tab switching**: Smooth transitions between screens

### Home Screen Testing
- [ ] **Background Image**: Full-screen background loads
- [ ] **User Card**: Overlay card displays properly
- [ ] **Action Buttons**: Heart, comment, share buttons visible
- [ ] **Rank Badge**: User rank displays correctly
- [ ] **Bottom Info**: User name and info shown
- [ ] **Responsive**: Layout adapts to different screen sizes

### Club Profile Testing
- [ ] **Header**: @sabobilliards displays correctly
- [ ] **Club Image**: Image with gradient border effect
- [ ] **Statistics**: Shows 25 members, 15 tournaments, etc.
- [ ] **Member List**: Scrollable ranking list
- [ ] **Location**: Club location info visible

### User Profile Testing
- [ ] **Background**: Profile background image loads
- [ ] **Avatar**: User photo with proper styling
- [ ] **Rank Badge**: Rank indicator displays
- [ ] **Stats Dashboard**: ELO, SPA, XH, TRẬN numbers show
- [ ] **Tournament List**: Scrollable tournament history
- [ ] **Scroll Performance**: Smooth scrolling behavior

### Performance Testing
- [ ] **Load Time**: App loads under 5 seconds
- [ ] **Hot Reload**: Changes reflect immediately (press 'r')
- [ ] **Memory Usage**: No excessive memory consumption
- [ ] **Smooth Animations**: No lag in transitions

### Cross-Browser Testing
- [ ] **Chrome**: Full functionality
- [ ] **Edge**: Full functionality  
- [ ] **Safari**: Basic functionality (if available)
- [ ] **Mobile Browser**: Responsive behavior

## 🐛 Common Issues & Solutions

### Issue: App doesn't load
**Solution**: 
```bash
# Kill existing Flutter processes
pkill -f flutter

# Restart app
export PATH="/tmp/flutter/bin:$PATH"
flutter run -d web-server --web-port=8080
```

### Issue: Hot reload not working
**Solution**: Press 'R' for hot restart instead of 'r'

### Issue: Images not loading
**Check**: 
- Assets folder exists: `/assets/images/`
- pubspec.yaml includes assets
- Image paths in code are correct

### Issue: Bottom navigation not switching
**Check**: MainLayout PageView controller is working

## 🔍 Code Quality Checks

### Run Analysis
```bash
flutter analyze
```
**Expected**: No errors or warnings

### Check File Structure
```bash
tree lib/ -I "*.dart.bak"
```
**Expected**: All screens in proper folders

### Verify Dependencies
```bash
flutter pub deps
```
**Expected**: All packages resolved

## 📊 Performance Benchmarks

### Target Metrics
- **App Load**: < 5 seconds
- **Page Transition**: < 300ms
- **Scroll FPS**: 60fps
- **Memory Usage**: < 100MB

### Monitoring Tools
```bash
# Flutter performance overlay
# Add to main.dart for debugging:
# MaterialApp(debugShowMaterialGrid: true)
```

## ✅ Test Results Template

```
Date: ___________
Tester: _________
Browser: ________

Navigation Testing: ☐ Pass ☐ Fail
Home Screen: ☐ Pass ☐ Fail  
Club Profile: ☐ Pass ☐ Fail
User Profile: ☐ Pass ☐ Fail
Performance: ☐ Pass ☐ Fail

Issues Found:
1. _________________
2. _________________
3. _________________

Overall Status: ☐ Ready for Production ☐ Needs Fixes
```

---
*Cập nhật testing guide này khi có features mới*
