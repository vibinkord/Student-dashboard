docker rm -f student_backend student_db student_frontend
docker rmi -f vibin_proj-backend:latest vibin_proj-frontend:latest postgres:15-alpine 
docker-compose up