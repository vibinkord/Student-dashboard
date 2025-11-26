# Student Management System

A comprehensive student management application with backend API and frontend dashboard. This system allows administrators, staff, and students to manage academic records including subjects, marks, attendance, and notes.

## 📁 Project Structure

```
Vibin_Proj/
├── backend/                    # Backend Flask API
│   ├── app.py                 # Main application entry point
│   ├── config/                # Configuration files
│   │   └── config.py          # Application configuration
│   ├── models/                # Database models
│   │   ├── __init__.py
│   │   └── models.py          # User, Subject, Marks, Attendance, Notes models
│   ├── routes/                # API route handlers
│   │   ├── __init__.py        # Blueprint registration
│   │   ├── auth_routes.py     # Authentication routes (login, register, password reset)
│   │   ├── subject_routes.py  # Subject management routes
│   │   ├── marks_routes.py    # Marks management routes
│   │   ├── attendance_routes.py # Attendance management routes
│   │   ├── notes_routes.py    # Notes management routes
│   │   └── dashboard_routes.py # Dashboard data routes
│   ├── utils/                 # Utility functions
│   │   ├── __init__.py
│   │   ├── decorators.py      # Authentication and authorization decorators
│   │   ├── email.py           # Email sending utilities
│   │   └── helpers.py         # Helper functions (admin creation, etc.)
│   ├── requirements.txt       # Python dependencies
│   ├── Dockerfile             # Backend Docker configuration
│   ├── .dockerignore          # Docker ignore patterns
│   └── .env.example           # Environment variables template
│
├── frontend/                  # Frontend React application
│   └── student_management/
│       ├── src/
│       │   ├── components/    # React components
│       │   │   ├── Input.js   # Reusable input component
│       │   │   ├── Input.css
│       │   │   ├── Login.js    # Login component
│       │   │   ├── Register.js # Registration component
│       │   │   ├── ForgotPassword.js # Password reset component
│       │   │   ├── StudentDashboard.js # Student dashboard
│       │   │   ├── StaffDashboard.js   # Staff/Admin dashboard
│       │   │   ├── Auth.css    # Authentication styles
│       │   │   └── Dashboard.css # Dashboard styles
│       │   ├── services/       # API services
│       │   │   └── api.js      # API client functions
│       │   ├── utils/          # Utility functions
│       │   │   └── auth.js     # Authentication utilities
│       │   ├── App.js          # Main application component
│       │   └── App.css         # Global styles
│       ├── public/             # Static files
│       ├── package.json        # Node.js dependencies
│       ├── Dockerfile          # Frontend Docker configuration
│       ├── nginx.conf          # Nginx configuration
│       └── .dockerignore       # Docker ignore patterns
│
├── docker-compose.yml         # Docker Compose configuration
├── run_local.sh              # Script to run application locally
├── dockerize.sh              # Script to build Docker images
└── README.md                  # This file
```

## 🚀 Quick Start

### Prerequisites

- Python 3.11+
- Node.js 18+
- PostgreSQL 15+
- Docker and Docker Compose (optional, for containerized deployment)

### Local Development Setup

#### Option 1: Using the Setup Script (Recommended)

```bash
# Make the script executable (if not already)
chmod +x run_local.sh

# Run the setup script
./run_local.sh
```

This script will:
- Create Python virtual environment for backend
- Install all backend dependencies
- Install all frontend dependencies
- Create `.env` files if they don't exist

#### Option 2: Manual Setup

**Backend Setup:**

```bash
cd backend

# Create virtual environment
python3 -m venv .venv

# Activate virtual environment
source .venv/bin/activate  # On Windows: .venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Create .env file from .env.example
cp .env.example .env
# Edit .env with your configuration

# Run the application
python app.py
```

**Frontend Setup:**

```bash
cd frontend/student_management

# Install dependencies
npm install

# Create .env file
echo "REACT_APP_API_BASE=http://localhost:5000/api" > .env

# Run the application
npm start
```

### Docker Deployment

#### Using Docker Compose (Recommended)

```bash
# Build and start all services
docker-compose up -d

# View logs
docker-compose logs -f

# Stop services
docker-compose down
```

