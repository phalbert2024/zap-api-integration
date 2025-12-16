# 🏀 HoopConnect

**Connect. Play. Ball.**

HoopConnect is a mobile-first social platform that connects basketball players with courts, games, and fellow hoopers in their area. Whether you're looking for a pickup game, organizing a tournament, or just trying to find the best courts near you, HoopConnect makes it easy to get on the court and play.

## 🎯 Project Vision

Our mission is to build the largest community of basketball players, making it easier than ever to find games, connect with players, and keep the love of basketball alive.

## ✨ Key Features

- **Court Discovery**: Find basketball courts near you with detailed information, ratings, and photos
- **Game Organization**: Create and join pickup games, organized matches, and tournaments
- **Player Matching**: Connect with players of similar skill levels and positions
- **Social Features**: Make friends, chat with players, and build your basketball community
- **Stats Tracking**: Track your games, performance, and progress over time
- **Premium Features**: Advanced analytics, tournament management, and more

## 📁 Repository Structure

```
hoopconnect/
├── /app                     # React Native mobile client
├── /backend                 # Optional lightweight API or cloud functions
├── /docs                    # Product specs, data schema, design system, policies
│   ├── PRODUCT_ROADMAP.md   # Feature backlog, deprecations, future work
│   ├── DATA_SCHEMA.md       # Entity definitions, relationships, indexes
│   ├── DESIGN_SYSTEM.md     # Components, colors, typography, neo-brutalism guide
│   ├── MONETIZATION.md      # Pricing, tier features, revenue model
│   ├── SAFETY_POLICY.md     # Community guidelines, moderation, enforcement
│   └── API_CONTRACTS.md     # API endpoint specifications
├── /infra                   # Environment setup, BaaS config, scripts
│   ├── firebase-config.ts   # Firebase project configs (dev/stage/prod)
│   ├── db-schema.sql        # SQL schema definitions (if using Supabase)
│   └── seeding/             # Scripts to populate initial court data
├── .github/
│   ├── /workflows           # CI/CD pipelines (GitHub Actions)
│   └── /ISSUE_TEMPLATE      # Issue templates for consistency
├── .gitignore
├── README.md                # This file
└── CONTRIBUTING.md          # Code standards, PR checklist, deployment process
```

## 🚀 Quick Start

### Prerequisites

- Node.js 18+ and npm
- React Native development environment
- Firebase account (or Supabase)
- Expo CLI (for mobile development)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/phalbert2024/zap-api-integration.git
   cd zap-api-integration
   ```

2. **Set up the mobile app**
   ```bash
   cd app
   npm install
   expo start
   ```

3. **Set up the backend** (optional)
   ```bash
   cd backend
   npm install
   npm run dev
   ```

4. **Configure environment variables**
   - Copy `.env.example` to `.env`
   - Fill in your Firebase/Supabase credentials
   - Update API endpoints as needed

### Running the App

- **iOS**: Press `i` in the Expo CLI or scan QR code with Camera app
- **Android**: Press `a` in the Expo CLI or scan QR code with Expo Go app
- **Web**: Press `w` in the Expo CLI

## 🌳 Git Branching Strategy

We follow a structured branching strategy to maintain code quality:

- **`main`**: Production code (protected, requires 2 approvals for critical paths)
- **`develop`**: Staging/integration branch; auto-deploys to stage environments
- **`feature/*`**: Individual feature branches (one per GitHub issue)
  - Example: `feature/court-search`, `feature/game-creation`
- **`hotfix/*`**: Critical bug fixes off main, PR to both main and develop
  - Example: `hotfix/auth-crash`, `hotfix/payment-error`

### Branch Protection Rules

- **main**: Requires 2 approvals, passing CI/CD, no force pushes
- **develop**: Requires 1 approval, passing CI/CD
- **feature/***: No restrictions, but must pass CI before merging

## 📖 Documentation

Comprehensive documentation is available in the `/docs` directory:

- **[Product Roadmap](docs/PRODUCT_ROADMAP.md)**: Feature backlog and future plans
- **[Data Schema](docs/DATA_SCHEMA.md)**: Database structure and relationships
- **[Design System](docs/DESIGN_SYSTEM.md)**: UI/UX guidelines and components
- **[Monetization](docs/MONETIZATION.md)**: Pricing tiers and revenue model
- **[Safety Policy](docs/SAFETY_POLICY.md)**: Community guidelines and moderation
- **[API Contracts](docs/API_CONTRACTS.md)**: Backend API specifications

## 🤝 Contributing

We welcome contributions! Please read our [Contributing Guidelines](CONTRIBUTING.md) before submitting pull requests.

### Quick Contribution Checklist

- [ ] Create a feature branch from `develop`
- [ ] Follow code style guidelines (run linters)
- [ ] Write tests for new features
- [ ] Update documentation as needed
- [ ] Ensure all CI checks pass
- [ ] Request code review from maintainers

## 🧪 Testing

```bash
# Run all tests
npm test

# Run tests with coverage
npm run test:coverage

# Run linter
npm run lint

# Run type checking
npm run type-check
```

## 🚢 Deployment

Deployments are automated via GitHub Actions:

- **Staging**: Auto-deploy on push to `develop`
- **Production**: Auto-deploy on push to `main`

Manual deployments:
```bash
# Deploy to staging
npm run deploy:staging

# Deploy to production
npm run deploy:production
```

## 🛠️ Tech Stack

- **Mobile**: React Native, Expo, TypeScript
- **Backend**: Node.js, Express, Firebase Functions (or Supabase Edge Functions)
- **Database**: Firebase Firestore (or Supabase PostgreSQL)
- **Authentication**: Firebase Auth (or Supabase Auth)
- **Storage**: Firebase Storage (or Supabase Storage)
- **Maps**: Google Maps API / Mapbox
- **Push Notifications**: Expo Notifications
- **Analytics**: Firebase Analytics, Mixpanel

## 📊 Project Status

🚧 **Currently in Development** - MVP Phase

- ✅ Repository structure setup
- ⏳ Mobile app scaffold
- ⏳ Backend API development
- ⏳ Database schema implementation
- ⏳ Authentication flow
- ⏳ Court discovery feature
- ⏳ Game creation feature

## 👥 Team

- **Project Lead**: [Your Name]
- **Mobile Development**: TBD
- **Backend Development**: TBD
- **Design**: TBD

## 📝 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## 🔗 Links

- **Website**: [Coming Soon]
- **Documentation**: [docs/](docs/)
- **Issue Tracker**: [GitHub Issues](https://github.com/phalbert2024/zap-api-integration/issues)
- **Discussions**: [GitHub Discussions](https://github.com/phalbert2024/zap-api-integration/discussions)

## 💬 Support

Need help? Have questions?

- 📧 Email: support@hoopconnect.app
- 💬 Discord: [Coming Soon]
- 🐦 Twitter: [@hoopconnect](https://twitter.com/hoopconnect)

---

**Made with ❤️ for basketball lovers everywhere**
