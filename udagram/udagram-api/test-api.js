// Simple API test script
const http = require('http');

const tests = [
  { name: 'Root endpoint', path: '/' },
  { name: 'API v0 root', path: '/api/v0/' },
  { name: 'Feed endpoint', path: '/api/v0/feed' },
  { name: 'Auth endpoint', path: '/api/v0/users/auth' }
];

function testEndpoint(test) {
  return new Promise((resolve) => {
    const options = {
      hostname: 'localhost',
      port: 8080,
      path: test.path,
      method: 'GET'
    };

    const req = http.request(options, (res) => {
      let data = '';
      res.on('data', (chunk) => { data += chunk; });
      res.on('end', () => {
        console.log(`✓ ${test.name}: ${res.statusCode} - ${data.substring(0, 50)}`);
        resolve();
      });
    });

    req.on('error', (e) => {
      console.log(`✗ ${test.name}: ${e.message}`);
      resolve();
    });

    req.end();
  });
}

async function runTests() {
  console.log('Testing udagram-api endpoints...\n');
  for (const test of tests) {
    await testEndpoint(test);
  }
  console.log('\nAll tests completed!');
}

runTests();
