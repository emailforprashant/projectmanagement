# 🚀 ProjectHub - Modern Project Management App

A beautiful, modern project management application built with Next.js, TypeScript, Tailwind CSS, and Supabase. Manage your projects, track progress, and collaborate with your team in real-time.

![ProjectHub Dashboard](https://img.shields.io/badge/Next.js-15.3.4-black?style=for-the-badge&logo=next.js)
![TypeScript](https://img.shields.io/badge/TypeScript-5.0-blue?style=for-the-badge&logo=typescript)
![Tailwind CSS](https://img.shields.io/badge/Tailwind_CSS-4.0-38B2AC?style=for-the-badge&logo=tailwind-css)
![Supabase](https://img.shields.io/badge/Supabase-Real-time%20Database-3ECF8E?style=for-the-badge&logo=supabase)

## ✨ Features

### 🎯 Core Features
- **Project Management**: Create, edit, and delete projects with full CRUD operations
- **Real-time Dashboard**: Beautiful statistics and project overview
- **Team Collaboration**: Add and manage team members for each project
- **Progress Tracking**: Visual progress bars and status indicators
- **Responsive Design**: Works perfectly on desktop, tablet, and mobile
- **Modern UI**: Clean, professional interface with smooth animations

### 📊 Project Features
- **Status Management**: Planning, In Progress, Completed, On Hold
- **Progress Visualization**: Real-time progress bars (0-100%)
- **Due Date Tracking**: Set and monitor project deadlines
- **Team Member Display**: Visual team member avatars with overflow handling
- **Project Statistics**: Dashboard with project counts by status

### 🔧 Technical Features
- **TypeScript**: Full type safety and better development experience
- **Supabase Integration**: Real-time database with PostgreSQL
- **Modern React**: Functional components with hooks
- **Tailwind CSS**: Utility-first CSS framework
- **Error Handling**: Comprehensive error states and loading indicators

## 🛠️ Tech Stack

- **Frontend**: Next.js 15, React 19, TypeScript
- **Styling**: Tailwind CSS 4
- **Database**: Supabase (PostgreSQL)
- **Authentication**: Supabase Auth (ready for implementation)
- **Deployment**: Vercel-ready

## 🚀 Quick Start

### Prerequisites
- Node.js 18+ 
- npm or yarn
- Supabase account

### 1. Clone the Repository
```bash
git clone https://github.com/yourusername/project-management-app.git
cd project-management-app
```

### 2. Install Dependencies
```bash
npm install
```

### 3. Set Up Supabase
1. Create a new project at [supabase.com](https://supabase.com)
2. Copy your project URL and anon key
3. Create a `.env.local` file:
```env
NEXT_PUBLIC_SUPABASE_URL=your_supabase_project_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key
```

### 4. Set Up Database
1. Go to your Supabase Dashboard → SQL Editor
2. Copy and paste the contents of `supabase-schema-simple.sql`
3. Click "Run" to create tables and sample data

### 5. Run the Development Server
```bash
npm run dev
```

Open [http://localhost:3000](http://localhost:3000) to view the app.

## 📁 Project Structure

```
project-management-app/
├── src/
│   ├── app/
│   │   ├── components/
│   │   │   ├── Dashboard.tsx          # Main dashboard component
│   │   │   ├── Navbar.tsx             # Navigation bar
│   │   │   ├── ProjectCard.tsx        # Individual project card
│   │   │   └── AddProjectModal.tsx    # Add/edit project modal
│   │   ├── layout.tsx                 # Root layout
│   │   ├── page.tsx                   # Home page
│   │   └── globals.css                # Global styles
│   └── lib/
│       ├── supabase.ts                # Supabase client config
│       └── database.ts                # Database service functions
├── supabase-schema-simple.sql         # Database schema
├── SUPABASE_SETUP.md                  # Detailed setup guide
└── README.md                          # This file
```

## 🎨 UI Components

### Dashboard
- Project statistics cards
- Project grid with cards
- Add new project button
- Loading and error states

### Project Cards
- Project name and description
- Status badges with color coding
- Progress bars
- Team member avatars
- Edit and delete actions
- Due date display

### Add/Edit Modal
- Form validation
- Status selection
- Progress slider
- Due date picker
- Team member management

## 🔐 Environment Variables

Create a `.env.local` file in the root directory:

```env
NEXT_PUBLIC_SUPABASE_URL=your_supabase_project_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key
```

## 📊 Database Schema

### Projects Table
```sql
CREATE TABLE projects (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    status VARCHAR(20) DEFAULT 'planning',
    progress INTEGER DEFAULT 0,
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
    status VARCHAR(20) DEFAULT 'todo',
    priority VARCHAR(10) DEFAULT 'medium',
    assigned_to VARCHAR(255),
    due_date DATE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

## 🚀 Deployment

### Deploy to Vercel
1. Push your code to GitHub
2. Connect your repository to Vercel
3. Add environment variables in Vercel dashboard
4. Deploy!

### Deploy to Netlify
1. Build the project: `npm run build`
2. Deploy the `out` directory
3. Add environment variables in Netlify dashboard

## 🔮 Future Enhancements

- [ ] User authentication with Supabase Auth
- [ ] Real-time updates with Supabase subscriptions
- [ ] Task management interface
- [ ] File uploads for project attachments
- [ ] Advanced filtering and search
- [ ] Project templates
- [ ] Time tracking
- [ ] Team member roles and permissions
- [ ] Project comments and discussions
- [ ] Email notifications

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Commit your changes: `git commit -m 'Add amazing feature'`
4. Push to the branch: `git push origin feature/amazing-feature`
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [Next.js](https://nextjs.org/) for the amazing React framework
- [Tailwind CSS](https://tailwindcss.com/) for the utility-first CSS framework
- [Supabase](https://supabase.com/) for the real-time database
- [Vercel](https://vercel.com/) for seamless deployment

## 📞 Support

If you have any questions or need help, please open an issue on GitHub or contact us.

---

⭐ **Star this repository if you found it helpful!**
