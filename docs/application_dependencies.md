# Application Dependencies

## Frontend Application (udagram-frontend)
**Framework**: Angular 8.2.14 with Ionic 4.1.0

**Runtime Dependencies:**
- @angular/* (various Angular modules)
- @ionic/angular: 4.1.0
- rxjs: ~6.5.4 (Reactive Extensions)
- zone.js: ~0.9.1 (Angular change detection)

**Build Dependencies:**
- @angular/cli: ~8.3.25
- @angular/compiler-cli: ~8.2.14
- typescript: ^3.5.3

**Node.js Version**: Compatible with 14.15.0 (build) and 20.x (deployment)

## Backend API (udagram-api)
**Framework**: Node.js with Express 4.16.4

**Runtime Dependencies:**
- express: ^4.16.4 (Web framework)
- sequelize: ^6.26.0 (ORM for PostgreSQL)
- pg: ^8.7.1 (PostgreSQL driver)
- aws-sdk: ^2.429.0 (AWS services integration)
- jsonwebtoken: ^8.5.1 (Authentication)
- bcryptjs: 2.4.3 (Password hashing)

**Development Dependencies:**
- typescript: ^4.2.3
- @types/node: ^11.11.6
- ts-node-dev: ^1.0.0-pre.32 (Development server)
- mocha: ^6.1.4 (Testing framework)

**Node.js Version**: >=20.0.0 (matches Elastic Beanstalk environment)

## Infrastructure Dependencies
**AWS CLI**: Version 2 for deployment commands
**EB CLI**: Elastic Beanstalk Command Line Interface
**CircleCI Orbs**: 
- circleci/node@5.0.2 (Node.js setup)
- circleci/aws-cli@3.1.1 (AWS CLI setup)

## Environment Variables Required