#### Building Docker Images Manually

```bash
# Make the script executable
chmod +x dockerize.sh

# Build images with version
./dockerize.sh 1.0.0

# Or use default 'latest' tag
./dockerize.sh
```

Images will be tagged as:
- `student-management-backend:1.0.0`
- `student-management-frontend:1.0.0`

## 📋 Configuration

### Backend Configuration

Create a `.env` file in the `backend/` directory with the following variables:

```env
DATABASE_URI=postgresql://postgres:postgres@localhost:5432/student_dashboard
SECRET_KEY=your-secret-key-here
MAIL_SERVER=smtp.gmail.com
MAIL_PORT=587
MAIL_USE_TLS=True
MAIL_USERNAME=your-email@gmail.com
MAIL_PASSWORD=your-app-password
MAIL_DEFAULT_SENDER=your-email@gmail.com
ADMIN_EMAIL=admin@example.com
ADMIN_PASSWORD=admin123
# Frontend base URL used in emails for password reset links
FRONTEND_BASE_URL=http://localhost:3000
```

### Frontend Configuration

Create a `.env` file in the `frontend/student_management/` directory:

```env
REACT_APP_API_BASE=http://localhost:5000/api
```

For production, update the API base URL to point to your backend server.

### Password Reset Flow

- Forgot Password triggers an email with a link to the frontend page:
  - `http://<FRONTEND_BASE_URL>/reset-password?token=<token>`
- The Reset Password page submits `POST /api/reset-password` with `{ token, new_password }`.
- Ensure `FRONTEND_BASE_URL` is set correctly in backend `.env`.

## 🏗️ Architecture

### Backend Architecture

The backend follows a modular structure:

- **Models**: SQLAlchemy models for database tables
- **Routes**: Flask blueprints for API endpoints, organized by feature
- **Config**: Configuration management using environment variables
- **Utils**: Reusable decorators and helper functions

**API Endpoints:**

- Authentication: `/api/login`, `/api/register`, `/api/forgot-password`, `/api/reset-password`
- Subjects: `/api/subjects` (GET, POST, PUT, DELETE)
- Marks: `/api/marks`, `/api/marks/student/<id>`
- Attendance: `/api/attendance`, `/api/attendance/student/<id>`
- Notes: `/api/notes`, `/api/notes/student/<id>`
- Dashboard: `/api/dashboard/student/<id>`, `/api/students`
- Users (admin/staff): `/api/users` (GET), `/api/users/<id>` (DELETE)

### Frontend Architecture

The frontend is organized into:

- **Components**: Reusable React components
- **Services**: API communication layer
- **Utils**: Authentication and utility functions
- **Styles**: Component-specific CSS files

**Component Hierarchy:**

```
App
├── Login
├── Register
├── ForgotPassword
├── ResetPassword
├── StudentDashboard
│   ├── Marks Section
│   ├── Attendance Section
│   └── Notes Section
└── StaffDashboard
    ├── Subjects Tab
    ├── Marks Tab
    ├── Attendance Tab
    ├── View Student Tab
    ├── Register Tab (Admin/Staff only)
    └── Delete User Tab (Admin/Staff only)
```

## 🔐 Authentication & Authorization

The application uses token-based authentication:

- **Students**: Can view their own dashboard, marks, attendance, and manage notes
- **Staff**: Can manage subjects, marks, attendance for all students; can register students; can delete students
- **Admin**: All staff permissions plus ability to register staff/admin; can delete students and staff

Authentication is handled via:
- Login endpoint returns a token and user ID
- Token and User-ID are sent in request headers
- Role-based access control via decorators

Public registration is disabled. Only Admin/Staff can register users via the StaffDashboard `Register` tab.

## 🗄️ Database Schema

**User Table:**
- id, role, email, password, name, student_id, reset_token, reset_token_expiry

**Subject Table:**
- id, subject_name, subject_code, accessed_by

**Marks Table:**
- id, student_id, subject_id, marks, max_marks, accessed_by

**Attendance Table:**
- id, student_id, date, in_time, out_time, subject, attendance, accessed_by

**Notes Table:**
- id, student_id, notes, date

## 🧪 Development Guidelines

