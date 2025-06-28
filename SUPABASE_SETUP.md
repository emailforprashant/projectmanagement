# Supabase Setup Guide

This guide will help you set up the Supabase database for your project management app.

## 🚀 Quick Setup

### 1. Environment Variables
The `.env.local` file has been created with your Supabase credentials:
```
NEXT_PUBLIC_SUPABASE_URL=https://vkwnwqapyottzwcotkow.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

### 2. Database Schema Setup

1. **Go to your Supabase Dashboard**: https://supabase.com/dashboard
2. **Select your project**: `vkwnwqapyottzwcotkow`
3. **Navigate to SQL Editor** (in the left sidebar)
4. **Copy and paste** the contents of `supabase-schema.sql`
5. **Click "Run"** to execute the schema

### 3. Verify Setup

After running the schema, you should have:
- ✅ `projects` table with sample data
- ✅ `project_members` table with team members
- ✅ `tasks` table with sample tasks
- ✅ Proper indexes and triggers

## 📊 Database Tables

### Projects Table
```sql
CREATE TABLE projects (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    status VARCHAR(20) CHECK (status IN ('planning', 'in-progress', 'completed', 'on-hold')),
    progress INTEGER CHECK (progress >= 0 AND progress <= 100) DEFAULT 0,
    due_date DATE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

### Project Members Table
```sql
CREATE TABLE project_members (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    project_id UUID REFERENCES projects(id) ON DELETE CASCADE,
    user_name VARCHAR(255) NOT NULL,
    role VARCHAR(100) DEFAULT 'member',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

### Tasks Table
```sql
CREATE TABLE tasks (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    project_id UUID REFERENCES projects(id) ON DELETE CASCADE,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    status VARCHAR(20) CHECK (status IN ('todo', 'in-progress', 'completed')),
    priority VARCHAR(10) CHECK (priority IN ('low', 'medium', 'high')),
    assigned_to VARCHAR(255),
    due_date DATE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

## 🔧 Features

### Current Features
- ✅ **Project CRUD Operations**: Create, read, update, delete projects
- ✅ **Real-time Data**: Projects load from Supabase database
- ✅ **Team Management**: Display team members for each project
- ✅ **Status Tracking**: Visual status indicators with progress bars
- ✅ **Error Handling**: Proper error messages and loading states

### Sample Data Included
- 4 sample projects with different statuses
- 10 team members across the projects
- 9 sample tasks with various priorities

## 🚀 Next Steps

### Optional Enhancements
1. **User Authentication**: Add Supabase Auth for user login
2. **Real-time Updates**: Enable real-time subscriptions
3. **Task Management**: Add task creation and management
4. **File Uploads**: Add project file attachments
5. **Advanced Filtering**: Add search and filter capabilities

### Security Considerations
- Row Level Security (RLS) is enabled
- Anon key is safe for client-side use
- Service role key should remain private

## 🐛 Troubleshooting

### Common Issues

1. **"Failed to load projects" error**
   - Check if the database schema has been run
   - Verify environment variables are correct
   - Check Supabase project status

2. **"Network error"**
   - Ensure Supabase project is active
   - Check internet connection
   - Verify project URL is correct

3. **"Permission denied"**
   - Check RLS policies in Supabase
   - Verify anon key permissions

### Getting Help
- Check Supabase logs in the dashboard
- Review browser console for errors
- Verify table structure in Supabase Table Editor

## 📝 Notes

- The app uses the `anon` key for all operations
- All data is stored in Supabase PostgreSQL database
- Real-time features can be added using Supabase subscriptions
- The schema includes proper foreign key relationships and constraints 