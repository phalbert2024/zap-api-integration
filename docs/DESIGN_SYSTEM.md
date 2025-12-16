# HoopConnect Design System

## Overview
This document defines the visual design system for HoopConnect, including components, colors, typography, and neo-brutalism design principles.

## Design Philosophy

HoopConnect embraces a **Neo-Brutalism** aesthetic that is:
- **Bold and Direct**: Strong, thick borders and high contrast
- **Playful**: Bright colors and playful shadows
- **Functional**: Clear hierarchy and obvious interactions
- **Authentic**: No gradients, no blur effects, hard edges

## Color Palette

### Primary Colors
```css
--hoop-orange: #FF6B35;      /* Primary brand color - Basketball energy */
--hoop-black: #1A1A1A;       /* Primary text and borders */
--hoop-white: #FFFFFF;       /* Backgrounds and text on dark */
--hoop-court-green: #2DD881; /* Success states, available courts */
```

### Secondary Colors
```css
--hoop-blue: #4A90E2;        /* Links, info states */
--hoop-yellow: #FFD93D;      /* Warnings, highlights */
--hoop-red: #E63946;         /* Errors, urgent notifications */
--hoop-purple: #B565D8;      /* Premium features */
```

### Neutral Colors
```css
--hoop-gray-100: #F5F5F5;    /* Light backgrounds */
--hoop-gray-200: #E0E0E0;    /* Borders, dividers */
--hoop-gray-300: #BDBDBD;    /* Disabled states */
--hoop-gray-400: #9E9E9E;    /* Secondary text */
--hoop-gray-500: #757575;    /* Tertiary text */
--hoop-gray-900: #212121;    /* Heavy text */
```

## Typography

### Font Families
```css
--font-primary: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
--font-display: 'Space Grotesk', 'Inter', sans-serif;
--font-mono: 'JetBrains Mono', 'Courier New', monospace;
```

### Font Sizes
```css
--text-xs: 12px;      /* Captions, labels */
--text-sm: 14px;      /* Secondary text */
--text-base: 16px;    /* Body text */
--text-lg: 18px;      /* Emphasized body */
--text-xl: 20px;      /* Small headings */
--text-2xl: 24px;     /* Card titles */
--text-3xl: 30px;     /* Section headings */
--text-4xl: 36px;     /* Page headings */
--text-5xl: 48px;     /* Hero text */
```

### Font Weights
```css
--font-regular: 400;
--font-medium: 500;
--font-semibold: 600;
--font-bold: 700;
--font-black: 900;
```

### Line Heights
```css
--leading-tight: 1.25;
--leading-normal: 1.5;
--leading-relaxed: 1.75;
```

## Spacing System

Based on 4px increments:
```css
--space-1: 4px;
--space-2: 8px;
--space-3: 12px;
--space-4: 16px;
--space-5: 20px;
--space-6: 24px;
--space-8: 32px;
--space-10: 40px;
--space-12: 48px;
--space-16: 64px;
--space-20: 80px;
```

## Border & Shadows

### Borders
```css
--border-thin: 2px;
--border-medium: 3px;
--border-thick: 4px;
--border-extra-thick: 6px;
```

### Neo-Brutalist Shadows
```css
--shadow-sm: 2px 2px 0px var(--hoop-black);
--shadow-md: 4px 4px 0px var(--hoop-black);
--shadow-lg: 6px 6px 0px var(--hoop-black);
--shadow-xl: 8px 8px 0px var(--hoop-black);
```

### Border Radius
```css
--radius-none: 0px;
--radius-sm: 4px;
--radius-md: 8px;
--radius-lg: 12px;
--radius-full: 9999px;
```

## Component Library

### Buttons

#### Primary Button
```jsx
<Button variant="primary">
  // Style:
  background: var(--hoop-orange)
  color: var(--hoop-white)
  border: var(--border-thick) solid var(--hoop-black)
  box-shadow: var(--shadow-md)
  padding: var(--space-4) var(--space-6)
  font-weight: var(--font-bold)
  border-radius: var(--radius-md)
  
  // Hover:
  transform: translate(2px, 2px)
  box-shadow: var(--shadow-sm)
  
  // Active:
  transform: translate(4px, 4px)
  box-shadow: none
</Button>
```

#### Secondary Button
```jsx
<Button variant="secondary">
  // Style:
  background: var(--hoop-white)
  color: var(--hoop-black)
  border: var(--border-thick) solid var(--hoop-black)
  box-shadow: var(--shadow-md)
</Button>
```

