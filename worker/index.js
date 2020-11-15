const keys = require('./keys');
const redis = require('redis');

const redisClient = redis.createClient({
    host: keys.redisHost,
    port: keys.redisPort,
    retry_strategy: () => 1000
});
const sub = redisClient.duplicate();

function fib(index) {
    console.log('calculating stuff')
    if (index < 2) return 1;
    const result = fib(index - 1) + fib(index - 2);
    console.log('Result');
    return result;
}

sub.on('message', (channel, message) => {
    console.log('Receiving message', message);
    redisClient.hset('values', message, fib(parseInt(message)));
});
sub.subscribe('insert');
