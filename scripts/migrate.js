const fs = require('fs');
const path = require('path');
const { Pool } = require('pg');

// Database connection configuration
const pool = new Pool({
  connectionString: process.env.DATABASE_URL || 'postgresql://localhost:5432/hospital_db',
});

async function migrate() {
  try {
    console.log('🚀 Starting database migration...');
    
    // Read the SQL file
    const sqlFilePath = path.join(__dirname, '..', 'db', 'init.sql');
    const sql = fs.readFileSync(sqlFilePath, 'utf-8');
    
    console.log('📖 Reading SQL file...');
    
    // Execute the SQL
    await pool.query(sql);
    
    console.log('✅ Database migration completed successfully!');
    console.log('📊 Tables created: doctors, patients, services, appointments, receipts');
    console.log('🔍 Indexes created for better performance');
    console.log('📝 Sample data inserted');
    
  } catch (error) {
    console.error('❌ Migration failed:', error.message);
    process.exit(1);
  } finally {
    await pool.end();
  }
}

// Run migration
migrate();
