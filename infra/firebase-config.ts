/**
 * Firebase Configuration for HoopConnect
 * 
 * This file contains Firebase project configurations for different environments.
 * Replace the placeholder values with your actual Firebase project credentials.
 * 
 * IMPORTANT: Never commit actual API keys to version control.
 * Use environment variables in production.
 */

export interface FirebaseConfig {
  apiKey: string;
  authDomain: string;
  projectId: string;
  storageBucket: string;
  messagingSenderId: string;
  appId: string;
  measurementId?: string;
}

/**
 * Development Environment Configuration
 * Used for local development and testing
 */
export const firebaseConfigDev: FirebaseConfig = {
  apiKey: process.env.FIREBASE_API_KEY_DEV || 'YOUR_DEV_API_KEY',
  authDomain: process.env.FIREBASE_AUTH_DOMAIN_DEV || 'hoopconnect-dev.firebaseapp.com',
  projectId: process.env.FIREBASE_PROJECT_ID_DEV || 'hoopconnect-dev',
  storageBucket: process.env.FIREBASE_STORAGE_BUCKET_DEV || 'hoopconnect-dev.appspot.com',
  messagingSenderId: process.env.FIREBASE_MESSAGING_SENDER_ID_DEV || 'YOUR_DEV_SENDER_ID',
  appId: process.env.FIREBASE_APP_ID_DEV || 'YOUR_DEV_APP_ID',
  measurementId: process.env.FIREBASE_MEASUREMENT_ID_DEV || 'G-XXXXXXXXXX',
};

/**
 * Staging Environment Configuration
 * Used for QA and pre-production testing
 */
export const firebaseConfigStage: FirebaseConfig = {
  apiKey: process.env.FIREBASE_API_KEY_STAGE || 'YOUR_STAGE_API_KEY',
  authDomain: process.env.FIREBASE_AUTH_DOMAIN_STAGE || 'hoopconnect-stage.firebaseapp.com',
  projectId: process.env.FIREBASE_PROJECT_ID_STAGE || 'hoopconnect-stage',
  storageBucket: process.env.FIREBASE_STORAGE_BUCKET_STAGE || 'hoopconnect-stage.appspot.com',
  messagingSenderId: process.env.FIREBASE_MESSAGING_SENDER_ID_STAGE || 'YOUR_STAGE_SENDER_ID',
  appId: process.env.FIREBASE_APP_ID_STAGE || 'YOUR_STAGE_APP_ID',
  measurementId: process.env.FIREBASE_MEASUREMENT_ID_STAGE || 'G-YYYYYYYYYY',
};

/**
 * Production Environment Configuration
 * Used for live production environment
 */
export const firebaseConfigProd: FirebaseConfig = {
  apiKey: process.env.FIREBASE_API_KEY_PROD || 'YOUR_PROD_API_KEY',
  authDomain: process.env.FIREBASE_AUTH_DOMAIN_PROD || 'hoopconnect.firebaseapp.com',
  projectId: process.env.FIREBASE_PROJECT_ID_PROD || 'hoopconnect-prod',
  storageBucket: process.env.FIREBASE_STORAGE_BUCKET_PROD || 'hoopconnect-prod.appspot.com',
  messagingSenderId: process.env.FIREBASE_MESSAGING_SENDER_ID_PROD || 'YOUR_PROD_SENDER_ID',
  appId: process.env.FIREBASE_APP_ID_PROD || 'YOUR_PROD_APP_ID',
  measurementId: process.env.FIREBASE_MEASUREMENT_ID_PROD || 'G-ZZZZZZZZZZ',
};

/**
 * Get Firebase configuration based on current environment
 * @returns FirebaseConfig object for the current environment
 */
export const getFirebaseConfig = (): FirebaseConfig => {
  const env = process.env.NODE_ENV || 'development';
  
  switch (env) {
    case 'production':
      return firebaseConfigProd;
    case 'staging':
      return firebaseConfigStage;
    case 'development':
    default:
      return firebaseConfigDev;
  }
};

/**
 * Validate Firebase configuration
 * Ensures all required fields are present
 */
export const validateFirebaseConfig = (config: FirebaseConfig): boolean => {
  const requiredFields: (keyof FirebaseConfig)[] = [
    'apiKey',
    'authDomain',
    'projectId',
    'storageBucket',
    'messagingSenderId',
    'appId',
  ];

  for (const field of requiredFields) {
    if (!config[field] || config[field].startsWith('YOUR_')) {
      console.error(`Firebase config error: ${field} is not properly configured`);
      return false;
    }
  }

  return true;
};

/**
 * Firebase Emulator Configuration
 * Used for local development with Firebase emulators
 */
export const firebaseEmulatorConfig = {
  auth: {
    host: 'localhost',
    port: 9099,
  },
  firestore: {
    host: 'localhost',
    port: 8080,
  },
  storage: {
    host: 'localhost',
    port: 9199,
  },
  functions: {
    host: 'localhost',
    port: 5001,
  },
};

/**
 * Check if Firebase emulators should be used
 */
export const useEmulators = (): boolean => {
  return process.env.USE_FIREBASE_EMULATORS === 'true' || 
         process.env.NODE_ENV === 'test';
};

// Export default configuration
export default getFirebaseConfig();
