#!/bin/bash

# Debug script for AWS credentials in CircleCI

echo "========================================="
echo "AWS Credentials Debug Information"
echo "========================================="
echo ""

# Check if environment variables are set
echo "1. Environment Variables Check:"
echo "   AWS_ACCESS_KEY_ID: $(if [ -n "$AWS_ACCESS_KEY_ID" ]; then echo "SET (${#AWS_ACCESS_KEY_ID} chars, starts with: ${AWS_ACCESS_KEY_ID:0:4}****)"; else echo "NOT SET"; fi)"
echo "   AWS_SECRET_ACCESS_KEY: $(if [ -n "$AWS_SECRET_ACCESS_KEY" ]; then echo "SET (${#AWS_SECRET_ACCESS_KEY} chars)"; else echo "NOT SET"; fi)"
echo "   AWS_DEFAULT_REGION: $(if [ -n "$AWS_DEFAULT_REGION" ]; then echo "$AWS_DEFAULT_REGION"; else echo "NOT SET"; fi)"
echo ""

# Check AWS CLI version
echo "2. AWS CLI Version:"
aws --version
echo ""

# Check AWS configuration files
echo "3. AWS Configuration Files:"
if [ -f ~/.aws/credentials ]; then
    echo "   ~/.aws/credentials: EXISTS"
else
    echo "   ~/.aws/credentials: NOT FOUND"
fi

if [ -f ~/.aws/config ]; then
    echo "   ~/.aws/config: EXISTS"
else
    echo "   ~/.aws/config: NOT FOUND"
fi
echo ""

# Try to get caller identity
echo "4. AWS STS Get Caller Identity:"
if aws sts get-caller-identity 2>&1; then
    echo "   ✓ Successfully authenticated with AWS"
else
    echo "   ✗ Failed to authenticate with AWS"
    echo ""
    echo "   Common issues:"
    echo "   - Access Key ID is incorrect or not set"
    echo "   - Secret Access Key is incorrect or not set"
    echo "   - Credentials have expired (for temporary credentials)"
    echo "   - IAM user doesn't have necessary permissions"
fi
echo ""

echo "========================================="
