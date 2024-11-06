#!/usr/bin/env node

const fetch = require('node-fetch');

const url = process.argv[2];

if (!url) {
    console.error('usage: link_test.js url');
    process.exit(1);
}

test(url);

async function test(url) {
    const data = test_fetch(url);
}

async function test_fetch(url) {
    try {
        const res = await fetch(url);

        if (! res.ok) {
            console.log(`FAILED - HTTP error code: ${res.status}`);
            process.exit(2);
        }

        return await res.text();
    }
    catch (e) {
        console.log("FAILED - fetch crashed");
        process.exit(2);
    }
}