# Development Guide

This document provides detailed information about the project structure, how to develop new features, and best practices.

## 📁 Detailed File Structure

### Backend Structure

```
backend/
├── app.py                    # Main application entry point
│                             # - Creates Flask app instance
│                             # - Initializes database
│                             # - Registers blueprints
│                             # - Creates admin user
│
├── config/
│   └── config.py            # Configuration management
│                           # - Loads environment variables
│                           # - Database URI configuration
│                           # - Email configuration
│                           # - Secret key management
│
├── models/
│   ├── __init__.py         # Exports all models
│   └── models.py           # Database models
│                           # - User: Authentication and authorization
│                           # - Subject: Course subjects
│                           # - Marks: Student grades
│                           # - Attendance: Attendance records
│                           # - Notes: Student notes
│
├── routes/
│   ├── __init__.py         # Blueprint initialization and registration
│   ├── auth_routes.py      # Authentication endpoints
│   │                       # - POST /api/register
│   │                       # - POST /api/login
│   │                       # - POST /api/forgot-password
│   │                       # - POST /api/reset-password
│   │
│   ├── subject_routes.py   # Subject management
│   │                       # - POST /api/subjects (create)
│   │                       # - GET /api/subjects (list)
│   │                       # - PUT /api/subjects/<id> (update)
│   │                       # - DELETE /api/subjects/<id> (delete)
│   │
│   ├── marks_routes.py     # Marks management
│   │                       # - POST /api/marks (add)
│   │                       # - PUT /api/marks/<id> (update)
│   │                       # - DELETE /api/marks/<id> (delete)
│   │                       # - GET /api/marks/student/<id> (get student marks)
│   │
│   ├── attendance_routes.py # Attendance management
│   │                       # - POST /api/attendance (add)
│   │                       # - PUT /api/attendance/<id> (update)
│   │                       # - DELETE /api/attendance/<id> (delete)
│   │                       # - GET /api/attendance/student/<id> (get student attendance)
│   │
│   ├── notes_routes.py     # Notes management
│   │                       # - POST /api/notes (add)
│   │                       # - DELETE /api/notes/<id> (delete)
│   │                       # - GET /api/notes/student/<id> (get student notes)
│   │
│   └── dashboard_routes.py # Dashboard data
│                           # - GET /api/dashboard/student/<id> (get student dashboard)
│                           # - GET /api/students (list all students)
│
├── utils/
│   ├── __init__.py         # Exports utility functions
│   ├── decorators.py       # Authentication decorators
│   │                       # - @token_required: Requires valid token
│   │                       # - @role_required: Requires specific role
│   │
│   ├── email.py            # Email utilities
│   │                       # - send_email(): Send email via Flask-Mail
│   │
│   └── helpers.py         # Helper functions
│                           # - create_admin(): Create default admin user
│
└── requirements.txt        # Python dependencies
```

### Frontend Structure

```
frontend/student_management/
├── src/
│   ├── components/         # React components
│   │   ├── Input.js        # Reusable input component
│   │   ├── Input.css       # Input component styles
│   │   ├── Login.js         # Login page component
│   │   ├── Register.js     # Registration page component
│   │   ├── ForgotPassword.js # Password reset component
│   │   ├── StudentDashboard.js # Student dashboard
│   │   │                    # - Marks display
│   │   │                    # - Attendance display
│   │   │                    # - Notes management
│   │   │
│   │   ├── StaffDashboard.js # Staff/Admin dashboard
│   │   │                    # - Subjects management
│   │   │                    # - Marks management
│   │   │                    # - Attendance management
│   │   │                    # - Student view
│   │   │                    # - Staff registration
│   │   │
│   │   ├── Auth.css        # Authentication page styles
│   │   └── Dashboard.css   # Dashboard page styles
│   │
│   ├── services/
│   │   └── api.js          # API client
│   │                       # - request(): Base HTTP request function
│   │                       # - Authentication methods
│   │                       # - CRUD operations for all entities
│   │
│   ├── utils/
│   │   └── auth.js         # Authentication utilities
│   │                       # - saveAuthFromLoginResponse(): Save auth data
│   │                       # - getCurrentUser(): Get current user
│   │                       # - clearAuth(): Clear auth data
│   │
│   ├── App.js              # Main application component
│   │                       # - Route management
│   │                       # - Authentication state
│   │                       # - Component rendering
│   │
│   └── App.css             # Global styles
│
├── public/                 # Static files
└── package.json           # Node.js dependencies
```

## 🔧 How Each File Works

### Backend Files

**app.py:**
- Creates Flask application using factory pattern
- Loads configuration from Config class
- Initializes SQLAlchemy, Flask-Mail, and CORS
- Registers all blueprints
- Creates database tables and admin user on startup

**config/config.py:**
- Loads environment variables from `.env` file
- Provides default values for development
- Centralizes all configuration settings

**models/models.py:**
- Defines SQLAlchemy models for all database tables
- Uses Flask-SQLAlchemy for database operations
- Relationships defined via ForeignKey

