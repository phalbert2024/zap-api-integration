# Contributing to HoopConnect

Thank you for your interest in contributing to HoopConnect! This document provides guidelines and instructions for contributing to the project.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Workflow](#development-workflow)
- [Code Standards](#code-standards)
- [Pull Request Process](#pull-request-process)
- [Commit Message Guidelines](#commit-message-guidelines)
- [Testing Guidelines](#testing-guidelines)
- [Documentation](#documentation)

## Code of Conduct

By participating in this project, you agree to abide by our Code of Conduct:

- Be respectful and inclusive
- Welcome newcomers and help them get started
- Focus on what is best for the community
- Show empathy towards other community members
- Accept constructive criticism gracefully

## Getting Started

### Prerequisites

- Node.js 18+ and npm
- Git
- React Native development environment (iOS/Android)
- Expo CLI
- Code editor (VS Code recommended)

### Setting Up Your Development Environment

1. **Fork the repository**
   ```bash
   # Click "Fork" button on GitHub
   # Clone your fork
   git clone https://github.com/YOUR_USERNAME/zap-api-integration.git
   cd zap-api-integration
   ```

2. **Add upstream remote**
   ```bash
   git remote add upstream https://github.com/phalbert2024/zap-api-integration.git
   ```

3. **Install dependencies**
   ```bash
   # Install mobile app dependencies
   cd app
   npm install
   
   # Install backend dependencies
   cd ../backend
   npm install
   ```

4. **Set up environment variables**
   ```bash
   # Copy example env files
   cp .env.example .env
   # Fill in your credentials
   ```

5. **Verify setup**
   ```bash
   # Run tests
   npm test
   
   # Run linters
   npm run lint
   ```

## Development Workflow

### Branching Strategy

We use a structured Git workflow:

1. **`main`** - Production-ready code
2. **`develop`** - Integration branch for features
3. **`feature/*`** - New features (branch from `develop`)
4. **`bugfix/*`** - Bug fixes (branch from `develop`)
5. **`hotfix/*`** - Critical fixes (branch from `main`)

### Creating a Feature Branch

```bash
# Update develop branch
git checkout develop
git pull upstream develop

# Create your feature branch
git checkout -b feature/your-feature-name

# Make your changes
# Commit regularly with meaningful messages

# Push to your fork
git push origin feature/your-feature-name
```

### Syncing with Upstream

```bash
# Fetch upstream changes
git fetch upstream

# Merge upstream develop into your branch
git checkout feature/your-feature-name
git merge upstream/develop

# Resolve any conflicts
# Commit and push
```

## Code Standards

### General Principles

- **DRY (Don't Repeat Yourself)**: Extract common functionality
- **KISS (Keep It Simple, Stupid)**: Prefer simple, readable solutions
- **YAGNI (You Aren't Gonna Need It)**: Don't add functionality until needed
- **Single Responsibility**: Each function/component should do one thing well

### TypeScript/JavaScript Style Guide

We follow the [Airbnb JavaScript Style Guide](https://github.com/airbnb/javascript) with some modifications:

#### Naming Conventions

```typescript
// Variables and functions: camelCase
const userName = 'John';
function getUserData() { }

// Classes and Types: PascalCase
class UserProfile { }
interface UserData { }

// Constants: UPPER_SNAKE_CASE
const API_BASE_URL = 'https://api.hoopconnect.app';

// React Components: PascalCase
const GameCard = () => { };

// Private methods: prefix with underscore
private _handleInternalState() { }
```

#### File Organization

```typescript
// 1. Imports (external first, then internal)
import React from 'react';
import { View, Text } from 'react-native';
import { api } from '@/lib/api';
import { Button } from '@/components/Button';

// 2. Types and Interfaces
interface GameCardProps {
  game: Game;
  onPress: () => void;
}

// 3. Constants
const MAX_PLAYERS = 10;

// 4. Component/Function Definition
export const GameCard: React.FC<GameCardProps> = ({ game, onPress }) => {
  // 5. Hooks
  const [isLoading, setIsLoading] = useState(false);
  
  // 6. Effects
  useEffect(() => {
    // ...
  }, []);
  
  // 7. Event Handlers
  const handlePress = () => {
    onPress();
  };
  
  // 8. Render
  return (
    <View>
      <Text>{game.title}</Text>
      <Button onPress={handlePress} />
    </View>
  );
};
```

#### Code Formatting

We use Prettier for code formatting. Configuration:

```json
{
  "semi": true,
  "trailingComma": "es5",
  "singleQuote": true,
  "printWidth": 100,
  "tabWidth": 2,
  "arrowParens": "always"
}
```

Run formatter:
```bash
npm run format
```

#### Linting

We use ESLint for linting. Run linter:
```bash
npm run lint

# Auto-fix issues
npm run lint:fix
```

### React/React Native Best Practices

#### Component Structure

```typescript
// Prefer functional components with hooks
const GameList: React.FC<GameListProps> = ({ games, onGamePress }) => {
  // Custom hooks for logic
  const { filteredGames, filterGames } = useGameFilters(games);
  
  return (
    <FlatList
      data={filteredGames}
      renderItem={({ item }) => (
        <GameCard game={item} onPress={() => onGamePress(item)} />
      )}
      keyExtractor={(item) => item.id}
    />
  );
};
```

#### State Management

```typescript
// Local state for UI
const [isOpen, setIsOpen] = useState(false);

// Context for shared state
const { user, setUser } = useAuth();

// Global state (Redux/Zustand) for app-wide data
const games = useSelector((state) => state.games);
```

#### Performance Optimization

```typescript
// Memoize expensive calculations
const filteredGames = useMemo(() => 
  games.filter(game => game.status === 'active'),
  [games]
);

// Memoize callbacks
const handlePress = useCallback(() => {
  navigation.navigate('GameDetails', { gameId: game.id });
}, [game.id, navigation]);

// Memoize components
const GameCard = React.memo(({ game }) => {
  // ...
});
```

### Backend Code Standards

#### API Endpoint Structure

```typescript
// routes/games.ts
router.get('/games', authenticate, async (req, res) => {
  try {
    const games = await gameService.getGames(req.query);
    res.json({ games });
  } catch (error) {
    logger.error('Error fetching games:', error);
    res.status(500).json({ error: 'Failed to fetch games' });
  }
});
```

#### Error Handling

```typescript
// Use custom error classes
class ValidationError extends Error {
  statusCode = 400;
}

// Centralized error handler
app.use((err, req, res, next) => {
  logger.error(err);
  res.status(err.statusCode || 500).json({
    error: {
      message: err.message,
      code: err.code
    }
  });
});
```

### Testing Standards

#### Unit Tests

```typescript
describe('GameCard', () => {
  it('should render game title', () => {
    const game = { id: '1', title: 'Pickup Game' };
    const { getByText } = render(<GameCard game={game} />);
    expect(getByText('Pickup Game')).toBeTruthy();
  });
  
  it('should call onPress when tapped', () => {
    const onPress = jest.fn();
    const { getByTestId } = render(
      <GameCard game={mockGame} onPress={onPress} />
    );
    fireEvent.press(getByTestId('game-card'));
    expect(onPress).toHaveBeenCalled();
  });
});
```

#### Integration Tests

```typescript
describe('Game API', () => {
  it('should create a new game', async () => {
    const gameData = { title: 'Test Game', courtId: 'court1' };
    const response = await request(app)
      .post('/api/games')
      .send(gameData)
      .set('Authorization', `Bearer ${token}`);
    
    expect(response.status).toBe(201);
    expect(response.body.game.title).toBe('Test Game');
  });
});
```

## Pull Request Process

### Before Submitting a PR

- [ ] Code follows the style guidelines
- [ ] All tests pass (`npm test`)
- [ ] Linters pass (`npm run lint`)
- [ ] Type checking passes (`npm run type-check`)
- [ ] Code is well-documented
- [ ] Related documentation is updated
- [ ] Commits follow commit message guidelines
- [ ] Branch is up to date with `develop`

### PR Checklist

When opening a pull request, include:

1. **Title**: Clear, descriptive title following format:
   - `feat: Add game creation feature`
   - `fix: Fix crash on court search`
   - `docs: Update API documentation`
   - `refactor: Refactor authentication logic`
   - `test: Add tests for game service`

2. **Description**: Use the PR template
   ```markdown
   ## Description
   Brief description of changes
   
   ## Related Issue
   Fixes #123
   
   ## Type of Change
   - [ ] Bug fix
   - [ ] New feature
   - [ ] Breaking change
   - [ ] Documentation update
   
   ## Testing
   Describe how you tested your changes
   
   ## Screenshots
   (if applicable)
   
   ## Checklist
   - [ ] My code follows the style guidelines
   - [ ] I have performed a self-review
   - [ ] I have commented my code where needed
   - [ ] I have updated the documentation
   - [ ] My changes generate no new warnings
   - [ ] I have added tests
   - [ ] All tests pass
   ```

3. **Reviewers**: Request review from relevant team members

4. **Labels**: Add appropriate labels (bug, enhancement, documentation, etc.)

### Review Process

- PRs require at least 1 approval (2 for `main` branch)
- Address all review comments
- Resolve all conversations before merging
- Keep PRs small and focused (< 400 lines preferred)
- Respond to reviews within 48 hours

### Merging

- **Squash and merge** for feature branches (keeps history clean)
- **Regular merge** for release branches (preserves commit history)
- Delete branch after merging

## Commit Message Guidelines

We follow [Conventional Commits](https://www.conventionalcommits.org/):

### Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types

- **feat**: New feature
- **fix**: Bug fix
- **docs**: Documentation changes
- **style**: Code style changes (formatting, missing semicolons)
- **refactor**: Code refactoring
- **perf**: Performance improvements
- **test**: Adding or updating tests
- **build**: Build system or dependency changes
- **ci**: CI/CD changes
- **chore**: Other changes that don't modify src or test files

### Examples

```bash
feat(games): add game creation feature

Implement game creation flow with court selection,
date/time picker, and player limit settings.

Closes #123

---

fix(auth): prevent crash on logout

Fixed null pointer exception when user logs out
without active session.

Fixes #456

---

docs(api): update API documentation for games endpoint

Added examples and updated response schemas.
```

### Rules

- Use imperative mood ("add feature" not "added feature")
- Don't capitalize first letter
- No period at the end of subject line
- Limit subject line to 72 characters
- Separate subject from body with blank line
- Wrap body at 72 characters
- Use body to explain what and why, not how

## Testing Guidelines

### Test Coverage

Aim for:
- **Unit tests**: 80%+ coverage
- **Integration tests**: Critical paths
- **E2E tests**: Main user flows

### Running Tests

```bash
# Run all tests
npm test

# Run tests in watch mode
npm run test:watch

# Run tests with coverage
npm run test:coverage

# Run specific test file
npm test GameCard.test.tsx

# Run E2E tests
npm run test:e2e
```

### Writing Good Tests

- **Arrange, Act, Assert** pattern
- **One assertion per test** (when possible)
- **Test behavior, not implementation**
- **Use descriptive test names**
- **Mock external dependencies**

## Documentation

### Code Documentation

```typescript
/**
 * Creates a new game with the specified parameters
 * @param gameData - The game data including title, court, time, etc.
 * @param userId - The ID of the user creating the game
 * @returns Promise resolving to the created game object
 * @throws {ValidationError} If game data is invalid
 * @throws {AuthorizationError} If user is not authorized
 */
async function createGame(
  gameData: CreateGameInput,
  userId: string
): Promise<Game> {
  // Implementation
}
```

### Updating Documentation

When making changes, update:
- Code comments (for complex logic)
- README.md (for setup/usage changes)
- API_CONTRACTS.md (for API changes)
- DESIGN_SYSTEM.md (for UI changes)
- PRODUCT_ROADMAP.md (for feature additions)

## Deployment Process

### Staging Deployment

Automatic on push to `develop`:
```bash
git push origin develop
```

### Production Deployment

Automatic on push to `main`:
```bash
# Merge develop into main
git checkout main
git merge develop
git push origin main
```

### Manual Deployment

```bash
# Deploy backend to staging
npm run deploy:backend:staging

# Deploy app to staging
npm run deploy:app:staging

# Deploy to production (requires elevated permissions)
npm run deploy:production
```

## Getting Help

- **Questions**: Ask in [GitHub Discussions](https://github.com/phalbert2024/zap-api-integration/discussions)
- **Bugs**: Open an [issue](https://github.com/phalbert2024/zap-api-integration/issues)
- **Chat**: Join our [Discord](https://discord.gg/hoopconnect) (coming soon)

## Recognition

Contributors will be recognized in:
- CONTRIBUTORS.md file
- Release notes
- Project README

Thank you for contributing to HoopConnect! 🏀
