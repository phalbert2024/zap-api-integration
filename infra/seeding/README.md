# Seeding Scripts for HoopConnect

This directory contains scripts to populate the database with initial data for development and testing purposes.

## Available Scripts

### `seed-courts.js`
Populates the database with sample basketball courts in the San Francisco area.

**Usage:**
```bash
node seed-courts.js
```

## Setup Instructions

1. **Install Dependencies** (if needed):
   ```bash
   npm install
   # or
   yarn install
   ```

2. **Configure Database Connection**:
   - Update the seeding scripts with your actual database connection details
   - For Firebase: Initialize `firebase-admin` with your service account
   - For Supabase: Use your project URL and service key

3. **Run Seeding Scripts**:
   ```bash
   # Seed courts
   node seed-courts.js
   
   # Add more seeding scripts as needed
   # node seed-users.js
   # node seed-games.js
   ```

## Environment Variables

Create a `.env` file in the `/infra` directory with the following variables:

### For Firebase:
```env
FIREBASE_PROJECT_ID=your-project-id
FIREBASE_PRIVATE_KEY=your-private-key
FIREBASE_CLIENT_EMAIL=your-client-email
```

### For Supabase:
```env
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_SERVICE_KEY=your-service-key
```

## Creating New Seeding Scripts

To create a new seeding script:

1. Create a new file in this directory (e.g., `seed-users.js`)
2. Follow the pattern used in `seed-courts.js`
3. Export the seeding function for reusability
4. Update this README with usage instructions

Example template:
```javascript
async function seedData() {
  console.log('Starting seeding...');
  
  // Your seeding logic here
  
  console.log('Seeding completed!');
}

if (require.main === module) {
  seedData()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error('Seeding failed:', error);
      process.exit(1);
    });
}

module.exports = { seedData };
```

## Best Practices

1. **Idempotency**: Make your seeding scripts idempotent (safe to run multiple times)
2. **Error Handling**: Always include proper error handling
3. **Logging**: Add clear logging messages for debugging
4. **Data Quality**: Use realistic, diverse sample data
5. **Documentation**: Document any special requirements or dependencies

## Production Warning

⚠️ **NEVER run seeding scripts against production databases!**

These scripts are intended for development and staging environments only.

## Future Improvements

- [ ] Add comprehensive user seeding
- [ ] Add game seeding with various statuses
- [ ] Add friendship relationships
- [ ] Add sample messages and conversations
- [ ] Add reviews for courts
- [ ] Create a master seeding script that runs all seeders
- [ ] Add data cleanup scripts
- [ ] Add seeding for different geographic locations