#### Ghost Button
```jsx
<Button variant="ghost">
  // Style:
  background: transparent
  color: var(--hoop-black)
  border: var(--border-thin) solid var(--hoop-black)
  box-shadow: none
</Button>
```

### Cards

```jsx
<Card>
  // Style:
  background: var(--hoop-white)
  border: var(--border-medium) solid var(--hoop-black)
  box-shadow: var(--shadow-lg)
  border-radius: var(--radius-md)
  padding: var(--space-6)
  
  // Hover (for interactive cards):
  transform: translate(2px, 2px)
  box-shadow: var(--shadow-md)
</Card>
```

### Input Fields

```jsx
<Input>
  // Style:
  background: var(--hoop-white)
  border: var(--border-medium) solid var(--hoop-black)
  border-radius: var(--radius-sm)
  padding: var(--space-3) var(--space-4)
  font-size: var(--text-base)
  
  // Focus:
  outline: none
  border-color: var(--hoop-orange)
  box-shadow: 0 0 0 3px rgba(255, 107, 53, 0.2)
  
  // Error:
  border-color: var(--hoop-red)
</Input>
```

### Badges

```jsx
<Badge variant="success">
  // Style:
  background: var(--hoop-court-green)
  color: var(--hoop-black)
  border: var(--border-thin) solid var(--hoop-black)
  padding: var(--space-1) var(--space-3)
  font-size: var(--text-xs)
  font-weight: var(--font-bold)
  border-radius: var(--radius-sm)
</Badge>
```

### Modals

```jsx
<Modal>
  // Overlay:
  background: rgba(26, 26, 26, 0.8)
  
  // Content:
  background: var(--hoop-white)
  border: var(--border-extra-thick) solid var(--hoop-black)
  box-shadow: var(--shadow-xl)
  border-radius: var(--radius-lg)
  padding: var(--space-8)
  max-width: 500px
</Modal>
```

### Bottom Navigation

```jsx
<BottomNav>
  // Style:
  background: var(--hoop-white)
  border-top: var(--border-medium) solid var(--hoop-black)
  height: 60px
  
  // Active Tab:
  color: var(--hoop-orange)
  border-top: var(--border-thick) solid var(--hoop-orange)
</BottomNav>
```

## Icons

- **Style**: Outlined, 2px stroke width
- **Size**: 20px (small), 24px (medium), 32px (large)
- **Library**: React Native Vector Icons (Feather set recommended)

## Layout Patterns

### Screen Padding
```css
--screen-padding-x: var(--space-4);
--screen-padding-y: var(--space-4);
```

### Card Grid
- **Mobile**: 1 column
- **Tablet**: 2 columns
- **Gap**: var(--space-4)

### List Items
- **Height**: 64px minimum
- **Padding**: var(--space-4)
- **Border Bottom**: var(--border-thin) solid var(--hoop-gray-200)

## Animation Guidelines

### Timing Functions
```css
--ease-standard: cubic-bezier(0.4, 0.0, 0.2, 1);
--ease-decelerate: cubic-bezier(0.0, 0.0, 0.2, 1);
--ease-accelerate: cubic-bezier(0.4, 0.0, 1, 1);
```

### Durations
```css
--duration-fast: 150ms;
--duration-normal: 250ms;
--duration-slow: 350ms;
```

### Common Animations
- **Button Press**: Transform + shadow change (150ms)
- **Page Transition**: Slide from right (250ms)
- **Modal**: Fade in + scale up (250ms)
- **Toast**: Slide down from top (250ms)

## Accessibility

### Color Contrast
- All text must meet WCAG AA standards (4.5:1 for normal text)
- Interactive elements must have clear focus states
- Color should not be the only means of conveying information

### Touch Targets
- Minimum size: 44x44px
- Spacing between targets: 8px minimum

### Text Sizing
- Support for user-preferred text sizes
- Relative units (sp on Android, points on iOS)

## Responsive Breakpoints

```css
--breakpoint-sm: 375px;   /* Small phones */
--breakpoint-md: 768px;   /* Tablets */
--breakpoint-lg: 1024px;  /* Large tablets/small laptops */
```

## Dark Mode (Future)

*Dark mode specifications to be defined in future iteration*

## Implementation Notes

1. Use React Native's StyleSheet for performance
2. Define constants in a central theme file
3. Use styled-components or similar for complex component styling
4. Implement a theme provider for global access
5. Test on both iOS and Android devices

## Resources

- **Figma Design Files**: [Link to be added]
- **Icon Library**: React Native Vector Icons
- **Font Files**: Google Fonts (Inter, Space Grotesk)
- **Example Screenshots**: [To be added]
