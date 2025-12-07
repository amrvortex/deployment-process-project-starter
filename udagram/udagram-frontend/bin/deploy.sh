#!/bin/bash
# Frontend deployment script for Udagram project
# This script deploys the built frontend to AWS S3

echo "Starting frontend deployment to S3..."

# Set the S3 bucket name
S3_BUCKET="udagram-frontend-amribrahem-06122025"

# Upload all files from www folder to S3 with public read access
echo "Uploading static files to S3 bucket: $S3_BUCKET"
aws s3 cp --recursive --acl public-read ./www s3://$S3_BUCKET/

# Upload index.html with specific cache control to prevent caching issues
echo "Setting cache headers for index.html"
aws s3 cp --acl public-read \
    --cache-control="max-age=0, no-cache, no-store, must-revalidate" \
    ./www/index.html s3://$S3_BUCKET/

echo "Frontend Deployment completed successfully!"
echo "Frontend is available at: http://$S3_BUCKET.s3-website-us-east-1.amazonaws.com"