**routes/*.py:**
- Organize API endpoints by feature
- Use Flask blueprints for modular routing
- Apply decorators for authentication/authorization
- Return JSON responses

**utils/decorators.py:**
- `@token_required`: Validates token and user ID from headers
- `@role_required`: Checks user role against required roles
- Can be combined: `@token_required` + `@role_required(["admin"])`

**utils/email.py:**
- Sends emails using Flask-Mail
- Handles errors gracefully
- Returns success/failure status

### Frontend Files

**App.js:**
- Main application component
- Manages authentication state
- Routes between Login, Register, ForgotPassword, and Dashboard components
- Persists authentication in localStorage

**components/Login.js:**
- Handles user login
- Calls API login endpoint
- Saves authentication data
- Redirects to appropriate dashboard

**components/StudentDashboard.js:**
- Displays student's marks, attendance, and notes
- Allows students to add/delete notes
- Fetches data from dashboard API endpoint

**components/StaffDashboard.js:**
- Tabbed interface for different features
- Manages subjects, marks, attendance
- Views student dashboards
- Registers new staff (admin only)

**services/api.js:**
- Centralized API client
- Handles authentication headers
- Provides methods for all API endpoints
- Error handling and response parsing

**utils/auth.js:**
- Manages authentication state in localStorage
- Provides helper functions for auth operations
- Handles token and user data storage

## 🚀 Adding New Features

### Adding a New Backend Endpoint

1. **Create/Update Model** (if needed):
   ```python
   # models/models.py
   class NewFeature(db.Model):
       id = db.Column(db.Integer, primary_key=True)
       # ... fields
   ```

2. **Create Route File**:
   ```python
   # routes/new_feature_routes.py
   from flask import request, jsonify
   from routes import new_feature_bp
   from models.models import db, NewFeature
   from utils.decorators import token_required, role_required
   
   @new_feature_bp.route("/new-feature", methods=["POST"])
   @token_required
   @role_required(["admin"])
   def create_feature(user):
       # Implementation
   ```

3. **Register Blueprint**:
   ```python
   # routes/__init__.py
   new_feature_bp = Blueprint('new_feature', __name__, url_prefix='/api')
   from . import new_feature_routes
   ```

4. **Register in app.py**:
   ```python
   # app.py
   from routes import new_feature_bp
   app.register_blueprint(new_feature_bp)
   ```

### Adding a New Frontend Component

1. **Create Component**:
   ```javascript
   // components/NewComponent.js
   import React, { useState } from 'react';
   import './NewComponent.css';
   
   const NewComponent = ({ prop1, prop2 }) => {
     // Component logic
     return <div>Component JSX</div>;
   };
   
   export default NewComponent;
   ```

2. **Create Styles**:
   ```css
   /* components/NewComponent.css */
   .new-component {
     /* Styles */
   }
   ```

3. **Add API Method** (if needed):
   ```javascript
   // services/api.js
   newFeature: (data) => 
     api.request('/new-feature', { 
       method: 'POST', 
       body: JSON.stringify(data) 
     }),
   ```

4. **Use in App.js**:
   ```javascript
   import NewComponent from './components/NewComponent';
   // Use in render
   ```

## 🎨 Styling Guidelines

- Use CSS modules or separate CSS files per component
- Follow BEM-like naming conventions
- Use Tailwind-like utility classes (or add Tailwind CSS)
- Mobile-first responsive design
- Consistent color scheme and spacing

## 📝 Best Practices

### Backend

1. **Always use decorators** for protected routes
2. **Validate input** before processing
3. **Handle errors** gracefully with appropriate HTTP status codes
4. **Use environment variables** for configuration
5. **Document** your code with docstrings
6. **Follow PEP 8** style guide

### Frontend

1. **Use functional components** with hooks
2. **Handle loading states** in async operations
3. **Show error messages** to users
4. **Validate forms** before submission
5. **Use consistent naming** for components and functions
6. **Keep components small** and focused

## 🧪 Testing

### Backend Testing

Create tests in `backend/tests/`:

```python
# tests/test_auth.py
import pytest
from app import create_app

@pytest.fixture
def client():
    app = create_app()
    with app.test_client() as client:
        yield client

def test_login(client):
    response = client.post('/api/login', json={
        'email': 'test@example.com',
        'password': 'password'
    })
    assert response.status_code == 200
```

### Frontend Testing

Use React Testing Library:

```javascript
// components/__tests__/Login.test.js
import { render, screen } from '@testing-library/react';
import Login from '../Login';

test('renders login form', () => {
  render(<Login />);
  expect(screen.getByText('Sign in')).toBeInTheDocument();
});
```

## 🔍 Debugging

### Backend

- Enable Flask debug mode: `app.run(debug=True)`
- Check logs in terminal
- Use Flask debugger for errors
- Check database queries with SQLAlchemy logging

### Frontend

- Use React DevTools
- Check browser console for errors
- Use Network tab to inspect API calls
- Enable React error boundaries

## 📚 Resources

- [Flask Documentation](https://flask.palletsprojects.com/)
- [React Documentation](https://react.dev/)
- [SQLAlchemy Documentation](https://docs.sqlalchemy.org/)
- [Flask-SQLAlchemy Documentation](https://flask-sqlalchemy.palletsprojects.com/)

