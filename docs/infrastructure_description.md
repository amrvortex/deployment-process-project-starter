# Infrastructure Description

## AWS Services Architecture

### 1. Amazon S3 - Frontend Hosting
- **Bucket Name**: udagram-frontend-amribrahem-06122025
- **Purpose**: Hosts static Angular/Ionic frontend application
- **Configuration**: 
  - Static website hosting enabled
  - Public read access via bucket policy
  - CORS configured to allow requests from the frontend
- **URL**: http://udagram-frontend-amribrahem-06122025.s3-website-us-east-1.amazonaws.com

### 2. AWS Elastic Beanstalk - Backend API
- **Application**: udagram-api
- **Environment**: udagram-api-dev
- **Platform**: Node.js 20 running on 64bit Amazon Linux 2023
- **Purpose**: Hosts Node.js/Express REST API
- **URL**: http://udagram-api-dev.eba-cpkizpuh.us-east-1.elasticbeanstalk.com

### 3. Amazon RDS - Database
- **Engine**: PostgreSQL
- **Instance**: db.t3.micro (Free Tier eligible)
- **Purpose**: Stores application data (users, posts, metadata)
- **Connection**: Securely connected to Elastic Beanstalk backend

### 4. Service Communication Flow
1. User → S3 Bucket (loads frontend)
2. Frontend → Elastic Beanstalk (API requests)
3. Elastic Beanstalk → RDS (database queries)
4. RDS → Elastic Beanstalk (data responses)
5. Elastic Beanstalk → Frontend (API responses)

### 5. Security Considerations
- All credentials stored in CircleCI environment variables
- No hard-coded secrets in source code
- Database connection via environment variables
- S3 bucket policy restricts access appropriately