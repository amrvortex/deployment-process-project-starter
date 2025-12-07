# Udagram - Full Stack Application on AWS

This is my final project for the Udacity Full Stack Javascript Nanodegree. The goal was to take a full-stack application and deploy it to AWS with a complete CI/CD pipeline using CircleCI.

## Live Links

- Frontend: http://udagram-frontend-amribrahem-06122025.s3-website-us-east-1.amazonaws.com
- Backend API: http://udagram-api-dev.eba-cpkizpuh.us-east-1.elasticbeanstalk.com

## What This Project Does

Udagram is an image sharing application where users can register, log in, and post images with captions. It's a pretty straightforward app, but the interesting part is how it's deployed and managed in the cloud.

The project demonstrates:
- Deploying a full-stack app to AWS
- Setting up automated CI/CD with CircleCI
- Managing infrastructure across multiple AWS services
- Handling environment variables and secrets securely

## Architecture

The application uses a standard three-tier setup:

- **Frontend**: Angular app hosted as a static website on S3
- **Backend**: Node.js/Express API running on Elastic Beanstalk
- **Database**: PostgreSQL on RDS

I chose S3 for the frontend because it's cheap and easy to set up for static sites. Elastic Beanstalk handles the backend because it takes care of a lot of the infrastructure management automatically. RDS was the obvious choice for the database since it's managed PostgreSQL.

You can find the architecture diagram in the `docs/` folder.

## Platform Note
Due to AWS platform deprecation:
- Udacity requirement: Node.js 12.14-14.15
- Available AWS platforms: Node.js 12 (retired), 20, 22, 24
- Selected: Node.js 20 (only viable non-retired option)
- Application tested and working on Node.js 20

## Tech Stack

**Frontend:**
- Angular
- Ionic
- TypeScript

**Backend:**
- Node.js (v20.0)
- Express
- Sequelize (for database)
- JWT for authentication

**AWS Services:**
- S3 (frontend hosting)
- Elastic Beanstalk (backend)
- RDS PostgreSQL (database)

**DevOps:**
- CircleCI for CI/CD
- AWS CLI for deployments
- Git/GitHub for version control

## Running Locally

If you want to run this on your machine:

### What You Need

- Node v20.0 or similar
- npm 10.x+
- PostgreSQL
- AWS CLI v2
- Git

### Setup Steps

1. Clone the repo and install dependencies:
```bash
git clone <repository-url>
cd udagram

# Install API dependencies
cd udagram/udagram-api
npm install

# Install frontend dependencies
cd ../udagram-frontend
npm install
```

2. Create a `.env` file in `udagram/udagram-api/` with your database credentials:
```
POSTGRES_USERNAME=your_username
POSTGRES_PASSWORD=your_password
POSTGRES_HOST=localhost
POSTGRES_DB=udagram
DB_PORT=5432
PORT=8080
AWS_REGION=us-east-1
AWS_PROFILE=default
AWS_BUCKET=your_bucket_name
URL=http://localhost
JWT_SECRET=your_secret_here
```

3. Start the backend:
```bash
cd udagram/udagram-api
npm run dev
```

4. In another terminal, start the frontend:
```bash
cd udagram/udagram-frontend
npm start
```

The app should open at `http://localhost:4200` and the API runs on `http://localhost:8080`.

## How Deployment Works

The deployment is automated through CircleCI. Here's what happens:

1. I push code to the main branch on GitHub
2. CircleCI picks up the change and starts the pipeline
3. It installs all dependencies for both frontend and backend
4. Builds both applications
5. Waits for manual approval (this was required by the project)
6. Deploys the backend to Elastic Beanstalk
7. Deploys the frontend to S3

The whole process is defined in `.circleci/config.yml`. The manual approval step is there to make sure nothing breaks production accidentally.

### Manual Deployment

If you need to deploy manually without CircleCI:

For the backend:
```bash
cd udagram/udagram-api
npm run build
eb deploy
```

For the frontend:
```bash
cd udagram/udagram-frontend
npm run build
aws s3 sync ./www s3://your-bucket-name --delete
```

## AWS Infrastructure

Here's what I set up on AWS:

| Service | What It Does | Configuration |
|---------|--------------|---------------|
| S3 | Hosts the frontend | Static website hosting, public access |
| Elastic Beanstalk | Runs the backend API | Node.js 20 platform |
| RDS | PostgreSQL database | db.t3.micro instance |
| IAM | Manages permissions | Roles for EB and CircleCI |

### Environment Variables

All the sensitive stuff is stored as environment variables in CircleCI:

- AWS credentials (access key, secret key)
- Database credentials
- JWT secret
- S3 bucket name
- Backend URL

These get injected during the build and deployment process.

## Screenshots

All the required screenshots are in `Documentation/ScreenShots/`:

1. RDS database configuration
2. Elastic Beanstalk environment
3. S3 bucket setup
4. Backend API responding
5. Frontend loading successfully
6. Browser console showing requests
7. CircleCI environment variables
8. CircleCI pipeline success

## Problems I Ran Into

**Node.js Version Issues**

CircleCI was using a different Node version than what I needed. I had to explicitly set it in the config file and use `sed` to update the package.json:
```bash
sed -i 's/"node": ".*"/"node": "14.15.1"/g' package.json
```

**CORS Errors**

This was the biggest headache. The frontend on S3 couldn't talk to the backend on Elastic Beanstalk because of CORS. I had to configure the Express backend to allow requests from the S3 URL:
```javascript
app.use(cors({
  origin: 'http://udagram-frontend-amribrahem-06122025.s3-website-us-east-1.amazonaws.com'
}));
```

**Elastic Beanstalk Deployment Failures**

The EB CLI was being unreliable, so I ended up using the AWS CLI directly for deployments. More verbose but more reliable.

**Environment Variables Not Loading**

Had to double-check that all environment variables were set in both CircleCI and the Elastic Beanstalk environment configuration. Missing even one would break the deployment.

## What I Learned

This project taught me a lot about cloud infrastructure and DevOps practices:

- How to set up and manage AWS services (S3, EB, RDS)
- Building a CI/CD pipeline from scratch
- Managing environment variables across different environments
- Debugging cloud deployments using CloudWatch logs
- The importance of infrastructure as code

The CORS issue was frustrating but taught me a lot about how browsers handle cross-origin requests. I also learned that managed services like Elastic Beanstalk are great but you still need to understand what's happening under the hood when things go wrong.

## What Could Be Better

If I had more time, I'd add:

- HTTPS with CloudFront and SSL certificates
- Better monitoring with CloudWatch alarms
- Automated database migrations
- More comprehensive tests
- Docker containers for consistency
- Infrastructure as Code with Terraform

## Additional Documentation

- `docs/` - Architecture diagrams and detailed documentation
- `Documentation/ScreenShots/` - All the screenshots for verification
- `.circleci/config.yml` - The complete CI/CD pipeline configuration

## Credits

This project was completed as part of the Udacity Cloud DevOps Engineer Nanodegree. Thanks to Udacity for the starter code and project structure, and to the AWS and CircleCI documentation which I referenced constantly while building this.

## License

See [LICENSE.txt](LICENSE.txt) for details.

---

**Note**: This is a student project for educational purposes. It demonstrates DevOps practices but isn't meant for production use without additional security and optimization.

Created by Amr Ibrahem - December 2025
