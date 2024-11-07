#!/usr/bin/env node

const fetch = require('node-fetch');

const USER_AGENT="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36";

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
        const res = await fetch(url, {
            'Host': 'www.nytimes.com',
            'Accept': '*/*',
            'User-Agent': USER_AGENT
        });

        if (! res.ok) {
            console.log(`${url} : FAILED - HTTP ${res.status}`);
            console.error(await res.text());
            process.exit(2);
        }

        console.log(`${url} : OK - HTTP ${res.status}`);

        return await res.text();
    }
    catch (e) {
        console.log(`${url} : FAILED - fetch crashed`);
        process.exit(2);
    }
}