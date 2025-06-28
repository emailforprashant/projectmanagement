'use client';

import { useState, useEffect } from 'react';
import type { Project } from '../../lib/supabase';
import { memberService } from '../../lib/database';

interface ProjectCardProps {
  project: Project;
  onEdit: (project: Project) => void;
  onDelete: (id: string) => void;
}

export default function ProjectCard({ project, onEdit, onDelete }: ProjectCardProps) {
  const [teamMembers, setTeamMembers] = useState<string[]>([]);

  useEffect(() => {
    const fetchTeamMembers = async () => {
      try {
        const members = await memberService.getProjectMembers(project.id);
        setTeamMembers(members.map(member => member.user_name));
      } catch (err) {
        console.error('Error fetching team members:', err);
      }
    };

    fetchTeamMembers();
  }, [project.id]);

  const getStatusColor = (status: Project['status']) => {
    switch (status) {
      case 'planning':
        return 'bg-blue-100 text-blue-800';
      case 'in-progress':
        return 'bg-yellow-100 text-yellow-800';
      case 'completed':
        return 'bg-green-100 text-green-800';
      case 'on-hold':
        return 'bg-red-100 text-red-800';
      default:
        return 'bg-gray-100 text-gray-800';
    }
  };

  const getStatusText = (status: Project['status']) => {
    switch (status) {
      case 'planning':
        return 'Planning';
      case 'in-progress':
        return 'In Progress';
      case 'completed':
        return 'Completed';
      case 'on-hold':
        return 'On Hold';
      default:
        return status;
    }
  };

  return (
    <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-6 hover:shadow-md transition-shadow">
      <div className="flex justify-between items-start mb-4">
        <div>
          <h3 className="text-lg font-semibold text-gray-900 mb-1">{project.name}</h3>
          <p className="text-sm text-gray-600 line-clamp-2">{project.description}</p>
        </div>
        <div className="flex space-x-2">
          <button
            onClick={() => onEdit(project)}
            className="text-gray-400 hover:text-gray-600 p-1"
          >
            <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z" />
            </svg>
          </button>
          <button
            onClick={() => onDelete(project.id)}
            className="text-gray-400 hover:text-red-600 p-1"
          >
            <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
            </svg>
          </button>
        </div>
      </div>

      <div className="space-y-3">
        <div className="flex items-center justify-between">
          <span className={`inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium ${getStatusColor(project.status)}`}>
            {getStatusText(project.status)}
          </span>
          <span className="text-sm text-gray-500">
            Due: {project.due_date ? new Date(project.due_date).toLocaleDateString() : 'No due date'}
          </span>
        </div>

        <div>
          <div className="flex justify-between text-sm text-gray-600 mb-1">
            <span>Progress</span>
            <span>{project.progress}%</span>
          </div>
          <div className="w-full bg-gray-200 rounded-full h-2">
            <div
              className="bg-indigo-600 h-2 rounded-full transition-all duration-300"
              style={{ width: `${project.progress}%` }}
            ></div>
          </div>
        </div>

        <div className="flex items-center justify-between">
          <div className="flex -space-x-2">
            {teamMembers.slice(0, 3).map((member, index) => (
              <div
                key={index}
                className="w-8 h-8 rounded-full bg-indigo-100 border-2 border-white flex items-center justify-center"
              >
                <span className="text-xs font-medium text-indigo-600">
                  {member.charAt(0).toUpperCase()}
                </span>
              </div>
            ))}
            {teamMembers.length > 3 && (
              <div className="w-8 h-8 rounded-full bg-gray-100 border-2 border-white flex items-center justify-center">
                <span className="text-xs font-medium text-gray-600">
                  +{teamMembers.length - 3}
                </span>
              </div>
            )}
          </div>
        </div>
      </div>
    </div>
  );
} 