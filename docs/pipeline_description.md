# CI/CD Pipeline Description

## CircleCI Pipeline Overview

### Pipeline Trigger
- Trigger: Push to `master` branch
- Location: `.circleci/config.yml`

### Phase 1: Build Job
**Purpose**: Compile and test the application

**Steps:**
1. **Checkout Code**: Fetch latest code from GitHub repository
2. **Update Node.js Version**: Adjust package.json to match Elastic Beanstalk environment (Node.js 20)
3. **Install Dependencies**: 
   - Frontend: `cd udagram-frontend && npm install`
   - Backend: `cd udagram-api && npm install`
4. **Build Applications**:
   - Frontend: Angular production build
   - Backend: TypeScript compilation and packaging
5. **Store Artifacts**: Save build outputs for deployment phase

### Phase 2: Manual Approval (Hold)
**Purpose**: Security gate for controlled deployments

**Process:**
- Build job completes successfully
- Pipeline pauses, waiting for manual approval
- Reviewer checks build logs and artifacts
- Click "Approve" in CircleCI dashboard to continue

### Phase 3: Deploy Job
**Purpose**: Deploy to AWS infrastructure

**Frontend Deployment (S3):**
1. Rebuild frontend for production
2. Upload files to S3 bucket using AWS CLI
3. Set appropriate cache headers (no-cache for index.html)
4. Verify files are accessible

**Backend Deployment (Elastic Beanstalk):**
1. Install AWS EB CLI
2. Initialize Elastic Beanstalk with existing configuration
3. Deploy new application version
4. Monitor deployment status

**Verification:**
1. Test S3 website accessibility
2. Test API endpoint responsiveness
3. Check Elastic Beanstalk environment health

### Environment Variables Management
All sensitive credentials are stored in CircleCI project settings:
- AWS credentials (Access Key, Secret Key)
- Database connection details
- JWT secret and other application secrets
- Region and service configurations