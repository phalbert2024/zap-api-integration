/**
 * Court Seeding Script for HoopConnect
 * 
 * This script populates the database with initial court data.
 * Run this script after setting up the database schema.
 * 
 * Usage: node seed-courts.js
 */

const sampleCourts = [
  {
    name: 'Downtown Recreation Center',
    description: 'Full-size indoor court with excellent lighting and climate control',
    street: '123 Main Street',
    city: 'San Francisco',
    state: 'CA',
    zipCode: '94102',
    latitude: 37.7749,
    longitude: -122.4194,
    type: 'indoor',
    surface: 'hardwood',
    numberOfHoops: 2,
    hasLighting: true,
    amenities: [
      { type: 'parking', available: true },
      { type: 'restrooms', available: true },
      { type: 'water', available: true },
      { type: 'benches', available: true }
    ]
  },
  {
    name: 'Golden Gate Park Courts',
    description: 'Popular outdoor courts in the heart of Golden Gate Park',
    street: '501 Stanyan Street',
    city: 'San Francisco',
    state: 'CA',
    zipCode: '94117',
    latitude: 37.7694,
    longitude: -122.4862,
    type: 'outdoor',
    surface: 'concrete',
    numberOfHoops: 4,
    hasLighting: true,
    amenities: [
      { type: 'parking', available: true },
      { type: 'restrooms', available: true },
      { type: 'water', available: false },
      { type: 'benches', available: true }
    ]
  },
  {
    name: 'Mission District Street Court',
    description: 'Classic street court with great community vibe',
    street: '2300 Mission Street',
    city: 'San Francisco',
    state: 'CA',
    zipCode: '94110',
    latitude: 37.7599,
    longitude: -122.4148,
    type: 'outdoor',
    surface: 'asphalt',
    numberOfHoops: 2,
    hasLighting: false,
    amenities: [
      { type: 'parking', available: false },
      { type: 'restrooms', available: false },
      { type: 'water', available: false },
      { type: 'benches', available: true }
    ]
  },
  {
    name: 'Marina Waterfront Courts',
    description: 'Beautiful courts with bay views, perfect for evening games',
    street: '1 Marina Boulevard',
    city: 'San Francisco',
    state: 'CA',
    zipCode: '94123',
    latitude: 37.8058,
    longitude: -122.4369,
    type: 'outdoor',
    surface: 'synthetic',
    numberOfHoops: 3,
    hasLighting: true,
    amenities: [
      { type: 'parking', available: true },
      { type: 'restrooms', available: true },
      { type: 'water', available: true },
      { type: 'benches', available: true }
    ]
  },
  {
    name: 'Sunset District Community Center',
    description: 'Well-maintained indoor facility, great for winter play',
    street: '2601 Ocean Avenue',
    city: 'San Francisco',
    state: 'CA',
    zipCode: '94132',
    latitude: 37.7343,
    longitude: -122.4862,
    type: 'indoor',
    surface: 'hardwood',
    numberOfHoops: 2,
    hasLighting: true,
    amenities: [
      { type: 'parking', available: true },
      { type: 'restrooms', available: true },
      { type: 'water', available: true },
      { type: 'benches', available: true }
    ]
  }
];

/**
 * Seed courts into the database
 * This is a template function - you'll need to implement the actual database connection
 */
async function seedCourts() {
  console.log('Starting court seeding...');
  
  try {
    // TODO: Initialize your database connection here
    // Example for Firebase:
    // const db = admin.firestore();
    
    // Example for Supabase:
    // const { createClient } = require('@supabase/supabase-js');
    // const supabase = createClient(SUPABASE_URL, SUPABASE_KEY);
    
    let seededCount = 0;
    
    for (const court of sampleCourts) {
      console.log(`Seeding court: ${court.name}`);
      
      // TODO: Insert court into database
      // Example for Firebase:
      // await db.collection('courts').add({
      //   ...court,
      //   location: new admin.firestore.GeoPoint(court.latitude, court.longitude),
      //   createdAt: admin.firestore.FieldValue.serverTimestamp(),
      //   updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      //   isVerified: true,
      //   rating: 0,
      //   reviewCount: 0
      // });
      
      // Example for Supabase:
      // const { data, error } = await supabase
      //   .from('courts')
      //   .insert({
      //     name: court.name,
      //     description: court.description,
      //     street: court.street,
      //     city: court.city,
      //     state: court.state,
      //     zip_code: court.zipCode,
      //     location: `POINT(${court.longitude} ${court.latitude})`,
      //     type: court.type,
      //     surface: court.surface,
      //     number_of_hoops: court.numberOfHoops,
      //     has_lighting: court.hasLighting,
      //     is_verified: true
      //   });
      
      seededCount++;
    }
    
    console.log(`✅ Successfully seeded ${seededCount} courts!`);
  } catch (error) {
    console.error('❌ Error seeding courts:', error);
    throw error;
  }
}

/**
 * Run the seeding script
 */
if (require.main === module) {
  seedCourts()
    .then(() => {
      console.log('Court seeding completed');
      process.exit(0);
    })
    .catch((error) => {
      console.error('Court seeding failed:', error);
      process.exit(1);
    });
}

module.exports = { seedCourts, sampleCourts };