### Adding New Features

1. **Backend:**
   - Create model in `models/models.py` if needed
   - Add routes in appropriate `routes/*_routes.py` file
   - Register blueprint in `routes/__init__.py`
   - Add decorators for authentication/authorization
   - When adding email links, use `Config.FRONTEND_BASE_URL` to build frontend URLs

2. **Frontend:**
   - Create component in `components/`
   - Add API calls in `services/api.js`
   - Add styles in component-specific CSS file
   - Update `App.js` to include new routes/components
   - For new public pages (e.g., `ResetPassword`), add unauthenticated routing guards similar to the existing implementation

### Code Style

- **Backend**: Follow PEP 8 Python style guide
- **Frontend**: Use ES6+ JavaScript, functional components with hooks
- **CSS**: Use BEM-like naming conventions, mobile-first approach

### Testing

- Backend: Add unit tests in `tests/` directory
- Frontend: Add component tests using React Testing Library

## 📦 Dependencies

### Backend

- Flask: Web framework
- Flask-SQLAlchemy: ORM for database
- Flask-Mail: Email functionality
- Flask-CORS: Cross-origin resource sharing
- psycopg2-binary: PostgreSQL adapter
- python-dotenv: Environment variable management

### Frontend

- React: UI framework
- lucide-react: Icon library
- axios: HTTP client (used via fetch API)
- No client-side router is used; `App.js` conditionally renders `ResetPassword` based on `window.location.pathname`.

## 🚢 Deployment

### Production Considerations

1. **Environment Variables:**
   - Use secure secrets management
   - Never commit `.env` files
   - Use different credentials for production
   - Set `FRONTEND_BASE_URL` to your public frontend URL so password reset links are correct

2. **Database:**
   - Use managed PostgreSQL service
   - Set up proper backups
   - Configure connection pooling

3. **Security:**
   - Implement JWT tokens instead of simple tokens
   - Use HTTPS
   - Add rate limiting
   - Implement proper CORS policies
   - Add input validation and sanitization

4. **Performance:**
   - Enable database query caching
   - Add Redis for session management
   - Implement API response caching
   - Use CDN for frontend assets

5. **Monitoring:**
   - Add logging (e.g., Python logging, Winston for Node.js)
   - Set up error tracking (Sentry, etc.)
   - Monitor API performance
   - Set up health check endpoints

## 🔧 Troubleshooting

### Backend Issues

- **Database connection errors**: Check PostgreSQL is running and `.env` has correct credentials
- **Import errors**: Ensure virtual environment is activated
- **Port already in use**: Change port in `app.py` or stop conflicting service
- **Password reset 400 errors**: Ensure frontend sends `{ token, new_password }` and not `{ token, newPassword }`. Confirm `FRONTEND_BASE_URL`.

### Frontend Issues

- **API connection errors**: Check `REACT_APP_API_BASE` in `.env` matches backend URL
- **Build errors**: Clear `node_modules` and reinstall dependencies
- **CORS errors**: Ensure backend CORS is configured correctly
- **Reset password page not loading**: Ensure you navigate to `/reset-password?token=<token>` and that the app is running on the host set in `FRONTEND_BASE_URL`.

## 📝 Future Enhancements

1. **Authentication:**
   - Implement JWT tokens
   - Add OAuth2 support
   - Multi-factor authentication

2. **Features:**
   - File uploads for assignments
   - Real-time notifications
   - Email notifications
   - Calendar integration
   - Grade reports and analytics
   - Student profiles with photos

3. **Technical:**
   - Add unit and integration tests
   - Implement API versioning
   - Add Swagger/OpenAPI documentation
   - Implement caching layer
   - Add search functionality
   - Implement pagination

4. **UI/UX:**
   - Responsive design improvements
   - Dark mode support
   - Accessibility improvements
   - Mobile app version

## 📄 License

This project is provided as-is for educational purposes.

## 👥 Contributing

When contributing to this project:

1. Create a feature branch
2. Make your changes
3. Test thoroughly
4. Submit a pull request with description

## 📞 Support

For issues or questions, please create an issue in the project repository.

---

**Last Updated**: 2024
**Version**: 1.0.0

