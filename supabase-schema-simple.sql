-- Create projects table
CREATE TABLE IF NOT EXISTS projects (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    status VARCHAR(20) DEFAULT 'planning' CHECK (status IN ('planning', 'in-progress', 'completed', 'on-hold')),
    progress INTEGER DEFAULT 0 CHECK (progress >= 0 AND progress <= 100),
    due_date DATE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create project_members table
CREATE TABLE IF NOT EXISTS project_members (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    project_id UUID REFERENCES projects(id) ON DELETE CASCADE,
    user_name VARCHAR(255) NOT NULL,
    role VARCHAR(100) DEFAULT 'member',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create tasks table
CREATE TABLE IF NOT EXISTS tasks (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    project_id UUID REFERENCES projects(id) ON DELETE CASCADE,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    status VARCHAR(20) DEFAULT 'todo' CHECK (status IN ('todo', 'in-progress', 'completed')),
    priority VARCHAR(10) DEFAULT 'medium' CHECK (priority IN ('low', 'medium', 'high')),
    assigned_to VARCHAR(255),
    due_date DATE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_projects_status ON projects(status);
CREATE INDEX IF NOT EXISTS idx_projects_due_date ON projects(due_date);
CREATE INDEX IF NOT EXISTS idx_project_members_project_id ON project_members(project_id);
CREATE INDEX IF NOT EXISTS idx_tasks_project_id ON tasks(project_id);
CREATE INDEX IF NOT EXISTS idx_tasks_status ON tasks(status);
CREATE INDEX IF NOT EXISTS idx_tasks_assigned_to ON tasks(assigned_to);

-- Create updated_at trigger function
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Create triggers for updated_at
DROP TRIGGER IF EXISTS update_projects_updated_at ON projects;
CREATE TRIGGER update_projects_updated_at BEFORE UPDATE ON projects
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_tasks_updated_at ON tasks;
CREATE TRIGGER update_tasks_updated_at BEFORE UPDATE ON tasks
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Insert sample data
INSERT INTO projects (name, description, status, progress, due_date) VALUES
('Website Redesign', 'Complete overhaul of the company website with modern design and improved user experience.', 'in-progress', 65, '2024-02-15'),
('Mobile App Development', 'Development of a new mobile application for iOS and Android platforms.', 'planning', 25, '2024-03-20'),
('Database Migration', 'Migrating from legacy database system to modern cloud-based solution.', 'completed', 100, '2024-01-30'),
('Marketing Campaign', 'Launch of new marketing campaign for Q1 product releases.', 'on-hold', 40, '2024-02-28')
ON CONFLICT DO NOTHING;

-- Insert sample project members
INSERT INTO project_members (project_id, user_name, role) VALUES
((SELECT id FROM projects WHERE name = 'Website Redesign' LIMIT 1), 'John Doe', 'Lead Developer'),
((SELECT id FROM projects WHERE name = 'Website Redesign' LIMIT 1), 'Jane Smith', 'Designer'),
((SELECT id FROM projects WHERE name = 'Website Redesign' LIMIT 1), 'Mike Johnson', 'Developer'),
((SELECT id FROM projects WHERE name = 'Mobile App Development' LIMIT 1), 'Sarah Wilson', 'Mobile Developer'),
((SELECT id FROM projects WHERE name = 'Mobile App Development' LIMIT 1), 'Alex Brown', 'UI/UX Designer'),
((SELECT id FROM projects WHERE name = 'Database Migration' LIMIT 1), 'David Lee', 'Database Admin'),
((SELECT id FROM projects WHERE name = 'Database Migration' LIMIT 1), 'Emily Chen', 'Backend Developer'),
((SELECT id FROM projects WHERE name = 'Database Migration' LIMIT 1), 'Tom Davis', 'DevOps Engineer'),
((SELECT id FROM projects WHERE name = 'Marketing Campaign' LIMIT 1), 'Lisa Wang', 'Marketing Manager'),
((SELECT id FROM projects WHERE name = 'Marketing Campaign' LIMIT 1), 'Chris Taylor', 'Content Creator')
ON CONFLICT DO NOTHING;

-- Insert sample tasks
INSERT INTO tasks (project_id, title, description, status, priority, assigned_to, due_date) VALUES
((SELECT id FROM projects WHERE name = 'Website Redesign' LIMIT 1), 'Design Homepage', 'Create new homepage design with modern layout', 'completed', 'high', 'Jane Smith', '2024-01-15'),
((SELECT id FROM projects WHERE name = 'Website Redesign' LIMIT 1), 'Implement Navigation', 'Build responsive navigation component', 'in-progress', 'high', 'John Doe', '2024-01-20'),
((SELECT id FROM projects WHERE name = 'Website Redesign' LIMIT 1), 'Mobile Optimization', 'Optimize website for mobile devices', 'todo', 'medium', 'Mike Johnson', '2024-02-01'),
((SELECT id FROM projects WHERE name = 'Mobile App Development' LIMIT 1), 'App Architecture', 'Design app architecture and structure', 'completed', 'high', 'Sarah Wilson', '2024-01-10'),
((SELECT id FROM projects WHERE name = 'Mobile App Development' LIMIT 1), 'UI Design', 'Create app UI design and mockups', 'in-progress', 'high', 'Alex Brown', '2024-01-25'),
((SELECT id FROM projects WHERE name = 'Database Migration' LIMIT 1), 'Backup Current DB', 'Create backup of current database', 'completed', 'high', 'David Lee', '2024-01-05'),
((SELECT id FROM projects WHERE name = 'Database Migration' LIMIT 1), 'Setup New Environment', 'Configure new database environment', 'completed', 'high', 'Tom Davis', '2024-01-08'),
((SELECT id FROM projects WHERE name = 'Marketing Campaign' LIMIT 1), 'Content Strategy', 'Develop content marketing strategy', 'todo', 'medium', 'Lisa Wang', '2024-02-10'),
((SELECT id FROM projects WHERE name = 'Marketing Campaign' LIMIT 1), 'Social Media Plan', 'Create social media marketing plan', 'todo', 'medium', 'Chris Taylor', '2024-02-15')
ON CONFLICT DO NOTHING; 